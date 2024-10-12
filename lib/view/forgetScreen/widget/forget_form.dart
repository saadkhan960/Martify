import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/forget_password/forget_password_bloc.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/validators/validators.dart';

class ForgetForm extends StatefulWidget {
  const ForgetForm({super.key});

  @override
  State<ForgetForm> createState() => _ForgetFormState();
}

class _ForgetFormState extends State<ForgetForm> {
  late ForgetPasswordBloc _forgetPasswordBloc;
  @override
  void initState() {
    super.initState();
    _forgetPasswordBloc = ForgetPasswordBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _forgetPasswordBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _forgetPasswordBloc,
      child: Form(
        key: _forgetPasswordBloc.state.forgetFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: MSizes.spacerBtwSections),
          child: Column(
            children: [
              BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                buildWhen: (previous, current) =>
                    previous.emailController.text !=
                    current.emailController.text,
                builder: (context, state) {
                  return TextFormField(
                    controller: state.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_rounded),
                        labelText: MTexts.email),
                    validator: (value) => MValidators.validateEmail(value),
                    // textInputAction: TextInputAction.done
                  );
                },
              ),
              const SizedBox(height: MSizes.spacerBtwSections),
              SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                    buildWhen: (previous, current) => false,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context
                              .read<ForgetPasswordBloc>()
                              .add(ForgetPassword(context: context));
                        },
                        child: const Text("Send"),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
