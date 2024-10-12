import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:martify/bloc/bottom_navbar/bottom_navbar_bloc.dart';
import 'package:martify/components/bottom_nav_menu.dart';
import 'package:martify/utils/common/styles/spacing_style.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({
    super.key,
    required this.orderNumber,
  });
  final String orderNumber;

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final DateTime estimatedDeliveryStart =
        currentDate.add(const Duration(days: 6));
    final DateTime estimatedDeliveryEnd =
        currentDate.add(const Duration(days: 7));
    // Format dates for display using intl package
    final deliveryStartFormatted =
        DateFormat('MMM d').format(estimatedDeliveryStart);
    final deliveryEndFormatted =
        DateFormat('MMM d').format(estimatedDeliveryEnd);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MSpacingStyle.paddingWithAppBarHeight * 1,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 10,
              ),
              Lottie.asset(
                'assets/icons/payment_methods/animatedordersuccess.json',
                width: MHelperFunctions.screenwidth(context) / 2.7,
              ),
              const SizedBox(height: MSizes.spacerBtwSections),
              Text(
                "Order Placed Successfully!",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              Text(
                "Thank you for shopping with us! Your order has been successfully placed. We'll send you an update when your items are on the way. Please Note Your Order Number $orderNumber",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              Text(
                "You can expect to receive your items between $deliveryStartFormatted and $deliveryEndFormatted.",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MSizes.spacerBtwSections),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<BottomNavbarBloc>()
                            .add(const ChangeMenu(index: 0));
                        MHelperFunctions.mostStrictAnimationNavigation(
                            context, const BottomNavMenu());
                      },
                      child: const Text("Continue Shopping"))),
            ],
          ),
        ),
      ),
    );
  }
}
