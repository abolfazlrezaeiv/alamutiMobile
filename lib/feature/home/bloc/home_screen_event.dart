part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class HomeScreenLoadEvent extends HomeScreenEvent {
  final String adsCategory;
  final int pageKey;

  HomeScreenLoadEvent({required this.adsCategory, required this.pageKey});
  @override
  List<Object?> get props => [adsCategory, pageKey];
}

class HomeScreenPullToRefreshStarted extends HomeScreenEvent {
  final String adsCategory;
  final int pageKey;

  HomeScreenPullToRefreshStarted(
      {required this.adsCategory, required this.pageKey});
  @override
  List<Object?> get props => [adsCategory, pageKey];
}

class HomeScreenSearchSubmitted extends HomeScreenEvent {
  final String searchKeyword;
  final int pageKey;

  HomeScreenSearchSubmitted(
      {required this.searchKeyword, required this.pageKey});
  @override
  List<Object?> get props => [searchKeyword, pageKey];
}

class HomeScreenCategoryTapped extends HomeScreenEvent {
  final String adsCategory;
  final int pageKey;

  HomeScreenCategoryTapped({required this.adsCategory, required this.pageKey});
  @override
  List<Object?> get props => [adsCategory, pageKey];
}

class HomeScreenAdvertisementItemTapped extends HomeScreenEvent {
  @override
  List<Object?> get props => [];
}
