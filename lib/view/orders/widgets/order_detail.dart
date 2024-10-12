import 'package:flutter/material.dart';
import 'package:martify/Model/Order%20Model/order_model.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/orders/widgets/order_billing_address_section.dart';
import 'package:martify/view/orders/widgets/order_billing_amount_section.dart';
import 'package:martify/view/orders/widgets/order_billing_payment_section.dart';
import 'package:martify/view/orders/widgets/order_products_section.dart';
import 'package:martify/view/orders/widgets/order_status_section.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key, required this.orderDetai});
  final OrderModel orderDetai;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          orderDetai.orderId,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.sm),
          child: Column(
            children: [
              MRoundedContainer(
                borderColor: dark ? MAppColors.darkerGrey : MAppColors.grey,
                padding: const EdgeInsets.all(MSizes.md),
                showBorder: true,
                backgroundColor: dark ? MAppColors.black : MAppColors.white,
                child: Column(
                  children: [
                    OrderStatusSection(order: orderDetai),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    //Divider
                    Divider(
                      color: dark ? MAppColors.darkerGrey : MAppColors.grey,
                    ),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    //Pricing
                    OrderBillingAddressSection(
                      userAddress: orderDetai.address!,
                    ),

                    const SizedBox(height: MSizes.spaceBtwItems),
                    //Divider
                    Divider(
                      color: dark ? MAppColors.darkerGrey : MAppColors.grey,
                    ),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    //Payment Methods
                    OrderBillingPaymentSection(
                      paymentMethod: orderDetai.paymentMethod,
                    ),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    //Divider
                    Divider(
                      color: dark ? MAppColors.darkerGrey : MAppColors.grey,
                    ),
                    //Address
                    OrderBillingAmountSection(
                      totalCartAmount: orderDetai.cartTotal!,
                      shippingFee: orderDetai.shippingFee!,
                      taxFee: orderDetai.taxFee!,
                      orderTotal: orderDetai.totalAmount,
                    ),
                    //Divider
                    Divider(
                      color: dark ? MAppColors.darkerGrey : MAppColors.grey,
                    ),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    const MSectionHeading(
                      title: "Order Products",
                      showActionButton: false,
                    ),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    OrderProductsSection(products: orderDetai.items)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
