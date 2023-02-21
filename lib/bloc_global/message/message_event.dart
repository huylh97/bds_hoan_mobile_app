import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';
import 'package:flutter/material.dart';

abstract class MessageEvent {}

class OnMessage extends MessageEvent {
  final String message;
  final String? action;
  final VoidCallback? onPressed;
  final int? duration;

  OnMessage({
    required this.message,
    this.action,
    this.onPressed,
    this.duration,
  });
}

class OnHttpMessage extends MessageEvent {
  final ResultApiModel resultApi;

  OnHttpMessage({required this.resultApi});
}

class OnLoadingEvent extends MessageEvent {
  final bool showLoading;
  final String? text;

  OnLoadingEvent({required this.showLoading, this.text});
}
