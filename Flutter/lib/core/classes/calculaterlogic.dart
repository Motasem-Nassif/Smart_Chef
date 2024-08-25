class UnitConverter {
  static double gramsToTablespoons(String ingredient, double grams) {
    switch (ingredient) {
      case 'flour':
        return grams * 0.064;
      case 'sugar':
        return grams * 0.08;
      case 'butter':
        return grams * 0.07;
      case 'oil':
        return grams * 0.074;
      case 'milk':
        return grams * 0.067;
      default:
        return 0.0;
    }
  }

  static double gramsToTeaspoons(String ingredient, double grams) {
    switch (ingredient) {
      case 'flour':
        return grams * 0.21;
      case 'sugar':
        return grams * 0.24;
      case 'butter':
        return grams * 0.21;
      case 'oil':
        return grams * 0.22;
      case 'milk':
        return grams * 0.21;
      default:
        return 0.0;
    }
  }

  static double gramsToCups(String ingredient, double grams) {
    switch (ingredient) {
      case 'flour':
        return grams / 120;
      case 'sugar':
        return grams / 200;
      case 'butter':
        return grams / 227;
      case 'oil':
        return grams / 218;
      case 'milk':
        return grams / 240;
      default:
        return 0.0;
    }
  }
}
