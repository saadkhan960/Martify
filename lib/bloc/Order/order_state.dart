part of 'order_bloc.dart';

class OrderState extends Equatable {
  final bool isLoading;
  final List<OrderModel> allOrders;
  final String errorMessageWhileFetching;
  final bool nodatafound;
  const OrderState(
      {this.isLoading = false,
      this.nodatafound = false,
      this.allOrders = const <OrderModel>[],
      this.errorMessageWhileFetching = ""});

  OrderState copyWith(
      {bool? isLoading,
      bool? nodatafound,
      List<OrderModel>? allOrders,
      String? errorMessageWhileFetching}) {
    return OrderState(
        nodatafound: nodatafound ?? this.nodatafound,
        isLoading: isLoading ?? this.isLoading,
        errorMessageWhileFetching:
            errorMessageWhileFetching ?? this.errorMessageWhileFetching,
        allOrders: allOrders ?? this.allOrders);
  }

  @override
  List<Object> get props =>
      [isLoading, allOrders, errorMessageWhileFetching, nodatafound];
}
