part of 'download_exchange_rates_bloc.dart';

@immutable
abstract class DownloadExchangeRatesState {}

class DownloadExchangeRatesInitial extends DownloadExchangeRatesState {}

class DownloadExchangeRatesLoading extends DownloadExchangeRatesState {}

class DownloadExchangeRatesLoaded extends DownloadExchangeRatesState {
  final List<ExchangeRate> currencies;

  DownloadExchangeRatesLoaded(this.currencies);
}

class DownloadExchangeRatesFailed extends DownloadExchangeRatesState {
  final String error;

  DownloadExchangeRatesFailed(this.error);
}
