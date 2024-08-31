import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:blueberry_flutter_template/utils/AppStrings.dart';

final class CacheService {
  final CacheManager _cacheManager;
  CacheService._internal(this._cacheManager);

  static final instance = CacheService._internal(
    CacheManager(
      Config(
        AppStrings.commonCacheKey, // 캐시 파일 공통 키
        maxNrOfCacheObjects: 200, // 캐시에 저장할 수 있는 최대 객체 수
      ),
    ),
  );

  /// 캐시된 데이터를 가져오는 메서드
  ///
  /// [config] : 캐시 설정
  /// 반환 값 : 캐시된 데이터가 유효한 경우 문자열 데이터를 반환, 그렇지 않으면 null 반환
  Future<String?> getCachedData(CacheConfig config) async {
    final fileInfo = await _getFileInfo(config.cacheKey);
    if (fileInfo != null) {
      if (_isFileValid(fileInfo, config)) {
        return _readFile(fileInfo);
      } else {
        // 파일이 오래된 경우 캐시에서 파일을 제거
        await deleteCachedData(config.cacheKey);
      }
    }
    return null;
  }

  /// 데이터를 캐시에 저장하는 메서드
  ///
  /// [config] : 캐시 설정
  /// [data] : 저장할 문자열 데이터
  Future<void> cacheData(CacheConfig config, String data) async {
    // 문자열 데이터를 바이트 배열로 인코딩
    final bytes = Uint8List.fromList(utf8.encode(data));
    // 주어진 캐시 키로 파일에 데이터를 저장
    await _cacheManager.putFile(
      config.cacheKey,
      bytes,
      fileExtension: config.fileExtension, // 파일 확장자
    );
  }

  /// 특정 캐시를 삭제하는 메서드
  ///
  /// [cacheKey] : 캐시 키를 기반으로 캐시 데이터를 삭제
  Future<void> deleteCachedData(String cacheKey) async {
    await _cacheManager.removeFile(cacheKey);
  }

  /// 전체 캐시 데이터를 삭제하는 메서드
  Future<void> clearAllCache() async {
    await _cacheManager.emptyCache();
  }

  /// 파일 정보를 가져오는 유틸리티 메서드
  ///
  /// [cacheKey] : 캐시에서 파일 정보를 찾기 위한 키
  /// 반환 값 : 파일 정보를 담은 FileInfo 객체
  Future<FileInfo?> _getFileInfo(String cacheKey) async {
    return await _cacheManager.getFileFromCache(cacheKey);
  }

  /// 파일의 유효성을 검사하는 유틸리티 메서드
  ///
  /// [fileInfo] : 유효성을 검사할 파일 정보
  /// [config] : 캐시 설정
  /// 반환 값 : 파일이 유효한 경우 true, 그렇지 않으면 false
  bool _isFileValid(FileInfo fileInfo, CacheConfig config) {
    if (config.maxAge != null) {
      final fileAge = DateTime.now().difference(fileInfo.validTill);
      if (fileAge > config.maxAge!) {
        return false;
      }
    }
    if (config.expiryTime != null) {
      final now = DateTime.now().toUtc();
      if (now.isAfter(config.expiryTime!)) {
        return false;
      }
    }
    return true;
  }

  /// 파일을 읽어 문자열로 반환하는 유틸리티 메서드
  ///
  /// [fileInfo] : 읽을 파일 정보
  /// 반환 값 : 파일의 바이트 데이터를 디코딩한 문자열
  Future<String?> _readFile(FileInfo fileInfo) async {
    final bytes = await fileInfo.file.readAsBytes();
    return utf8.decode(bytes);
  }
}

/// 캐시 설정을 위한 클래스
///
/// [cacheKey] : 캐시에서 파일을 찾기 위한 키
/// [maxAge] : 파일의 최대 저장 기간, 이 기간이 지나면 파일 무효화
/// [expiryTime] : 파일의 만료 시간, 이 시간이 지나면 파일 무효화
/// [fileExtension] : 파일의 확장자, 기본값은 '.json'
final class CacheConfig {
  final String cacheKey;
  final Duration? maxAge;
  final DateTime? expiryTime;
  final String fileExtension;

  /// 생성자
  ///
  /// [cacheKey] : 캐시 키 (필수)
  /// [maxAge] : 최대 저장 기간 (선택)
  /// [expiryTime] : 만료 시간 (선택)
  /// [fileExtension] : 파일 확장자 (선택, 기본값은 '.json')
  CacheConfig({
    required this.cacheKey,
    this.maxAge,
    this.expiryTime,
    this.fileExtension = '.json',
  }) : assert(maxAge != null || expiryTime != null,
            'maxAge 혹은 expiryTime 둘 중 하나는 반드시 정의');
}
