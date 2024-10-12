import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/update_user_details/update_user_details_bloc.dart';
import 'package:martify/bloc/user_details/user_details_bloc.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/view/profile_screen/updateScreen/forms/fullname_form.dart';
import 'package:martify/view/profile_screen/updateScreen/forms/new_email_form.dart';
import 'package:martify/view/profile_screen/updateScreen/forms/pass_change_form.dart';
import 'package:martify/view/profile_screen/updateScreen/forms/phone_no_form.dart';
import 'package:martify/view/profile_screen/updateScreen/forms/username_form.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen(
      {super.key,
      required this.appBarTitle,
      this.message,
      required this.formNo});
  final String appBarTitle;
  final String? message;
  final int formNo;

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserDetailsBloc>(context).state.user;
    return BlocProvider(
      create: (context) => UpdateUserDetailsBloc(user),
      child: Scaffold(
        appBar: CustomAppBar(
          showBackArrow: true,
          title: Text(appBarTitle,
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(MSizes.defaultSpace),
                child: Column(
                  children: [
                    message != null
                        ? Text(
                            message!,
                            style: Theme.of(context).textTheme.labelMedium,
                          )
                        : const SizedBox(),
                    // ----------------Forms----------------
                    if (formNo == 1) const FullnameForm(),
                    if (formNo == 2) const UsernameForm(),
                    if (formNo == 3) const NewEmailForm(),
                    if (formNo == 4) const PhoneNoForm(),
                    if (formNo == 5) const PassChangeForm()
                  ],
                ))),
      ),
    );
  }
}
