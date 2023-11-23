import 'package:bloc/bloc.dart';
import 'package:exchange_rate_prices/data/model/exchange_rate.dart';
import 'package:exchange_rate_prices/network/exchange_rate_service.dart';
import 'package:meta/meta.dart';

part 'download_exchange_rate_event.dart';

part 'download_exchange_rate_state.dart';

class DownloadExchangeRateBloc extends Bloc<DownloadExchangeRateEvent, DownloadExchangeRateState> {
  final ExchangeRatesService ratesService;

  DownloadExchangeRateBloc({required this.ratesService}) : super(DownloadExchangeRateInitial()) {
    on<FetchExchangeRate>(handleFetchExchangeRates);
  }

  Future<void> handleFetchExchangeRates(FetchExchangeRate event, Emitter<DownloadExchangeRateState> emit) async {
    emit(DownloadExchangeRateLoading());
    try {
      final networkResult = await ratesService.fetchExchangeRate(event.code, historyLength: event.historyLength);
      if(networkResult.errorMessage!=null)
        {
          emit(DownloadExchangeRateFailed(networkResult.errorMessage!));
          return;
        }

      emit(DownloadExchangeRateLoaded(networkResult.result));
    } catch (e) {
      emit(DownloadExchangeRateFailed(e.toString()));
    }
  }
}
