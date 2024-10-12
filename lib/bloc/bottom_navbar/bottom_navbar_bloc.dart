import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:martify/view/Cart/cart.dart';
import 'package:martify/view/StoreScreen/store_screen.dart';
import 'package:martify/view/home_screen/home_screen.dart';
import 'package:martify/view/setting_screen/setting_screen.dart';
import 'package:martify/view/wishlistScreen/wishlist_screen.dart';

part 'bottom_navbar_event.dart';
part 'bottom_navbar_state.dart';

class BottomNavbarBloc extends Bloc<BottomNavbarEvent, BottomNavbarState> {
  BottomNavbarBloc() : super(BottomNavbarState()) {
    on<ChangeMenu>(_changeMenu);
  }
  void _changeMenu(ChangeMenu event, Emitter<BottomNavbarState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }
}
