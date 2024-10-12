part of 'checkout_bloc.dart';

class CheckoutState extends Equatable {
  final PaymentMethodModel selectedPaymentMethod;
  final String totalCartAmount;
  final String taxFee;
  final String shippingFee;
  final String orderTotal;

  CheckoutState(
      {this.totalCartAmount = '',
      this.orderTotal = '',
      this.shippingFee = '',
      this.taxFee = '',
      PaymentMethodModel? selectedPaymentMethod})
      : selectedPaymentMethod = selectedPaymentMethod ??
            PaymentMethodModel(image: MImages.cod, name: "Cash On Delivery");

  CheckoutState copyWith({
    PaymentMethodModel? selectedPaymentMethod,
    String? totalCartAmount,
    String? taxFee,
    String? shippingFee,
    String? orderTotal,
  }) {
    return CheckoutState(
        totalCartAmount: totalCartAmount ?? this.totalCartAmount,
        taxFee: taxFee ?? this.taxFee,
        shippingFee: shippingFee ?? this.shippingFee,
        orderTotal: orderTotal ?? this.orderTotal,
        selectedPaymentMethod:
            selectedPaymentMethod ?? this.selectedPaymentMethod);
  }

  @override
  List<Object> get props =>
      [selectedPaymentMethod, totalCartAmount, taxFee, shippingFee, orderTotal];
}
