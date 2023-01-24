import 'package:alamuti/data/repository/advertisement_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final AdvertisementRepository advertisementRepository;
  HomeScreenBloc({required this.advertisementRepository})
      : super(HomeScreenInitial()) {
    on<HomeScreenEvent>((event, emit) async {
      if (event is HomeScreenLoadEvent) {
        var advertisements = await advertisementRepository.getAll(
            number: event.pageKey, size: 6, category: event.adsCategory);
      }
      if (event is HomeScreenSearchSubmitted) {
        var advertisements = await advertisementRepository.search(
            number: event.pageKey, size: 6, searchInput: event.searchKeyword);
      }
      if (event is HomeScreenCategoryTapped) {
        var advertisements = await advertisementRepository.getAll(
            number: event.pageKey, size: 6, category: event.adsCategory);
      }
    });
  }
}
