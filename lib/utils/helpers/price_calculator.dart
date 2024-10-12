class MPriceCalculator {
  static String? globalTotalPrice;
// -- Calculate Price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice + taxAmount + shippingCost;
    globalTotalPrice = totalPrice.toStringAsFixed(2).toString();
    return totalPrice;
  }

// -- Calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// -- Calculate tax
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
// Lookup the tax rate for the given location from a tax rate database or API.

// Return the appropriate tax rate.

    return 0.07; //example
  }

  static double getShippingCost(String location) {
// Lookup the shipping cost for the given location using a shipping rate API.

// Calculate the shipping cost based on various factors like distance, weight, etc.
    return 5.00; // Example shipping cost of $5
  }

  /// -- Sum all cart values and return total amount

// static double calculateCartTotal(CartModel cart) {

// return cart.items.map((e) => e.price).fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
//}

  /// -- Calculate product discount
  static String? calculateSalePercentage({
    required double originalPrice,
    double? salePrice,
  }) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;
    if (salePrice >= originalPrice) {
      return "0"; // No discount if sale price is higher or equal
    }

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  //Check product Stock
  static String? getProductStock({required int stock}) {
    return stock > 0 ? "In Stock" : 'Out Of Stock';
  }
}
