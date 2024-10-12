import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/bloc/sign_up/sign_up_bloc.dart';
import 'package:martify/controller/email_verify_controller.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen(
      {super.key, required this.email, required this.functionvalue});
  final String email;
  final int functionvalue;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late SignUpBloc _signUpBloc;
  @override
  void initState() {
    super.initState();
    EmailVerifyController.sendEmailVerification(context);
    EmailVerifyController.setTimerForAutoRedirect(
        context, widget.functionvalue);
    _signUpBloc = SignUpBloc();
    _signUpBloc.add(StartTimer());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _signUpBloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  AuthenticationRepository.logoutUserFirebase(context);
                },
                icon: const Icon(CupertinoIcons.clear))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: Column(
              children: [
                Image(
                  width: MHelperFunctions.screenwidth(context) * 0.6,
                  image: const AssetImage(MImages.emailVerfiy),
                ),
                const SizedBox(height: MSizes.spacerBtwSections),
                Text(
                  MTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: MSizes.spaceBtwItems),
                Text(
                  widget.email,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: MSizes.spaceBtwItems),
                Text(
                  widget.functionvalue == 1
                      ? MTexts.confirmEmailSubTitle
                      : MTexts.changeEmailSubTitile,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: MSizes.spacerBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      EmailVerifyController.checkEmailVerificationStatus(
                          context);
                    },
                    child: const Text("Continue"),
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwItems),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: state.canResend
                            ? () async {
                                context.read<SignUpBloc>().add(StartTimer());
                                await EmailVerifyController
                                    .sendEmailVerification(context);
                              }
                            : () {},
                        child: state.canResend
                            ? const Text(MTexts.resendEmail)
                            : Text('Resend Email in ${state.timeLeft}s'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
