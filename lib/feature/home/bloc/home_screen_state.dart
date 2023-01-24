part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
}

class HomeScreenInitial extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HomeScreenFailedToLoad extends HomeScreenState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
