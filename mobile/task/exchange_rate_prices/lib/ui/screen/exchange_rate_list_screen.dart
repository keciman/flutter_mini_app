import 'package:exchange_rate_prices/data/model/exchange_rate.dart';
import 'package:exchange_rate_prices/network/exchange_rate_service.dart';
import 'package:exchange_rate_prices/state/bloc/download_exchange_rates/download_exchange_rates_bloc.dart';
import 'package:exchange_rate_prices/ui/color_palette.dart';
import 'package:exchange_rate_prices/ui/screen/exchange_rate_detail_screen.dart';
import 'package:exchange_rate_prices/ui/widget/custom_icon_button.dart';
import 'package:exchange_rate_prices/ui/widget/custom_loader.dart';
import 'package:exchange_rate_prices/ui/widget/error_label.dart';
import 'package:exchange_rate_prices/ui/widget/growth_indicating_text.dart';
import 'package:exchange_rate_prices/util/context_extension.dart';
import 'package:exchange_rate_prices/util/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ExchangeRateListScreen extends StatefulWidget {
  const ExchangeRateListScreen({super.key});

  @override
  State<ExchangeRateListScreen> createState() => _ExchangeRateListState();
}

class _ExchangeRateListState extends State<ExchangeRateListScreen> {
  static const int historyLength = 2;
  late final exchangeRatesService = context.read<ExchangeRateService>();
  late final DownloadExchangeRatesBloc ratesBloc = DownloadExchangeRatesBloc(ratesService: exchangeRatesService);

  @override
  void initState() {
    super.initState();
    ratesBloc.add(FetchExchangeRates(historyLength: historyLength));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exchange rate list',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          CustomIconButton(
              onTap: () {
                ratesBloc.add(FetchExchangeRates(historyLength: historyLength));
              },
              iconData: Icons.refresh),
        ],
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: Column(
        children: [
          BlocBuilder<DownloadExchangeRatesBloc, DownloadExchangeRatesState>(
            bloc: ratesBloc,
            builder: (context, state) {
              if (state is DownloadExchangeRatesLoading) {
                return const CustomLoader();
              } else if (state is DownloadExchangeRatesLoaded) {
                return Expanded(
                  child: ExchangeRateListview(exchangeRates: state.currencies),
                );
              } else if (state is DownloadExchangeRatesFailed) {
                return ErrorLabel(errorText: state.error);
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class ExchangeRateListview extends StatelessWidget {
  final List<ExchangeRate> exchangeRates;

  const ExchangeRateListview({required this.exchangeRates, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exchangeRates.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            context.pushMaterial(ExchangeRateDetailScreen(code: exchangeRates[index].code));
          },
          child: Column(
            children: [
              ExchangeRateTile(
                exchangeRate: exchangeRates[index],
              ),
              Container(
                height: 1.0,
                color: ColorPalette.primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ExchangeRateTile extends StatelessWidget {
  final ExchangeRate exchangeRate;

  const ExchangeRateTile({required this.exchangeRate, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      color: ColorPalette.tile,
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
            child: Text('${exchangeRate.code.currencyFromCode()} ${exchangeRate.code}'),
          ),
          Expanded(
            child: Text(
              '🐱 ${exchangeRate.rates.first.toStringAsFixed(8)}',
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: GrowthIndicatingText(
              activeRate: exchangeRate.rates.first,
              pastRate: exchangeRate.rates.last,
            ),
          ),
        ],
      ),
    );
  }
}
