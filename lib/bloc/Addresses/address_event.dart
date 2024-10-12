part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AllUserAddresses extends AddressEvent {}

class SelectedAddress extends AddressEvent {
  final AddressModel newSelectedaddres;
  final BuildContext context;
  const SelectedAddress(
      {required this.newSelectedaddres, required this.context});
  @override
  List<Object> get props => [newSelectedaddres, context];
}

class AddAddress extends AddressEvent {
  final BuildContext context;
  const AddAddress({required this.context});
  @override
  List<Object> get props => [context];
}

class ChangeCountry extends AddressEvent {
  final String country;
  const ChangeCountry({required this.country});
  @override
  List<Object> get props => [country];
}

class SelectDeleteAddress extends AddressEvent {
  final AddressModel selectedAddress;
  const SelectDeleteAddress({required this.selectedAddress});
  @override
  List<Object> get props => [selectedAddress];
}

class DeleteAddress extends AddressEvent {
  final BuildContext context;
  const DeleteAddress({required this.context});
  @override
  List<Object> get props => [context];
}

class RemoveHold extends AddressEvent {}
