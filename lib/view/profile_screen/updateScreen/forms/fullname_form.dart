import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/update_user_details/update_user_details_bloc.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/validators/validators.dart';

class FullnameForm extends StatelessWidget {
  const FullnameForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UpdateUserDetailsBloc>().state.updateUserFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MSizes.spacerBtwSections),
        child: Column(
          children: [
            // -----First NAME-----------
            BlocBuilder<UpdateUserDetailsBloc, UpdateUserDetailsState>(
              buildWhen: (previous, current) =>
                  previous.firstNameController != current.firstNameController,
              builder: (context, state) {
                return TextFormField(
                    controller: state.firstNameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user),
                        labelText: MTexts.firstName),
                    validator: (value) =>
                        MValidators.validateField(value, "First Name"),
                    textInputAction: TextInputAction.next);
              },
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields / 2),
            // ---------lAST name------------
            BlocBuilder<UpdateUserDetailsBloc, UpdateUserDetailsState>(
              buildWhen: (previous, current) =>
                  previous.lastNameController != current.lastNameController,
              builder: (context, state) {
                return TextFormField(
                    controller: state.lastNameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: MTexts.lastName,
                    ),
                    validator: (value) =>
                        MValidators.validateField(value, "Last Name"),
                    textInputAction: TextInputAction.done);
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
                        .add(UpdateFullName(context: context));
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
