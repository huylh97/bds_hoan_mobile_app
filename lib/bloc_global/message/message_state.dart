import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';
import 'package:flutter/material.dart';

abstract class MessageState {}

class MessageInitState extends MessageState {}

class MessageShowState extends MessageState {
  final String text;
  final String? action;
  final VoidCallback? onPressed;
  final int? duration;

  MessageShowState({
    required this.text,
    this.action,
    this.onPressed,
    this.duration,
  });
}

class MessageShowHttpErrorState extends MessageState {
  final ResultApiModel resultApi;

  MessageShowHttpErrorState({required this.resultApi});
}

class MessageShowHttpSuccessState extends MessageState {
  final ResultApiModel resultApi;

  MessageShowHttpSuccessState({required this.resultApi});
}

class MessageOnLoadingState extends MessageState {
  final bool showLoading;
  final String? text;

  MessageOnLoadingState({required this.showLoading, this.text});
}
