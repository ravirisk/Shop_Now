class AddressModel {
  String? streetAddress;
  String? city;
  String? state;
  int? postalCode;
  String? country;

  AddressModel({
    this.streetAddress,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  AddressModel copyWith({
    String? streetAddress,
    String? city,
    String? state,
    int? postalCode,
    String? country,
  }) {
    return AddressModel(
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      streetAddress: json['streetAddress'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['streetAddress'] = streetAddress;
    data['city'] = city;
    data['state'] = state;
    data['postalCode'] = postalCode;
    data['country'] = country;
    return data;
  }
}