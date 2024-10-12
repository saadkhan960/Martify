import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/bloc/forget_password/forget_password_bloc.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/loginScreen/login_screen.dart';

class ResetPasssword extends StatefulWidget {
  const ResetPasssword({super.key, required this.email});
  final String email;

  @override
  State<ResetPasssword> createState() => _ResetPassswordState();
}

class _ResetPassswordState extends State<ResetPasssword> {
  late ForgetPasswordBloc _forgetPasswordBloc;
  @override
  void initState() {
    super.initState();
    _forgetPasswordBloc = ForgetPasswordBloc();
    _forgetPasswordBloc.add(StartTimer());
  }

  @override
  void dispose() {
    super.dispose();
    _forgetPasswordBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => _forgetPasswordBloc,
        child: SingleChildScrollView(
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
                  MTexts.changeYourPasswordTitle,
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
                  MTexts.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: MSizes.spacerBtwSections),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          MHelperFunctions.mostStrictAnimationNavigation(
                              context, const LoginScreen());
                        },
                        child: const Text("Done"))),
                const SizedBox(height: MSizes.spaceBtwItems),
                BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: state.canResend
                            ? () async {
                                context
                                    .read<ForgetPasswordBloc>()
                                    .add(StartTimer());
                                await AuthenticationRepository
                                    .resetPassWithEmailAndPassword(
                                        email: widget.email);
                              }
                            : () {},
                        child: state.canResend
                            ? const Text(MTexts.resendEmail)
                            : Text('Resend Email in ${state.timeLeft}s'),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
