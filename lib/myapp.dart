import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:martify/bloc/Addresses/address_bloc.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/bloc/Categories/categories_bloc.dart';
import 'package:martify/bloc/Checkout/checkout_bloc.dart';
import 'package:martify/bloc/Order/order_bloc.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/bloc/Wishlist%20Bloc/wishlist_bloc.dart';
import 'package:martify/bloc/banner/banner_bloc.dart';
import 'package:martify/bloc/bottom_navbar/bottom_navbar_bloc.dart';
import 'package:martify/bloc/user_details/user_details_bloc.dart';
import 'package:martify/configs/routes/routes.dart';
import 'package:martify/configs/routes/routes_name.dart';
import 'package:martify/utils/themes/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final deviceStorage = GetStorage();
  bool? emailVerify;
  bool? firstCheck;

  void _checkIfFirstTime() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      firstCheck = true;
      if (user.emailVerified) {
        emailVerify = true;
      } else {
        emailVerify = false;
      }
    } else {
      firstCheck = false;
    }
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _checkIfFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavbarBloc>(
            create: (BuildContext context) => BottomNavbarBloc(),
          ),
          BlocProvider<UserDetailsBloc>(
            create: (BuildContext context) => UserDetailsBloc(),
          ),
          BlocProvider<CategoriesBloc>(
            create: (BuildContext context) => CategoriesBloc(),
          ),
          BlocProvider<BannerBloc>(
            create: (BuildContext context) => BannerBloc(),
          ),
          BlocProvider<ProductBloc>(
            create: (BuildContext context) => ProductBloc(),
          ),
          BlocProvider<WishlistBloc>(
            create: (BuildContext context) => WishlistBloc(),
          ),
          BlocProvider<AddressBloc>(
            create: (BuildContext context) => AddressBloc(),
          ),
          BlocProvider<CartBloc>(
            create: (BuildContext context) => CartBloc(),
          ),
          BlocProvider<CheckoutBloc>(
            create: (BuildContext context) => CheckoutBloc(),
          ),
          BlocProvider<OrderBloc>(
            create: (BuildContext context) => OrderBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Martify',
          themeMode: ThemeMode.system,
          theme: MAppTheme.lightTheme,
          darkTheme: MAppTheme.darkTheme,
          initialRoute: firstCheck!
              ? emailVerify!
                  ? RoutesName.home
                  : RoutesName.verifyemailScreen
              : deviceStorage.read("isFirstTime") ?? true
                  ? RoutesName.onBoarding
                  : RoutesName.login,
          onGenerateRoute: Routes.generateRoute,
        ));
  }
}
