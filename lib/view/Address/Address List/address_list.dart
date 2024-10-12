import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/Addresses/address_bloc.dart';
import 'package:martify/utils/common/styles/address_shimmer.dart';
import 'package:martify/utils/common/widgets/Image%20With%20Text/image_with_text.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/popups/custom_dialog.dart';
import 'package:martify/view/Address/AddNewAddress/add_new_address.dart';
import 'package:martify/view/Address/Address%20List/widgets/single_address.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(AllUserAddresses());
  }

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
        actions: context.watch<AddressBloc>().state.removeHold
            ? [
                IconButton(
                    onPressed: () {
                      MCustomDialog.showCustomDialog(
                          context: context,
                          titleText: "Remove Address",
                          deleteButtonText: "Remove",
                          contentText:
                              "Are you sure you want to remove this address.",
                          onDelete: () {
                            context
                                .read<AddressBloc>()
                                .add(DeleteAddress(context: context));
                          },
                          onCancle: () {
                            context.read<AddressBloc>().add(RemoveHold());
                            Navigator.of(context).pop();
                          });
                    },
                    icon: const Icon(Icons.delete))
              ]
            : null,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MAppColors.primary,
        onPressed: () {
          MHelperFunctions.simpleAnimationNavigation(
              context, const AddNewAddress());
        },
        child: Icon(Iconsax.add,
            color: dark ? MAppColors.darkModeWhite : MAppColors.white),
      ),
      body: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: BlocBuilder<AddressBloc, AddressState>(
            buildWhen: (previous, current) =>
                previous.allAddress != current.allAddress ||
                previous.nodatafound != current.nodatafound ||
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: AddressShimmer(),
                );
              }
              if (state.nodatafound || state.allAddress.isEmpty) {
                return const ImageWithText(
                  imageColor: false,
                  image: "assets/images/no-address.png",
                  title: "No Address Added",
                  secondTile: "Click on + icon to add Address",
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: state.allAddress.length,
                    itemBuilder: (context, index) {
                      return SingleAddress(
                          onLongPress: () => context.read<AddressBloc>().add(
                              SelectDeleteAddress(
                                  selectedAddress: state.allAddress[index])),
                          onTap: () {
                            context.read<AddressBloc>().add(SelectedAddress(
                                context: context,
                                newSelectedaddres: state.allAddress[index]));
                          },
                          address: state.allAddress[index]);
                    }),
              );
            },
          )),
    );
  }
}
