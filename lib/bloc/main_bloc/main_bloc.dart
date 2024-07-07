import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const TabChangedState(0)) {
    on<ChangeTab>((event, emit) {
      emit(TabChangedState(event.tabIndex));
    });
  }
}
