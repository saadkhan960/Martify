import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/Data/order%20repository/order_repo.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/Model/Order%20Model/order_model.dart';
import 'package:martify/bloc/Addresses/address_bloc.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/bloc/Checkout/checkout_bloc.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/internet%20Exceptions/connectivity_services.dart';
import 'package:martify/utils/popups/full_screen_loader.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';
import 'package:martify/view/Checkout/widgets/order_success_Screen.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderState()) {
    on<AddOrder>(_addOrder);
    on<FetchOrders>(_fetchOrders);
  }
  void _addOrder(AddOrder event, Emitter<OrderState> emit) async {
    try {
      // first check user has any selected address or not
      final addressBloc = event.context.read<AddressBloc>().state;
      if (addressBloc.selectedAddress.isEmpty()) {
        SnackbarService.showError(
            context: event.context, message: "Please Add Address");
        return;
      }
      // Start Loading-------------
      FullScreenLoader.show(event.context, lottieAsset: MImages.docerAnimation);

      //Check Internet Connectivity---------
      ConnectivityService connectivityService =
          ConnectivityService(event.context);
      final bool isConnected = await connectivityService.checkConnectivity();
      if (!isConnected) {
        FullScreenLoader.hide(event.context);
        SnackbarService.showError(
            context: event.context, message: "No Internet Connect");
        return;
      }
      //get current user uid
      final String userId = AuthenticationRepository.getUserId();
      if (userId.isEmpty) {
        SnackbarService.showError(
            context: event.context,
            message: "User Session Is Expired. Please Login again");
        return;
      }
      //generate order number
      String idString = MHelperFunctions.randomOrderNumber();

      //get access bloc values
      final checkoutBloc = event.context.read<CheckoutBloc>().state;
      final cartBloc = event.context.read<CartBloc>();

      // create model for store in firebase databse
      final order = OrderModel(
          orderId: idString,
          cartTotal: checkoutBloc.totalCartAmount,
          userId: userId,
          status: "Pending",
          items: cartBloc.state.allCartItems,
          paymentMethod: checkoutBloc.selectedPaymentMethod,
          totalAmount: checkoutBloc.orderTotal,
          taxFee: checkoutBloc.taxFee,
          shippingFee: checkoutBloc.shippingFee,
          deliveryDate: DateTime.now().add(const Duration(days: 7)),
          address: addressBloc.selectedAddress,
          orderDate: DateTime.now());

      //save the order to Firebase Firestore
      await OrderRepo.addOrder(
          orderModel: order, userId: userId, customDocId: idString);

      // stop loading
      FullScreenLoader.hide(event.context);
      //show success message
      MHelperFunctions.mostStrictAnimationNavigation(
          event.context,
          OrderSuccessScreen(
            orderNumber: idString,
          ));
      // Clear all Cart items
      cartBloc.add(ClearCart());
    } catch (e) {
      if (kDebugMode) {
        print("error while create order. Error: $e");
      }
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(
          context: event.context,
          message:
              "Something Went Wrong While Create Order in bloc . Please Try Again later");
    }
  }

  void _fetchOrders(FetchOrders event, Emitter<OrderState> emit) async {
    try {
      //start loading
      emit(state.copyWith(isLoading: true));

      // get order from order repository
      final List<OrderModel> orderList = await OrderRepo.fetchOrders();
      if (orderList.isEmpty) {
        emit(state.copyWith(nodatafound: true));
      } else {
        emit(state.copyWith(nodatafound: false));
      }

      // update in state
      emit(state.copyWith(allOrders: orderList));

      //Close Loading
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      if (kDebugMode) {
        print("error while fetching orders in bloc. Error: $e");
      }
      SnackbarService.showError(
          context: event.context,
          message:
              "Something Went Wrong While fetching Orders. Please Try Again later");
    }
  }
}
