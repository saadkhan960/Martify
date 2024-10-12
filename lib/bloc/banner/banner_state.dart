part of 'banner_bloc.dart';

class BannerState extends Equatable {
  final int currentIndex;
  final CarouselSliderController carouselController;
  final bool isLoading;
  final List<BannerModel> allBanners;

  BannerState(
      {CarouselSliderController? carouselController,
      this.allBanners = const <BannerModel>[],
      this.currentIndex = 0,
      this.isLoading = false})
      : carouselController = carouselController ?? CarouselSliderController();

  BannerState copyWith({
    int? currentIndex,
    bool? isLoading,
    List<BannerModel>? allBanners,
  }) {
    return BannerState(
        allBanners: allBanners ?? this.allBanners,
        carouselController: carouselController,
        currentIndex: currentIndex ?? this.currentIndex,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object> get props => [currentIndex, isLoading, allBanners];
}
