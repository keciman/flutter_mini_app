extension StringExtension on String {
  String currencyFromCode() {
    switch(this)
    {
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'AUD':
        return 'A\$';
      case 'CAD':
        return 'C\$';
      case 'CHF':
        return '₣';
      default:
        return '-';
    }
  }
}
