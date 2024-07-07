part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class ChangeTab extends MainEvent {
  final int tabIndex;

  const ChangeTab(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
