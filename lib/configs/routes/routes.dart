import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Categories/categories_bloc.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/components/bottom_nav_menu.dart';
import 'package:martify/configs/routes/custom_page_route.dart';
import 'package:martify/configs/routes/routes_name.dart';
import 'package:martify/controller/product%20controller/all_product_controller.dart';
import 'package:martify/view/All%20Brands/brand_products.dart';
import 'package:martify/view/All%20Products/all_products.dart';
import 'package:martify/view/Auth%20Loading%20Screen/auth_loading_screen.dart';
import 'package:martify/view/Cart/cart.dart';
import 'package:martify/view/StoreScreen/store_screen.dart';
import 'package:martify/view/forgetScreen/forget_screen.dart';
import 'package:martify/view/loginScreen/login_screen.dart';
import 'package:martify/view/onBoardingScreen/on_boarding.dart';
import 'package:martify/view/orders/orders.dart';
import 'package:martify/view/profile_screen/profile_screen.dart';
import 'package:martify/view/setting_screen/setting_screen.dart';
import 'package:martify/view/signup_Screen/screens/verify_email.dart';
import 'package:martify/view/signup_Screen/signup.dart';
import 'package:martify/view/wishlistScreen/wishlist_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.authLoadingScreen:
        return CustomPageRoute(page: const AuthLoadingScreen());
      case RoutesName.home:
        return CustomPageRoute(page: const BottomNavMenu());
      case RoutesName.onBoarding:
        return CustomPageRoute(page: const OnBoarding());
      case RoutesName.login:
        return CustomPageRoute(page: const LoginScreen());
      case RoutesName.register:
        return CustomPageRoute(page: const Signup());
      case RoutesName.forget:
        return CustomPageRoute(page: const ForgetScreen());
      case RoutesName.store:
        return CustomPageRoute(page: const StoreScreen());
      case RoutesName.wishList:
        return CustomPageRoute(page: const WishlistScreen());
      case RoutesName.settings:
        return CustomPageRoute(page: const SettingScreen());
      case RoutesName.nike:
        return CustomPageRoute(
            page: BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return BrandProducts(
              brand: state.featuredBrands[0],
            );
          },
        ));
      case RoutesName.cosmetics:
        return CustomPageRoute(
            page: BlocBuilder<CategoriesBloc, CategoriesState>(
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return AllProducts(
              title: "Cosmetics",
              futureMethod: AllProductController.getAllCategoryRealtedProucts(
                  context: context, categoryId: 2),
            );
          },
        ));
      case RoutesName.furniture:
        return CustomPageRoute(
            page: BlocBuilder<CategoriesBloc, CategoriesState>(
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return AllProducts(
              title: "Furniture",
              futureMethod: AllProductController.getAllCategoryRealtedProucts(
                  context: context, categoryId: 3),
            );
          },
        ));
      case RoutesName.pets:
        return CustomPageRoute(
            page: BlocBuilder<CategoriesBloc, CategoriesState>(
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return AllProducts(
              title: "Pets",
              futureMethod: AllProductController.getAllCategoryRealtedProucts(
                  context: context, categoryId: 4),
            );
          },
        ));
      case RoutesName.profile:
        return CustomPageRoute(page: const ProfileScreen());
      case RoutesName.cart:
        return CustomPageRoute(
            page: const Cart(
          cartinhome: false,
        ));
      case RoutesName.orderPage:
        return CustomPageRoute(page: const Orders());
      case RoutesName.verifyemailScreen:
        return CustomPageRoute(
            page: VerifyEmailScreen(
          email: FirebaseAuth.instance.currentUser!.email!,
          functionvalue: 1,
        ));

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
