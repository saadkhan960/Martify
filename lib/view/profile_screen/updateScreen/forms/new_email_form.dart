import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/update_user_details/update_user_details_bloc.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/validators/validators.dart';

class NewEmailForm extends StatelessWidget {
  const NewEmailForm({super.key});

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
                  previous.emailController != current.emailController,
              builder: (context, state) {
                return TextFormField(
                  controller: state.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: MTexts.email),
                  validator: (value) => MValidators.changeEmailValidate(value),
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
                        .add(UpdateEmail(context: context));
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
