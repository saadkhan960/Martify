import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/user_details/user_details_bloc.dart';
import 'package:martify/configs/routes/routes_name.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/common/widgets/bannerimages/rounded_image.dart';
import 'package:martify/utils/common/widgets/curved_header/primary_header_widget.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MainSettingHeading extends StatelessWidget {
  const MainSettingHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return MPrimaryHeaderWidget(
        child: Column(
      children: [
        //AppBar
        CustomAppBar(
          title: Text(
            "Account",
            style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: dark ? MAppColors.darkModeWhite : MAppColors.white),
          ),
        ),
        const SizedBox(height: MSizes.spacerBtwSections),
        //User Profile Card
        ListTile(
          leading: BlocBuilder<UserDetailsBloc, UserDetailsState>(
            buildWhen: (previous, current) =>
                previous.user.profilePicture != current.user.profilePicture ||
                previous.imageUploading != current.imageUploading,
            builder: (context, state) {
              final networkImage = state.user.profilePicture;
              if (state.imageUploading) {
                const MShimmerLoader(
                  width: 50,
                  height: 50,
                  radius: 50,
                );
              }
              if (state.profileLoading) {
                const MShimmerLoader(
                  width: 50,
                  height: 50,
                  radius: 50,
                );
              }
              return MRoundedImage(
                imageurl: networkImage.isEmpty
                    ? MImages.user
                    : state.user.profilePicture,
                isNetworkImage: networkImage.isNotEmpty,
                height: 50,
                width: 50,
                borderRadius: 100,
                padding: const EdgeInsets.all(0),
                fit: BoxFit.cover,
              );
            },
          ),
          title: BlocBuilder<UserDetailsBloc, UserDetailsState>(
            buildWhen: (previous, current) =>
                previous.user.userFullName != current.user.userFullName,
            builder: (context, state) {
              if (state.profileLoading) {
                return const MShimmerLoader(
                  width: 120,
                  height: 15,
                  baseColor: MAppColors.primary,
                  highlightColor: MAppColors.darkModeWhite,
                );
              } else {
                return Text(
                  state.user.userFullName,
                  style: Theme.of(context).textTheme.headlineSmall!.apply(
                      color:
                          dark ? MAppColors.darkModeWhite : MAppColors.white),
                );
              }
            },
          ),
          subtitle: BlocBuilder<UserDetailsBloc, UserDetailsState>(
            buildWhen: (previous, current) =>
                previous.user.email != current.user.email,
            builder: (context, state) {
              if (state.profileLoading) {
                return const MShimmerLoader(
                  width: 120,
                  height: 15,
                  baseColor: MAppColors.primary,
                  highlightColor: MAppColors.darkModeWhite,
                );
              } else {
                return Text(
                  state.user.email,
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                      color:
                          dark ? MAppColors.darkModeWhite : MAppColors.white),
                );
              }
            },
          ),
          trailing: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.profile);
              },
              icon: Icon(
                Iconsax.edit,
                color: dark ? MAppColors.darkModeWhite : MAppColors.white,
              )),
        ),
        const SizedBox(height: MSizes.spacerBtwSections)
      ],
    ));
  }
}
