import 'package:exchange_rate_prices/ui/color_palette.dart';
import 'package:flutter/material.dart';

class GrowthIndicatingText extends StatelessWidget {
  final double activeRate;
  final double pastRate;

  const GrowthIndicatingText({required this.activeRate, required this.pastRate, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${createSign()}${createPercents()}',
      style: TextStyle(color: createColor()),
      textAlign: TextAlign.right,
    );
  }

  // 💡 If more properties would arise data class would come in handy
  String createSign() {
    if (activeRate > pastRate) {
      return '+';
    } else if (pastRate > activeRate) {
      return '-';
    }

    return '';
  }

  String createPercents() {
    if (activeRate == 0.0 || pastRate == 0.0) {
      return '-';
    }

    double change = ((activeRate - pastRate) / pastRate) * 100;

    if (change > 0) {
      return '${change.toStringAsFixed(2)}%';
    } else if (change < 0) {
      return '${(-change).toStringAsFixed(2)}%';
    }

    return '0';
  }

  Color createColor() {
    if (activeRate > pastRate) {
      return ColorPalette.increase;
    } else if (pastRate > activeRate) {
      return ColorPalette.decrease;
    }

    return ColorPalette.stale;
  }
}
