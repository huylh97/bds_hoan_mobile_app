class ResultApiModel {
  final bool success;
  final String message;
  final Map<String, dynamic> data;
  final int? statusCode;

  ResultApiModel({
    required this.success,
    required this.message,
    this.data = const {},
    this.statusCode,
  });

  factory ResultApiModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('statusCode') && json['statusCode'] == 200) {
      if (json.containsKey('data')) {
        return ResultApiModel(
          success: true,
          statusCode: json['statusCode'],
          message: json['message'] ?? '',
          data: json['data'] == null
              ? {}
              : json['data'] is Map<String, dynamic>
                  ? json['data']
                  : {'result': json['data']},
        );
      }
      if (json.containsKey('success')) {
        return ResultApiModel(
          success: json['success'],
          statusCode: json['statusCode'],
          message: json['message'] ?? '',
          data: json['data'] ?? {},
        );
      }
      return ResultApiModel(
        success: true,
        statusCode: json['statusCode'],
        message: json['message'] ?? '',
        data: {},
      );
    }

    return ResultApiModel(
      success: false,
      statusCode: json['statusCode'],
      message: json['message'] ?? '',
      data: {},
    );
  }
}
