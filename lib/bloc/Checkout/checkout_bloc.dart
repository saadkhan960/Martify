import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/Model/payment_method_model.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/helpers/price_calculator.dart';
import 'package:martify/view/Checkout/widgets/payment_tile.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutState()) {
    on<SelectPaymentMethod>(_selectPaymentMethod);
    on<SelectMethod>(_selectMethod);
    on<CalculateTotalAmount>(_calculateTotalAmount);
  }

  void _selectPaymentMethod(
      SelectPaymentMethod event, Emitter<CheckoutState> emit) {
    final checkoutBloc = event.context.read<CheckoutBloc>();
    showModalBottomSheet(
        backgroundColor: MHelperFunctions.isDarkMode(event.context)
            ? MAppColors.dark
            : MAppColors.lightContainer,
        context: event.context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(MSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MSectionHeading(
                      title: "Select Payment Method",
                      showActionButton: false,
                    ),
                    const SizedBox(height: MSizes.defaultSpace),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImages.cod, name: "Cash On Delivery"),
                        checkoutBloc: checkoutBloc),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImages.paypal, name: "PayPal"),
                        checkoutBloc: checkoutBloc),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImages.googlePay, name: "Google Pay"),
                        checkoutBloc: checkoutBloc),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImages.applePay, name: "Apple Pay"),
                        checkoutBloc: checkoutBloc),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImages.visa, name: "Visa"),
                        checkoutBloc: checkoutBloc),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImages.masterCard, name: "Master Card"),
                        checkoutBloc: checkoutBloc),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImages.creditCard, name: "Credit Card"),
                        checkoutBloc: checkoutBloc),
                    const SizedBox(height: MSizes.defaultSpace),
                  ],
                ),
              ),
            ));
  }

  void _selectMethod(SelectMethod event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(selectedPaymentMethod: event.method));
  }

  void _calculateTotalAmount(
      CalculateTotalAmount event, Emitter<CheckoutState> emit) {
    final items = event.context.read<CartBloc>().state.cartItems;
    final totalAmount = MHelperFunctions.calculateTotalAmount(items);
    emit(state.copyWith(totalCartAmount: totalAmount.toString()));
    final shippingfee =
        MPriceCalculator.calculateShippingCost(totalAmount, "US");
    emit(state.copyWith(shippingFee: shippingfee));
    final taxFee = MPriceCalculator.calculateTax(totalAmount, "US");
    emit(state.copyWith(taxFee: taxFee));
    final totalPrice = MPriceCalculator.calculateTotalPrice(totalAmount, "US");
    emit(state.copyWith(orderTotal: totalPrice.toStringAsFixed(2)));
  }
}
