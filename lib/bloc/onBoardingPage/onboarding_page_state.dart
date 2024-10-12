part of 'onboarding_page_bloc.dart';

class OnboardingPageState extends Equatable {
  final PageController pageController;
  final int currentPageIndex;

  OnboardingPageState(
      {PageController? pageController, this.currentPageIndex = 0})
      : pageController = pageController ?? PageController();

  OnboardingPageState copyWith({int? currentPageIndex}) {
    return OnboardingPageState(
        pageController: pageController,
        currentPageIndex: currentPageIndex ?? this.currentPageIndex);
  }

  @override
  List<Object> get props => [currentPageIndex];
}
