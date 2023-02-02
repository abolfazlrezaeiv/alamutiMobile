part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class HomeScreenLunchedEvent extends HomeScreenEvent {
  final int pageNumber;
  final String category;

  HomeScreenLunchedEvent({required this.pageNumber, required this.category});
  @override
  List<Object?> get props => [];
}

class HomeScreenLoadEvent extends HomeScreenEvent {
  final int pageNumber;
  final String category;
  HomeScreenLoadEvent({
    required this.pageNumber,
    required this.category,
  });
  @override
  List<Object?> get props => [category, pageNumber];
}

class ChangeCategoryEvent extends HomeScreenEvent {
  final int pageNumber;
  final String category;

  ChangeCategoryEvent({
    required this.pageNumber,
    required this.category,
  });
  @override
  List<Object?> get props => [pageNumber, category];
}

class HomeScreenDetailScreenEvent extends HomeScreenEvent {
  @override
  List<Object?> get props => [];
}
