part of 'bottom_navbar_bloc.dart';

abstract class BottomNavbarEvent extends Equatable {
  const BottomNavbarEvent();

  @override
  List<Object> get props => [];
}

class ChangeMenu extends BottomNavbarEvent {
  final int index;
  const ChangeMenu({required this.index});
  @override
  List<Object> get props => [index];
}
