part of 'download_exchange_rates_bloc.dart';

@immutable
abstract class DownloadExchangeRatesEvent {}

class FetchExchangeRates extends DownloadExchangeRatesEvent {
  final int? historyLength;

  FetchExchangeRates({this.historyLength});
}