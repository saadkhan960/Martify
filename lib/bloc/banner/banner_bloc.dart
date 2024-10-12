import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:martify/Data/banner_repo/banner_repository.dart';
import 'package:martify/Model/banner_model.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerState()) {
    on<ChangeBanner>(changeBanner);
    on<JumpToBanner>(jumpToBanner);
    on<Fetchbanners>(_fetchbanners);
  }

  void changeBanner(ChangeBanner event, Emitter<BannerState> emit) {
    emit(state.copyWith(currentIndex: event.index));
  }

  void jumpToBanner(JumpToBanner event, Emitter<BannerState> emit) {
    emit(state.copyWith(currentIndex: event.index));
    if (state.carouselController.ready) {
      state.carouselController.animateToPage(event.index);
    }
  }

  void _fetchbanners(Fetchbanners event, Emitter<BannerState> emit) async {
    if (state.allBanners.isNotEmpty) {
      // If Banners are already fetched, don't fetch again
      return;
    } else {
      try {
        //Start Loading
        emit(state.copyWith(isLoading: true));

        //Fetch banners from FireStore
        final banners = await BannerRepository.fetchBanners();

        //Update the banners List
        emit(state.copyWith(allBanners: banners));

        //Stop Loading
        emit(state.copyWith(isLoading: false));
      } catch (e) {
        if (kDebugMode) {
          print("error on banner bloc while fetch banner $e");
        }
        emit(state.copyWith(isLoading: false));
        SnackbarService.showError(
            context: event.context, message: e.toString());
      } finally {
        emit(state.copyWith(isLoading: false));
      }
    }
  }
}
