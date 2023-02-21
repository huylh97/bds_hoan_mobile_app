import 'package:bloc/bloc.dart';

import 'bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitState()) {
    on<OnMessage>((event, emit) {
      emit(
        MessageShowState(
          text: event.message,
          action: event.action,
          onPressed: event.onPressed,
          duration: event.duration,
        ),
      );
    });

    on<OnHttpMessage>((event, emit) {
      if (event.resultApi.success) {
        emit(MessageShowHttpSuccessState(resultApi: event.resultApi));
      } else {
        emit(MessageShowHttpErrorState(resultApi: event.resultApi));
      }
    });

    on<OnLoadingEvent>((event, emit) {
      emit(MessageOnLoadingState(
        showLoading: event.showLoading,
        text: event.text,
      ));
    });
  }
}
