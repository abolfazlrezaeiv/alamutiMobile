part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  final ListPage<Advertisement> advertisements;

  HomeScreenState({required this.advertisements});
}

class HomeScreenInitialState extends HomeScreenState {
  HomeScreenInitialState()
      : super(advertisements: ListPage(totalPages: 0, itemList: []));

  @override
  List<Object?> get props => [];
}

class HomeScreenLoadingState extends HomeScreenState {
  HomeScreenLoadingState({required ListPage<Advertisement> advertisements})
      : super(advertisements: advertisements);

  @override
  List<Object?> get props => [];
}

class HomeScreenLoadResultState extends HomeScreenState {
  final int pageNumber;
  final String category;
  final int totalPages;

  HomeScreenLoadResultState(
      {required ListPage<Advertisement> advertisements,
      required this.totalPages,
      required this.category,
      required this.pageNumber})
      : super(advertisements: advertisements);

  @override
  List<Object?> get props => [pageNumber, category, totalPages];
}
