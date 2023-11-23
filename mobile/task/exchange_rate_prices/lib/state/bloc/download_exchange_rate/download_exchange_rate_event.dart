part of 'download_exchange_rate_bloc.dart';

@immutable
abstract class DownloadExchangeRateEvent {}

class FetchExchangeRate extends DownloadExchangeRateEvent {
  final String code;
  final double? historyLength;

  FetchExchangeRate(this.code, {this.historyLength});
}
