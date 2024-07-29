final class CacheConfig {
  final String cacheKey;
  final Duration? maxAge;
  final DateTime? expiryTime;
  final String fileExtension;

  CacheConfig({
    required this.cacheKey,
    this.maxAge,
    this.expiryTime,
    this.fileExtension = '.json',
  }) : assert(maxAge != null || expiryTime != null,
            'maxAge 혹은 expiryTime 둘 중 하나는 반드시 정의');
}
