import 'package:exchange_rate_prices/network/exchange_rate_service.dart';
import 'package:exchange_rate_prices/ui/screen/exchange_rate_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ExchangeRateApp extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const ExchangeRateApp({required this.graphQLClient, super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          Provider<ExchangeRateService>(
            create: (_) => ExchangeRateService(client: graphQLClient),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Exchange rate app',
          home: ExchangeRateListScreen(),
        ),
      );
    });
  }
}
