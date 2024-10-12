part of 'banner_bloc.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object> get props => [];
}

class ChangeBanner extends BannerEvent {
  final int index;
  const ChangeBanner({required this.index});
  @override
  List<Object> get props => [index];
}

class JumpToBanner extends BannerEvent {
  final int index;
  const JumpToBanner({required this.index});
  @override
  List<Object> get props => [index];
}

class Fetchbanners extends BannerEvent {
  final BuildContext context;
  const Fetchbanners({required this.context});
  @override
  List<Object> get props => [context];
}
