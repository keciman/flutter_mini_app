class ExchangeRate {
  final String code;
  final String? description;
  final List<double> rates;

  ExchangeRate({
    required this.code,
    this.description,
    required this.rates,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      code: json['code'] as String,
      description: json['description'] as String?,
      rates: (json['rates'] as List<double>).map((e) => e).toList(),
    );
  }
}