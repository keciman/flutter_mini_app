import 'package:bloc/bloc.dart';
import 'package:exchange_rate_prices/data/model/exchange_rate.dart';
import 'package:exchange_rate_prices/network/exchange_rate_service.dart';
import 'package:meta/meta.dart';

part 'download_exchange_rates_event.dart';

part 'download_exchange_rates_state.dart';

class DownloadExchangeRatesBloc extends Bloc<DownloadExchangeRatesEvent, DownloadExchangeRatesState> {
  final ExchangeRateService ratesService;

  DownloadExchangeRatesBloc({required this.ratesService}) : super(DownloadExchangeRatesInitial()) {
    on<FetchExchangeRates>(handleFetchExchangeRates);
  }

  Future<void> handleFetchExchangeRates(FetchExchangeRates event, Emitter<DownloadExchangeRatesState> emit) async {
    emit(DownloadExchangeRatesLoading());
    try {
      final networkResult = await ratesService.fetchExchangeRates(historyLength: event.historyLength);
      if(networkResult.errorMessage!=null)
      {
        emit(DownloadExchangeRatesFailed(networkResult.errorMessage!));
        return;
      }

      emit(DownloadExchangeRatesLoaded(networkResult.result!));
    } catch (e) {
      emit(DownloadExchangeRatesFailed(e.toString()));
    }
  }
}
