import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/update_user_details/update_user_details_bloc.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/validators/validators.dart';

class UsernameForm extends StatelessWidget {
  const UsernameForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UpdateUserDetailsBloc>().state.updateUserFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MSizes.spacerBtwSections),
        child: Column(
          children: [
            // -----UserName-----------
            BlocBuilder<UpdateUserDetailsBloc, UpdateUserDetailsState>(
              buildWhen: (previous, current) =>
                  previous.userNameController != current.userNameController,
              builder: (context, state) {
                return TextFormField(
                  controller: state.userNameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user_edit),
                      labelText: MTexts.username),
                  validator: (value) =>
                      MValidators.validateField(value, "Username"),
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
                        .add(UpdateUsername(context: context));
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
