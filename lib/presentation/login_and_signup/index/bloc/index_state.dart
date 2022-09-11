part of 'index_bloc.dart';

abstract class IndexState extends Equatable{
  @override
  List<Object?> get props => [];
}

class IndexInitState extends IndexState {}

class IndexLoginSuccessState extends IndexState {}

class IndexLoadingState extends IndexState {}

class IndexFailureState extends IndexState {
  final String? message;
  IndexFailureState({this.message});
}
