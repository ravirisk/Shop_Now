class PaymentModel {
  int? paymentId;
  int? token;
  int? lastFourDigit;
  String? paymentType;

  PaymentModel({
    this.paymentId,
    this.token,
    this.lastFourDigit,
    this.paymentType,
  });

  PaymentModel copyWith({
    int? paymentId,
    int? token,
    int? lastFourDigit,
    String? paymentType,
  }) {
    return PaymentModel(
      paymentId: paymentId ?? this.paymentId,
      token: token ?? this.token,
      lastFourDigit: lastFourDigit ?? this.lastFourDigit,
      paymentType: paymentType ?? this.paymentType,
    );
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentId: json['paymentId'],
      token: json['token'],
      lastFourDigit: json['lastFourDigit'],
      paymentType: json['paymentType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentId'] = paymentId;
    data['token'] = token;
    data['lastFourDigit'] = lastFourDigit;
    data['paymentType'] = paymentType;
    return data;
  }

}