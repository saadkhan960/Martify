part of 'onboarding_page_bloc.dart';

abstract class OnboardingPageEvent extends Equatable {
  const OnboardingPageEvent();

  @override
  List<Object> get props => [];
}

// Update Current Index when Page Scroll

class UpdatePageIndicator extends OnboardingPageEvent {
  final int index;
  const UpdatePageIndicator({required this.index});
  @override
  List<Object> get props => [index];
}

// Jump to the specific dot selected page.

class DotNavigationClick extends OnboardingPageEvent {
  final int index;
  const DotNavigationClick({required this.index});
  @override
  List<Object> get props => [index];
}

// Update Current Index & jump to next page
class NextPage extends OnboardingPageEvent {
  final BuildContext context;

  const NextPage(this.context);

  @override
  List<Object> get props => [context];
}

// Update Current Index & jump to the last Page
class SkipPage extends OnboardingPageEvent {}
