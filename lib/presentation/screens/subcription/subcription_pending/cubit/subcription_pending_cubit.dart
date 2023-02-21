import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subcription_pending_state.dart';

class SubcriptionPendingCubit extends Cubit<SubcriptionPendingState> {
  SubcriptionPendingCubit() : super(SubcriptionPendingInitial());
}
