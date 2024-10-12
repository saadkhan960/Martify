import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/sign_up/sign_up_bloc.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class RichtextForm extends StatelessWidget {
  const RichtextForm({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: BlocBuilder<SignUpBloc, SignUpState>(
              buildWhen: (previous, current) =>
                  previous.privacyPolicy != current.privacyPolicy,
              builder: (context, state) {
                return Checkbox(
                    value: state.privacyPolicy,
                    onChanged: (value) {
                      context
                          .read<SignUpBloc>()
                          .add(PrivacyPolicyCheck(value: value!));
                    });
              },
            )),
        const SizedBox(
          width: MSizes.spaceBtwItems / 2,
        ),
        // -----------
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: '${MTexts.iAgreeTo} ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                  text: '${MTexts.privacyPolicy} ',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? MAppColors.white : MAppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            dark ? MAppColors.white : MAppColors.primary,
                      ),
                ),
                TextSpan(
                    text: ' and ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: MTexts.termsOfUse,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? MAppColors.white : MAppColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              dark ? MAppColors.white : MAppColors.primary,
                        )),
              ]),
            ),
          ),
        ),

        // -------------
      ],
    );
  }
}
