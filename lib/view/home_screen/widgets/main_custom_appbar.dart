import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/user_details/user_details_bloc.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/common/widgets/appbar/micon_counter.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MainCustomAppBar extends StatelessWidget {
  const MainCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return CustomAppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(MTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: MAppColors.grey)),
          BlocBuilder<UserDetailsBloc, UserDetailsState>(
            buildWhen: (previous, current) =>
                previous.user.userFullName != current.user.userFullName ||
                previous.profileLoading != current.profileLoading,
            builder: (context, state) {
              if (state.profileLoading) {
                return const MShimmerLoader(
                  width: 120,
                  height: 15,
                  baseColor: MAppColors.primary,
                  highlightColor: MAppColors.darkModeWhite,
                );
              } else {
                return Text(state.user.userFullName,
                    style: Theme.of(context).textTheme.headlineSmall!.apply(
                        color: dark
                            ? MAppColors.darkModeWhite
                            : MAppColors.white));
              }
            },
          ),
        ]),
        actions: [
          MiconCounter(
            iconColor: dark ? MAppColors.darkModeWhite : MAppColors.white,
          )
        ]);
  }
}
