import 'package:alamuti/data/entities/advertisement/advertisement.dart';
import 'package:alamuti/data/entities/list_page.dart';
import 'package:alamuti/data/repositories/advertisement_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final AdvertisementRepository advertisementRepository;
  final int pageSize;
  HomeScreenBloc(
      {required this.pageSize, required this.advertisementRepository})
      : super(HomeScreenInitialState()) {
    on<HomeScreenEvent>((event, emit) async {
      if (event is HomeScreenLunchedEvent) {
        var pageList = await advertisementRepository.getAll(
            pageNumber: 1, size: pageSize, category: event.category);
        emit(HomeScreenLoadResultState(
          advertisements: pageList,
          category: '',
          pageNumber: 1,
          totalPages: pageList.totalPages,
        ));
      }
      if (event is HomeScreenLoadEvent) {
        var pageList = await advertisementRepository.getAll(
            pageNumber: event.pageNumber,
            size: pageSize,
            category: event.category);
        emit(HomeScreenLoadResultState(
            advertisements:
                state.advertisements.copy(newPage: pageList.itemList),
            totalPages: pageList.totalPages,
            category: event.category,
            pageNumber: event.pageNumber));
      }
      if (event is ChangeCategoryEvent) {
        var pageList = await advertisementRepository.getAll(
            pageNumber: 1, size: pageSize, category: event.category);
        emit(HomeScreenLoadResultState(
          advertisements: pageList,
          category: event.category,
          pageNumber: event.pageNumber,
          totalPages: pageList.totalPages,
        ));
      }
    });
  }
}
