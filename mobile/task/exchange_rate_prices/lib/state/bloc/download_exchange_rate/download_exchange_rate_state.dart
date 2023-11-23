part of 'download_exchange_rate_bloc.dart';

@immutable
abstract class DownloadExchangeRateState {}

class DownloadExchangeRateInitial extends DownloadExchangeRateState {}

class DownloadExchangeRateLoading extends DownloadExchangeRateState {}

class DownloadExchangeRateLoaded extends DownloadExchangeRateState {
  final ExchangeRate? rate;

  DownloadExchangeRateLoaded(this.rate);
}

class DownloadExchangeRateFailed extends DownloadExchangeRateState {
  final String error;

  DownloadExchangeRateFailed(this.error);
}