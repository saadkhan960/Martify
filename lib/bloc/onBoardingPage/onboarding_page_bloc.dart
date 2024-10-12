import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:martify/configs/routes/routes_name.dart';

part 'onboarding_page_event.dart';
part 'onboarding_page_state.dart';

class OnboardingPageBloc
    extends Bloc<OnboardingPageEvent, OnboardingPageState> {
  final deviceStorage = GetStorage();
  OnboardingPageBloc() : super(OnboardingPageState()) {
    on<UpdatePageIndicator>(_updatePageIndicator);
    on<DotNavigationClick>(_dotNavigationClick);
    on<SkipPage>(_skipPage);
    on<NextPage>(_nextPage);
  }

  void _updatePageIndicator(
      UpdatePageIndicator event, Emitter<OnboardingPageState> emit) {
    // print("event${event.index}");
    emit(state.copyWith(currentPageIndex: event.index));
    // print("state${state.currentPageIndex}");
  }

  void _dotNavigationClick(
      DotNavigationClick event, Emitter<OnboardingPageState> emit) {
    emit(state.copyWith(currentPageIndex: event.index));
    if (state.pageController.hasClients) {
      state.pageController.animateToPage(event.index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  void _skipPage(SkipPage event, Emitter<OnboardingPageState> emit) {
    emit(state.copyWith(currentPageIndex: 2));
    if (state.pageController.hasClients) {
      state.pageController.jumpToPage(2);
    }
  }

  void _nextPage(NextPage event, Emitter<OnboardingPageState> emit) {
    if (state.currentPageIndex == 2) {
      deviceStorage.write("isFirstTime", false);
      Navigator.pushReplacementNamed(event.context, RoutesName.login);
    } else {
      emit(state.copyWith(currentPageIndex: state.currentPageIndex + 1));
      if (state.pageController.hasClients) {
        state.pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      }
    }
  }
}
