part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class SelectPaymentMethod extends CheckoutEvent {
  final BuildContext context;
  const SelectPaymentMethod({required this.context});
  @override
  List<Object> get props => [context];
}

class SelectMethod extends CheckoutEvent {
  final PaymentMethodModel method;
  const SelectMethod({required this.method});
  @override
  List<Object> get props => [method];
}

class CalculateTotalAmount extends CheckoutEvent {
  final BuildContext context;
  const CalculateTotalAmount({required this.context});
  @override
  List<Object> get props => [context];
}
