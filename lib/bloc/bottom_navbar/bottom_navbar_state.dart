part of 'bottom_navbar_bloc.dart';

class BottomNavbarState extends Equatable {
  final int selectedIndex;
  final List screens = [
    const HomeScreen(),
    const StoreScreen(),
    const WishlistScreen(),
    const Cart(cartinhome: true),
    const SettingScreen()
  ];
  BottomNavbarState({this.selectedIndex = 0});
  BottomNavbarState copyWith({int? selectedIndex}) {
    return BottomNavbarState(
        selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  @override
  List<Object> get props => [selectedIndex, screens];
}
