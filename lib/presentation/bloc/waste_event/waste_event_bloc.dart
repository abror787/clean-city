import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/network/waste_event/waste_event_repository.dart';
import '../../../core/network/waste_event/waste_event_models.dart';

// Events
abstract class WasteEventEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllWasteEvents extends WasteEventEvent {}
class FetchMyWasteEvents extends WasteEventEvent {}
class ReportWasteRequested extends WasteEventEvent {
  final WasteReportRequest request;
  ReportWasteRequested(this.request);
  @override
  List<Object?> get props => [request];
}

// State
abstract class WasteEventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WasteEventInitial extends WasteEventState {}
class WasteEventLoading extends WasteEventState {}
class WasteEventsLoaded extends WasteEventState {
  final List<PublicWasteEventResponse> events;
  WasteEventsLoaded(this.events);
  @override
  List<Object?> get props => [events];
}
class WasteEventSuccess extends WasteEventState {
  final PublicWasteEventResponse event;
  WasteEventSuccess(this.event);
  @override
  List<Object?> get props => [event];
}
class WasteEventError extends WasteEventState {
  final String message;
  WasteEventError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class WasteEventBloc extends Bloc<WasteEventEvent, WasteEventState> {
  final WasteEventRepository repository;

  WasteEventBloc({required this.repository}) : super(WasteEventInitial()) {
    on<FetchAllWasteEvents>((event, emit) async {
      emit(WasteEventLoading());
      try {
        final events = await repository.getAllEvents();
        emit(WasteEventsLoaded(events));
      } catch (e) {
        emit(WasteEventError(e.toString()));
      }
    });

    on<FetchMyWasteEvents>((event, emit) async {
      emit(WasteEventLoading());
      try {
        final events = await repository.getMyEvents();
        emit(WasteEventsLoaded(events));
      } catch (e) {
        emit(WasteEventError(e.toString()));
      }
    });

    on<ReportWasteRequested>((event, emit) async {
      emit(WasteEventLoading());
      try {
        final newEvent = await repository.reportWaste(event.request);
        emit(WasteEventSuccess(newEvent));
      } catch (e) {
        emit(WasteEventError(e.toString()));
      }
    });
  }
}
