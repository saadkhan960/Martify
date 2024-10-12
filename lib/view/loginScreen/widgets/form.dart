import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/login/login_bloc.dart';
import 'package:martify/configs/routes/routes_name.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/validators/validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late LoginBloc _loginBloc;
  final localStorage = GetStorage();
  void _rememberMeLogin() async {
    if (await localStorage.read('RememberMeEmail') != null) {
      _loginBloc.state.emailController.text =
          localStorage.read('RememberMeEmail') ?? '';
      if (await localStorage.read('RememberMePassword') != null) {
        _loginBloc.state.passwordController.text =
            localStorage.read('RememberMePassword') ?? '';

        _loginBloc.state.copyWith(rememberMe: true);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
    _rememberMeLogin();
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Sign Form Rebuild");
    }
    final dark = MHelperFunctions.isDarkMode(context);
    return BlocProvider(
      create: (context) => _loginBloc,
      child: Form(
        key: _loginBloc.state.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: MSizes.spacerBtwSections),
          child: Column(
            children: [
              // -----Email Field-----------
              BlocBuilder<LoginBloc, LoginState>(
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
              const SizedBox(height: MSizes.spaceBtwInputFields / 2),
              // ---------Password Field------------
              BlocBuilder<LoginBloc, LoginState>(
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
                                context.read<LoginBloc>().add(PasswordShow());
                              },
                              icon: state.hidePassword
                                  ? const Icon(Iconsax.eye_slash)
                                  : const Icon(Iconsax.eye))),
                      validator: (value) =>
                          MValidators.validateField(value, "Password"),
                      textInputAction: TextInputAction.done);
                },
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields / 2),
              // ------Remember Me or Forgot Password-----
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BlocBuilder<LoginBloc, LoginState>(
                        buildWhen: (previous, current) =>
                            previous.rememberMe != current.rememberMe,
                        builder: (context, state) {
                          return Checkbox(
                              value: state.rememberMe,
                              onChanged: (value) {
                                context.read<LoginBloc>().add(RememberMe());
                              });
                        },
                      ),
                      const Text(MTexts.rememberMe)
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.forget);
                      },
                      child: Text(
                        MTexts.forgetPassword,
                        style: TextStyle(
                            color: dark ? Colors.white : Colors.black),
                      )),
                ],
              ),
              const SizedBox(height: MSizes.spacerBtwSections),
              // -----------Submit Button
              SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) => false,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context
                              .read<LoginBloc>()
                              .add(LoginFormSubmit(context: context));
                        },
                        child: const Text(MTexts.signIn),
                      );
                    },
                  )),
              const SizedBox(height: MSizes.spaceBtwItems),
              // -------- Create ACCOUNT bUTTON-------
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.register);
                    },
                    child: const Text(MTexts.createAccount),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
