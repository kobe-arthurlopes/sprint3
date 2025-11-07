abstract class ApiServiceProtocol {
  Future<T> fetchResponse<T>({
    String endpoint, 
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? properties
  });
}