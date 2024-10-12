import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/bloc/Wishlist%20Bloc/wishlist_bloc.dart';
import 'package:martify/configs/routes/routes_name.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/popups/custom_dialog.dart';
import 'package:martify/view/Address/Address%20List/address_list.dart';
import 'package:martify/view/setting_screen/widgets/settingmenutile.dart';

class BodySetting extends StatelessWidget {
  const BodySetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MSizes.defaultSpace),
      child: Column(
        children: [
          //Account Seetings
          const MSectionHeading(
            title: "Account",
            showActionButton: false,
          ),
          const SizedBox(height: MSizes.spaceBtwItems),
          MSettingsMenuTile(
            icon: Iconsax.safe_home,
            title: "My Addresses",
            subTitle: "Set shopping delivery address",
            onPressed: () {
              MHelperFunctions.simpleAnimationNavigation(
                  context, const AddressList());
            },
          ),
          MSettingsMenuTile(
            icon: Iconsax.shopping_cart,
            title: 'My Cart',
            subTitle: 'Add, remove products and move to checkout',
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.cart);
            },
          ),
          MSettingsMenuTile(
            icon: Iconsax.bag_tick,
            title: 'My Orders',
            subTitle: 'In-progress and Completed Orders',
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.orderPage);
            },
          ),
          MSettingsMenuTile(
            icon: Iconsax.bank,
            title: 'Bank Account',
            subTitle: 'Withdraw balance to registered bank account',
            onPressed: () {
              MCustomDialog.showUnavalibleMessage(context);
            },
          ),
          MSettingsMenuTile(
            icon: Iconsax.discount_shape,
            title: 'My Coupons',
            subTitle: 'List of all the discounted coupons',
            onPressed: () {
              MCustomDialog.showUnavalibleMessage(context);
            },
          ),
          MSettingsMenuTile(
            icon: Iconsax.notification,
            title: 'Notifications',
            subTitle: 'Set any kind of notification message',
            onPressed: () {
              MCustomDialog.showUnavalibleMessage(context);
            },
          ),
          MSettingsMenuTile(
            icon: Iconsax.security_card,
            title: 'Account Privacy',
            subTitle: 'Manage data usage and connected accounts',
            onPressed: () {
              MCustomDialog.showUnavalibleMessage(context);
            },
          ),

          // //App Settings
          // const SizedBox(height: MSizes.spacerBtwSections),

          // const MSectionHeading(title: 'App Settings', showActionButton: false),

          // const SizedBox(height: MSizes.spaceBtwItems),

          // MSettingsMenuTile(
          //   icon: Iconsax.document_upload,
          //   title: 'Load Data',
          //   subTitle: 'Upload Data to your Cloud Firebase',
          //   onPressed: () async {
          //     // final List<Map<String, dynamic>> brands = [
          //     //   {
          //     //     'id': 1,
          //     //     'name': 'Nike',
          //     //     'image': 'assets/icons/brand/nike',
          //     //     'isFeatured': true,
          //     //     'productCount': 50
          //     //   },
          //     //   {
          //     //     'id': 2,
          //     //     'name': 'Interwood',
          //     //     'image': 'assets/icons/brand/interwood',
          //     //     'isFeatured': true,
          //     //     'productCount': 50
          //     //   },
          //     //   {
          //     //     'id': 3,
          //     //     'name': 'Zara',
          //     //     'image': 'assets/icons/brand/zara',
          //     //     'isFeatured': true,
          //     //     'productCount': 50
          //     //   },
          //     //   {
          //     //     'id': 4,
          //     //     'name': 'Toyzone',
          //     //     'image': 'assets/icons/brand/toyzone',
          //     //     'isFeatured': true,
          //     //     'productCount': 50
          //     //   },
          //     //   {
          //     //     'id': 5,
          //     //     'name': 'Scents N Stories',
          //     //     'image': 'assets/icons/brand/scents',
          //     //     'isFeatured': true,
          //     //     'productCount': 50
          //     //   },
          //     //   {
          //     //     'id': 6,
          //     //     'name': 'L\'Oréal',
          //     //     'image': 'assets/icons/brand/loreal',
          //     //     'isFeatured': true,
          //     //     'productCount': 50
          //     //   },
          //     //   {
          //     //     'id': 7,
          //     //     'name': 'Apple',
          //     //     'image': 'assets/icons/brand/apple',
          //     //     'isFeatured': true,
          //     //     'productCount': 50
          //     //   },
          //     //   {
          //     //     'id': 8,
          //     //     'name': 'Seasons',
          //     //     'image': 'assets/icons/brand/seasons',
          //     //     'isFeatured': true,
          //     //     'productCount': 50
          //     //   },
          //     // ];
          //     // await UploadDataInFirebase.addBrandsToFirestore(brands, context);
          //     // await UploadDataInFirebase.updateProductsBrandField(context);
          //     // await UploadDataInFirebase.updateFieldInAllDocs();
          //     MHelperFunctions.simpleAnimationNavigation(
          //         context, const AddProductScreen());
          //   },
          // ),
          // MSettingsMenuTile(
          //   icon: Iconsax.convert_card4,
          //   title: 'Dark Mode',
          //   subTitle: 'Set Theme Apperance',
          //   trailing: Switch(value: true, onChanged: (value) {}),
          // ),
          //Logout Button
          const SizedBox(height: MSizes.spacerBtwSections),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
                onPressed: () {
                  MCustomDialog.showCustomDialog(
                      context: context,
                      titleText: 'Confirmation',
                      contentText: "Are you sure you want to log out?",
                      onCancle: () {
                        Navigator.pop(context);
                      },
                      cancelButtonText: "No",
                      deleteButtonText: "Logout",
                      onDelete: () {
                        context.read<CartBloc>().add(RemoveCartlistForLogout());
                        context
                            .read<WishlistBloc>()
                            .add(RemoveWhishlistForLogout());
                        AuthenticationRepository.logoutUserFirebase(context);
                      });
                },
                child: const Text('Logout')),
          ),
          const SizedBox(height: MSizes.spacerBtwSections * 2.5),
        ],
      ),
    );
  }
}
