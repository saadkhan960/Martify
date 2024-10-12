import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/bloc/Wishlist%20Bloc/wishlist_bloc.dart';
import 'package:martify/bloc/bottom_navbar/bottom_navbar_bloc.dart';
import 'package:martify/bloc/user_details/user_details_bloc.dart';
import 'package:martify/utils/local_storage/storage_utility.dart';

class BottomNavMenu extends StatefulWidget {
  const BottomNavMenu({super.key});

  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
  @override
  void initState() {
    super.initState();
    // Fetch the products once when the page is opened
    context.read<BottomNavbarBloc>().add(const ChangeMenu(index: 0));
    context.read<UserDetailsBloc>().add(FetchUser(context: context));
    context.read<UserDetailsBloc>().add(Fetchuserdetialsbool(context: context));
    context.read<ProductBloc>().add(FetchProducts(context: context));
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      MLocalStorage.instance().setUserId(userId);
    }
    context.read<WishlistBloc>().add(InitFavorites());
    context.read<CartBloc>().add(InitCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
        buildWhen: (previous, current) =>
            previous.selectedIndex != current.selectedIndex,
        builder: (context, state) {
          return NavigationBar(
            elevation: 0,
            height: 80,
            selectedIndex: state.selectedIndex,
            onDestinationSelected: (index) =>
                context.read<BottomNavbarBloc>().add(ChangeMenu(index: index)),
            destinations: [
              const NavigationDestination(
                icon: Icon(Iconsax.home),
                selectedIcon: Icon(Iconsax.home_15),
                label: "Home",
              ),
              const NavigationDestination(
                icon: Icon(Iconsax.shop),
                selectedIcon: Icon(Iconsax.shop5),
                label: "Shop",
              ),
              // ----------WishList---------------------------------------------
              NavigationDestination(
                icon: BlocBuilder<WishlistBloc, WishlistState>(
                  buildWhen: (previous, current) =>
                      previous.favorites.length != current.favorites.length,
                  builder: (context, state) {
                    return SizedBox(
                      width: state.favorites.isNotEmpty ? 30 : null,
                      child: Stack(
                        children: <Widget>[
                          const Icon(Iconsax.heart),
                          if (state.favorites.isNotEmpty)
                            Positioned(
                              right: 0,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 0),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    state.favorites.length.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                selectedIcon: BlocBuilder<WishlistBloc, WishlistState>(
                  buildWhen: (previous, current) =>
                      previous.favorites.length != current.favorites.length,
                  builder: (context, state) {
                    return SizedBox(
                      width: state.favorites.isNotEmpty ? 30 : null,
                      child: Stack(
                        children: <Widget>[
                          const Icon(Iconsax.heart5),
                          if (state.favorites.isNotEmpty)
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 0),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  state.favorites.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                label: "Wishlist",
              ),
              // ----------Wishlist---------------------------------------------
              NavigationDestination(
                icon: BlocBuilder<CartBloc, CartState>(
                  buildWhen: (previous, current) =>
                      previous.allCartItems.length !=
                      current.allCartItems.length,
                  builder: (context, state) {
                    return SizedBox(
                      width: state.allCartItems.isNotEmpty ? 30 : null,
                      child: Stack(
                        children: <Widget>[
                          const Icon(Icons.shopping_cart_outlined),
                          if (state.allCartItems.isNotEmpty)
                            Positioned(
                              right: 0,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 0),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    state.allCartItems.length.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                selectedIcon: BlocBuilder<CartBloc, CartState>(
                  buildWhen: (previous, current) =>
                      previous.allCartItems.length !=
                      current.allCartItems.length,
                  builder: (context, state) {
                    return SizedBox(
                      width: state.allCartItems.isNotEmpty ? 30 : null,
                      child: Stack(
                        children: <Widget>[
                          const Icon(Icons.shopping_cart),
                          if (state.allCartItems.isNotEmpty)
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 0),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  state.allCartItems.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                label: "Cart",
              ),
              // ----------CART END-------------------------------------------------
              const NavigationDestination(
                icon: Icon(
                  Icons.person_outline,
                  size: 28,
                ),
                selectedIcon: Icon(
                  Icons.person,
                  size: 28,
                ),
                label: "Profile",
              ),
            ],
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          );
        },
      ),
      body: BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
        buildWhen: (previous, current) =>
            previous.selectedIndex != current.selectedIndex,
        builder: (context, state) {
          return state.screens[state.selectedIndex];
        },
      ),
    );
  }
}
