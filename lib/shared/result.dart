class Result {
  final bool isSuccess;
  final bool isFailure;
  final String? error;
  final Object? data;
  Result({
    required this.isSuccess,
    required this.isFailure,
    this.error,
    this.data,
  });

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        isSuccess: json["isSuccess"],
        data: json["data"],
        isFailure: json["isFailure"],
        error: json["error"],
      );

  Map<String, dynamic> toMap() {
    return {
      'isSuccess': isSuccess,
      'data': data,
      'isFailure': isFailure,
      'error': error,
    };
  }
}
