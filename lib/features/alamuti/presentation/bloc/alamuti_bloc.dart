import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'advertisement_event.dart';
part 'advertisement_state.dart';

class AdvertisementBloc extends Bloc<AdvertisementEvent, AdvertisementState> {
  AdvertisementBloc() : super(AdvertisementInitial());
  @override
  Stream<AdvertisementState> mapEventToState(
    AdvertisementEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
