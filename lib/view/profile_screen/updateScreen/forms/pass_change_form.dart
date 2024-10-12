import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/update_user_details/update_user_details_bloc.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/validators/validators.dart';

class PassChangeForm extends StatelessWidget {
  const PassChangeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UpdateUserDetailsBloc>().state.updateUserFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MSizes.spacerBtwSections),
        child: Column(
          children: [
            // -----Email-----------
            BlocBuilder<UpdateUserDetailsBloc, UpdateUserDetailsState>(
              buildWhen: (previous, current) =>
                  previous.passwordController != current.passwordController ||
                  previous.hidePassword != current.hidePassword,
              builder: (context, state) {
                return TextFormField(
                  controller: state.passwordController,
                  obscureText: state.hidePassword,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      labelText: "New Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<UpdateUserDetailsBloc>()
                                .add(HidePassword());
                          },
                          icon: state.hidePassword
                              ? const Icon(Iconsax.eye_slash)
                              : const Icon(Iconsax.eye))),
                  validator: (value) => MValidators.validatePassword(value),
                );
              },
            ),
            const SizedBox(height: MSizes.spacerBtwSections),
            // -----------Submit Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<UpdateUserDetailsBloc>()
                        .add(UpdatePassword(context: context));
                  },
                  child: const Text("Update"),
                )),
            const SizedBox(height: MSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
