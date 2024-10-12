import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/Re_auth_user/re_auth_user_bloc.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/validators/validators.dart';

class ReAuthScreen extends StatefulWidget {
  const ReAuthScreen(
      {super.key,
      this.noteText,
      required this.buttonText,
      required this.onSubmitValueString,
      this.passwordFieldLabel,
      this.buttoncColor});
  final String? noteText;
  final String buttonText;
  final String onSubmitValueString;
  final bool emailField = false;
  final String? passwordFieldLabel;
  final Color? buttoncColor;

  @override
  State<ReAuthScreen> createState() => _ReAuthScreenState();
}

class _ReAuthScreenState extends State<ReAuthScreen> {
  late ReAuthUserBloc _reAuthUserBloc;
  @override
  void initState() {
    super.initState();
    _reAuthUserBloc = ReAuthUserBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _reAuthUserBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _reAuthUserBloc,
      child: Scaffold(
        appBar: CustomAppBar(
          showBackArrow: true,
          title: Text("Re-Authentication",
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: Column(
              children: [
                if (widget.noteText != null) Text(widget.noteText!),
                if (widget.noteText != null) const SizedBox(height: 10),
                Form(
                  key: _reAuthUserBloc.state.reAuthUserFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: MSizes.spacerBtwSections),
                    child: Column(
                      children: [
                        // // -----Email Field-----------
                        // if (widget.emailField)
                        //   BlocBuilder<ReAuthUserBloc, ReAuthUserState>(
                        //     buildWhen: (previous, current) =>
                        //         previous.emailController !=
                        //         current.emailController,
                        //     builder: (context, state) {
                        //       return TextFormField(
                        //           controller: state.emailController,
                        //           keyboardType: TextInputType.emailAddress,
                        //           decoration: const InputDecoration(
                        //               prefixIcon: Icon(Icons.email_rounded),
                        //               labelText: MTexts.email),
                        //           validator: (value) =>
                        //               MValidators.validateEmail(value),
                        //           textInputAction: TextInputAction.next);
                        //     },
                        //   ),
                        // if (widget.emailField)
                        //   const SizedBox(
                        //       height: MSizes.spaceBtwInputFields / 2),
                        // ---------Password Field------------
                        BlocBuilder<ReAuthUserBloc, ReAuthUserState>(
                          buildWhen: (previous, current) =>
                              previous.hidePassword != current.hidePassword ||
                              previous.passwordController !=
                                  current.passwordController,
                          builder: (context, state) {
                            return TextFormField(
                                controller: state.passwordController,
                                obscureText: state.hidePassword,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Iconsax.password_check),
                                    labelText: widget.passwordFieldLabel ??
                                        MTexts.password,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          context
                                              .read<ReAuthUserBloc>()
                                              .add(HidePassword());
                                        },
                                        icon: state.hidePassword
                                            ? const Icon(Iconsax.eye_slash)
                                            : const Icon(Iconsax.eye))),
                                validator: (value) => MValidators.validateField(
                                    value, "Password"));
                          },
                        ),

                        const SizedBox(height: MSizes.spacerBtwSections),
                        // -----------Submit Button
                        SizedBox(
                            width: double.infinity,
                            child: BlocBuilder<ReAuthUserBloc, ReAuthUserState>(
                              buildWhen: (previous, current) => false,
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.buttoncColor ??
                                        MAppColors
                                            .primary, // Set the background color
                                    side: BorderSide(
                                        color: widget.buttoncColor ??
                                            MAppColors.primary),
                                  ),
                                  onPressed: () {
                                    if (widget.onSubmitValueString ==
                                        "delete") {
                                      context
                                          .read<ReAuthUserBloc>()
                                          .add(ReAuthUserSubmit(context));
                                    }
                                    if (widget.onSubmitValueString == "email") {
                                      context.read<ReAuthUserBloc>().add(
                                          ReAuthUserBeforeNewEmail(context));
                                    }
                                    if (widget.onSubmitValueString ==
                                        "password") {
                                      context.read<ReAuthUserBloc>().add(
                                          ReAuthUserBeforeNewPassword(context));
                                    }
                                    if (widget.onSubmitValueString == "phone") {
                                    } else {
                                      if (kDebugMode) {
                                        print(
                                            "Please enter correct pre define on sumbit value String");
                                      }
                                    }
                                  },
                                  child: Text(
                                    widget.buttonText,
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
