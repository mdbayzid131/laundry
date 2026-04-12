class FaqModel {
  final bool? success;
  final String? message;
  final List<FaqItemData>? data;

  FaqModel({this.success, this.message, this.data});

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<FaqItemData>.from(json['data'].map((x) => FaqItemData.fromJson(x)))
          : [],
    );
  }
}

class FaqItemData {
  final String? id;
  final String? question;
  final String? answer;
  final bool? isActive;

  FaqItemData({this.id, this.question, this.answer, this.isActive});

  factory FaqItemData.fromJson(Map<String, dynamic> json) {
    return FaqItemData(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      isActive: json['isActive'],
    );
  }
}
