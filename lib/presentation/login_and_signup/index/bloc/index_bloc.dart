import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firebase/firebase_layer.dart';

part 'index_event.dart';

part 'index_state.dart';

class IndexBloc extends Bloc<IndexEvent, IndexState> {
  IndexBloc({required this.service}) : super(IndexInitState());

  final LoginSignupService service;

  @override
  Stream<IndexState> mapEventToState(IndexEvent event) async* {
    if (event is IndexLoadEvent) {
      yield* _mapIndexLoadEvent();
    } else if (event is IndexGoogleLoginPressedEvent) {
      yield* _mapIndexGoogleLoginPressedEventToState(
        indexGoogleLoginPressedEvent: event,
      );
    } else if (event is IndexFacebookLoginPressedEvent) {
      yield* _mapIndexFacebookLoginPressedEventToState(
        indexFacebookLoginPressedEvent: event,
      );
    }
  }

  Stream<IndexState> _mapIndexLoadEvent() async* {
    try {
      yield IndexLoadingState();
      yield IndexLoginSuccessState();
    } on Exception catch (e) {
      yield IndexFailureState(
        message: e.toString(),
      );
    }
  }

  Stream<IndexState> _mapIndexGoogleLoginPressedEventToState(
      {required IndexGoogleLoginPressedEvent
          indexGoogleLoginPressedEvent}) async* {
    try {
      yield IndexLoadingState();
      await service.googleLogin();
      yield IndexLoginSuccessState();
    } catch (e) {
      yield IndexFailureState(
        message: e.toString(),
      );
    }
  }

  Stream<IndexState> _mapIndexFacebookLoginPressedEventToState(
      {required IndexFacebookLoginPressedEvent
          indexFacebookLoginPressedEvent}) async* {
    try {
      yield IndexLoadingState();
      await service.facebookLogin();
      yield IndexLoginSuccessState();
    } catch (e) {
      yield IndexFailureState(
        message: e.toString(),
      );
    }
  }
}
