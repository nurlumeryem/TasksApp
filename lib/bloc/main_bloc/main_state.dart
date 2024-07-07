part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class TabChangedState extends MainState {
  final int tabIndex;

  const TabChangedState(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
