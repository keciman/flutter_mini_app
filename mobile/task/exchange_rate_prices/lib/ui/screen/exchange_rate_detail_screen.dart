import 'package:exchange_rate_prices/network/exchange_rate_service.dart';
import 'package:exchange_rate_prices/state/bloc/download_exchange_rate/download_exchange_rate_bloc.dart';
import 'package:exchange_rate_prices/ui/color_palette.dart';
import 'package:exchange_rate_prices/ui/widget/cross_hair_chart.dart';
import 'package:exchange_rate_prices/ui/widget/custom_icon_button.dart';
import 'package:exchange_rate_prices/ui/widget/custom_loader.dart';
import 'package:exchange_rate_prices/ui/widget/error_label.dart';
import 'package:exchange_rate_prices/util/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ExchangeRateDetailScreen extends StatefulWidget {
  final String code;

  const ExchangeRateDetailScreen({required this.code, super.key});

  @override
  State<ExchangeRateDetailScreen> createState() => _ExchangeRateDetailState();
}

class _ExchangeRateDetailState extends State<ExchangeRateDetailScreen> {
  late final exchangeRatesService = context.read<ExchangeRatesService>();
  late final DownloadExchangeRateBloc rateBloc = DownloadExchangeRateBloc(ratesService: exchangeRatesService);

  @override
  void initState() {
    super.initState();
    rateBloc.add(FetchExchangeRate(widget.code));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          onTap: () {
            Navigator.of(context).pop();
          },
          iconData: Icons.arrow_back_outlined,
        ),
        title: Text(
          'Exchange rate - ${widget.code.currencyFromCode()} ${widget.code}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorPalette.primaryColor,
        actions: [
          CustomIconButton(
            iconData: Icons.refresh,
            onTap: () {
              rateBloc.add(FetchExchangeRate(widget.code));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: BlocBuilder<DownloadExchangeRateBloc, DownloadExchangeRateState>(
          bloc: rateBloc,
          builder: (context, state) {
            if (state is DownloadExchangeRateLoading) {
              return const CustomLoader();
            } else if (state is DownloadExchangeRateLoaded) {
              if (state.rate == null) {
                return Center(child: Padding(padding: EdgeInsets.all(1.h), child: const Text('No exchange rate information')));
              }

              return Column(
                children: [SizedBox(height: 1.h), Text(state.rate!.description ?? '-'), SizedBox(height: 2.h), CrossHairChart(values: state.rate!.rates)],
              );
            } else if (state is DownloadExchangeRateFailed) {
              return ErrorLabel(errorText: state.error);
            }

            return Container();
          },
        ),
      ),
    );
  }
}
