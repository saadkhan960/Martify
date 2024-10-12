import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/sign_up/sign_up_bloc.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/validators/validators.dart';
import 'package:martify/view/signup_Screen/widgets/richtext_form.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late SignUpBloc signUpBloc;
  @override
  void initState() {
    super.initState();
    signUpBloc = SignUpBloc();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   signUpBloc.state.dispose();
  //   signUpBloc.close();
  // }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("SignUp Form Rebuild");
    }
    return BlocProvider(
      create: (context) => signUpBloc,
      child: Form(
        key: signUpBloc.state.signUpFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: MSizes.spacerBtwSections),
          child: Column(
            children: [
              // -------------------------Fields----------------------------------
              // -------First And Last Name
              Row(
                children: [
                  Expanded(
                    // -----First Name
                    child: BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (previous, current) =>
                          previous.firstNameController !=
                          current.firstNameController,
                      builder: (context, state) {
                        return TextFormField(
                            controller: state.firstNameController,
                            expands: false,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.user),
                                labelText: MTexts.firstName),
                            validator: (value) => MValidators.validateField(
                                value, MTexts.firstName),
                            textInputAction: TextInputAction.next);
                      },
                    ),
                  ),
                  const SizedBox(width: MSizes.spaceBtwInputFields / 2),
                  //---------Last Name
                  Expanded(
                    child: BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (previous, current) =>
                          previous.lastNameController !=
                          current.lastNameController,
                      builder: (context, state) {
                        return TextFormField(
                            keyboardType: TextInputType.name,
                            controller: state.lastNameController,
                            textCapitalization: TextCapitalization.words,
                            expands: false,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.user),
                              labelText: MTexts.lastName,
                            ),
                            validator: (value) => MValidators.validateField(
                                value, MTexts.lastName),
                            textInputAction: TextInputAction.next);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields / 1),
              // --------UserName
              BlocBuilder<SignUpBloc, SignUpState>(
                buildWhen: (previous, current) =>
                    previous.userNameController != current.userNameController,
                builder: (context, state) {
                  return TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: state.userNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user_edit),
                          labelText: MTexts.username),
                      validator: (value) =>
                          MValidators.validateField(value, MTexts.username),
                      textInputAction: TextInputAction.next);
                },
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields / 1),
              // -----------EMAIL
              BlocBuilder<SignUpBloc, SignUpState>(
                buildWhen: (previous, current) =>
                    previous.emailController != current.emailController,
                builder: (context, state) {
                  return TextFormField(
                      controller: state.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          labelText: MTexts.email),
                      validator: (value) => MValidators.validateEmail(value),
                      textInputAction: TextInputAction.next);
                },
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields / 1),
              // -------PHone No
              BlocBuilder<SignUpBloc, SignUpState>(
                buildWhen: (previous, current) =>
                    previous.phoneNoController != current.phoneNoController,
                builder: (context, state) {
                  return TextFormField(
                      controller: state.phoneNoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.call),
                          labelText: MTexts.phoneNo),
                      validator: (value) =>
                          MValidators.validatePhoneNumber(value),
                      textInputAction: TextInputAction.next);
                },
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields / 1),
              // -----------Password
              BlocBuilder<SignUpBloc, SignUpState>(
                buildWhen: (previous, current) =>
                    previous.hidePassword != current.hidePassword ||
                    previous.passwordController != current.passwordController,
                builder: (context, state) {
                  return TextFormField(
                      controller: state.passwordController,
                      obscureText: state.hidePassword,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          labelText: MTexts.password,
                          suffixIcon: IconButton(
                              onPressed: () {
                                context.read<SignUpBloc>().add(PasswordShow());
                              },
                              icon: state.hidePassword
                                  ? const Icon(Iconsax.eye_slash)
                                  : const Icon(Iconsax.eye))),
                      validator: (value) => MValidators.validatePassword(value),
                      textInputAction: TextInputAction.next);
                },
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields / 1),
              // -----------Confirm Password
              BlocBuilder<SignUpBloc, SignUpState>(
                buildWhen: (previous, current) =>
                    previous.hideConfirmPassword != current.hideConfirmPassword,
                builder: (context, state) {
                  return TextFormField(
                      obscureText: state.hideConfirmPassword,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          labelText: MTexts.confirmpassword,
                          suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<SignUpBloc>()
                                    .add(ConfirmPasswordShow());
                              },
                              icon: state.hideConfirmPassword
                                  ? const Icon(Iconsax.eye_slash)
                                  : const Icon(Iconsax.eye))),
                      validator: (value) => MValidators.confirmPassword(value),
                      textInputAction: TextInputAction.done);
                },
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields / 1),
              // ------------------------Fields End-----------------------------
              const RichtextForm(),
              // -------Agrement RichText----
              const SizedBox(height: MSizes.spacerBtwSections),
              // ------Submit Button---
              BlocBuilder<SignUpBloc, SignUpState>(
                buildWhen: (previous, current) => false,
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // MHelperFunctions.strictAnimationNavigation(
                        //     context, const VerifyEmailScreen());
                        context
                            .read<SignUpBloc>()
                            .add(SignUpPress(context: context));
                      },
                      child: const Text(MTexts.createAccount),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
