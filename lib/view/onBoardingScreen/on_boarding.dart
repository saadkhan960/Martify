import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/onBoardingPage/onboarding_page_bloc.dart';
import 'package:martify/view/onBoardingScreen/widgets/expanding_dots.dart';
import 'package:martify/view/onBoardingScreen/widgets/next_button.dart';
import 'package:martify/view/onBoardingScreen/widgets/on_boarding_page.dart';
import 'package:martify/view/onBoardingScreen/widgets/on_boarding_skip.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late OnboardingPageBloc _onboardingPageBloc;
  @override
  void initState() {
    super.initState();
    _onboardingPageBloc = OnboardingPageBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _onboardingPageBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => _onboardingPageBloc,
        child: BlocBuilder<OnboardingPageBloc, OnboardingPageState>(
          buildWhen: (previous, current) =>
              previous.currentPageIndex != current.currentPageIndex,
          builder: (context, state) {
            return Stack(
              children: [
                PageView(
                  controller: state.pageController,
                  onPageChanged: (value) {
                    context
                        .read<OnboardingPageBloc>()
                        .add(UpdatePageIndicator(index: value));
                  },
                  children: const [
                    OnBoardingPage(
                        image: MImages.onBoardingImage1,
                        title: MTexts.onBoardingTitle1,
                        subTitle: MTexts.onBoardingSubTitle1),
                    OnBoardingPage(
                        image: MImages.onBoardingImage2,
                        title: MTexts.onBoardingTitle2,
                        subTitle: MTexts.onBoardingSubTitle2),
                    OnBoardingPage(
                        image: MImages.onBoardingImage3,
                        title: MTexts.onBoardingTitle3,
                        subTitle: MTexts.onBoardingSubTitle3)
                  ],
                ),
                state.currentPageIndex == 2
                    ? const SizedBox()
                    : OnBoardingSkip(
                        onPressed: () {
                          context.read<OnboardingPageBloc>().add(SkipPage());
                        },
                        title: Text(
                          "Skip",
                          style: TextStyle(
                              color:
                                  dark ? MAppColors.white : MAppColors.black),
                        )),
                const ExpandingDots(),
                const NextButton()
              ],
            );
          },
        ),
      ),
    );
  }
}
