import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:blueberry_flutter_template/services/cache/CacheConfig.dart';

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
        await _cacheManager.removeFile(config.cacheKey);
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
