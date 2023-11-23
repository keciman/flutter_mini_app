import 'package:exchange_rate_prices/data/model/exchange_rate.dart';
import 'package:exchange_rate_prices/network/network_result.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

// Idea 💡 the functions could be merged into one generic if there is more than 2 and the logic is still similar
class ExchangeRatesService {
  final GraphQLClient client;

  const ExchangeRatesService({required this.client});


  Future<NetworkResult<List<ExchangeRate>>> fetchExchangeRates({int? historyLength}) async {
    String readExchangeRatesQuery = r'''
    query GetExchangeRates($historyLength: Float) {
      exchangeRates(historyLength: $historyLength) {
        code
        rates
      }
    }
  ''';

    final QueryOptions options = QueryOptions(
      document: gql(readExchangeRatesQuery),
      variables: {
        'historyLength': historyLength?.toDouble(),
      },
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      final exceptionString = result.exception.toString();
      debugPrint(exceptionString);
      return NetworkResult(errorMessage: exceptionString);
    }

    List<dynamic> fetchedRates = result.data?['exchangeRates'] ?? [];
    final exchangeRates = fetchedRates.map((rateData) => ExchangeRate.fromJson(rateData)).toList();
    return NetworkResult<List<ExchangeRate>>(result: exchangeRates);
  }

  Future<NetworkResult<ExchangeRate?>> fetchExchangeRate(String currencyCode, {double? historyLength}) async {
    String readExchangeRateQuery = r'''
      query GetExchangeRate($code: String!, $historyLength: Float) {
        exchangeRate(code: $code, historyLength: $historyLength) {
          code
          description
          rates
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(readExchangeRateQuery),
      variables: {
        'code': currencyCode,
        if (historyLength != null) // because BE would return just 1 element instead of all
          'historyLength': historyLength,
      },
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      final exceptionString = result.exception.toString();
      debugPrint(result.exception.toString());
      return NetworkResult(errorMessage: exceptionString);
    }

    if (result.data == null) {
      return NetworkResult<ExchangeRate?>(result: null);
    }

    final exchangeRate = ExchangeRate.fromJson(result.data!['exchangeRate']);

    return NetworkResult<ExchangeRate?>(result: exchangeRate);
  }
}
