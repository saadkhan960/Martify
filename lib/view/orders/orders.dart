import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Order/order_bloc.dart';
import 'package:martify/utils/common/styles/address_shimmer.dart';
import 'package:martify/utils/common/widgets/Image%20With%20Text/image_with_text.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/view/orders/widgets/orders_list_item.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>().add(FetchOrders(context: context));
    return Scaffold(
      //AppBar
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "My Orders",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      //Body
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        //Orders
        child: BlocBuilder<OrderBloc, OrderState>(
          buildWhen: (previous, current) =>
              previous.allOrders != current.allOrders ||
              previous.isLoading != current.isLoading,
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: AddressShimmer(),
              );
            }
            if (state.nodatafound || state.allOrders.isEmpty) {
              return const ImageWithText(
                imageColor: false,
                image: "assets/images/no_orders.png",
                title: "You Haven't Placed Any Orders Yet",
                secondTile: "Browse our products and place your first order",
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.allOrders.length,
                itemBuilder: (context, index) {
                  return OrdersListItem(order: state.allOrders[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
