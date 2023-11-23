import 'package:exchange_rate_prices/data/model/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CrossHairChart extends StatelessWidget {
  final List<double> values;

  const CrossHairChart({required this.values, super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
      crosshairBehavior: CrosshairBehavior(enable: true),
      series: <ChartSeries<ChartDataModel, String>>[
        LineSeries<ChartDataModel, String>(
          dataSource: getChartData(values),
          xValueMapper: (ChartDataModel data, _) => data.frequency,
          yValueMapper: (ChartDataModel data, _) => data.value,
        ),
      ],
    );
  }

  List<ChartDataModel> getChartData(List<double> values) {
    final List<ChartDataModel> chartData = [];
    for (int i = 0; i < values.length; i++) {
      chartData.add(ChartDataModel(
        frequency: '$i',
        value: values[i].toInt(),
      ));
    }

    return chartData;
  }
}
