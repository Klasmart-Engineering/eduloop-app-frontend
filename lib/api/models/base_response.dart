// https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter

class BaseResponse {
  bool successful;
  String? errmsg;

  BaseResponse({required this.successful, this.errmsg}) {
    validateForErrors();
  }

  factory BaseResponse.fromApiJson(Map<String, dynamic> parsedJson) {
    return BaseResponse(
      successful: parsedJson['successful'],
      errmsg: parsedJson['errmsg'],
    );
  }

  /// The api will use the successful and errmsg fields to let us know something went wrong,
  /// we use this method on construction to check
  void validateForErrors() {
    if (!successful) {
      if (errmsg != null) {
        throw Exception('Api not successful: $errmsg');
      }

      throw Exception('Api response was not successful');
    }
  }
}
