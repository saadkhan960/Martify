part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AddOrder extends OrderEvent {
  final BuildContext context;
  const AddOrder({required this.context});
  @override
  List<Object> get props => [context];
}

class FetchOrders extends OrderEvent {
  final BuildContext context;
  const FetchOrders({required this.context});
  @override
  List<Object> get props => [context];
}
