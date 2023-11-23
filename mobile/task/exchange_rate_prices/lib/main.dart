import 'package:exchange_rate_prices/ui/exchange_rate_app.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final HttpLink httpLink = HttpLink(
    'http://10.0.2.2:4000/graphql', // the IP is there for emulator instead of "localhost"
  );
  late final GraphQLClient graphQLClient = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

  runApp(ExchangeRateApp(graphQLClient: graphQLClient));
}
