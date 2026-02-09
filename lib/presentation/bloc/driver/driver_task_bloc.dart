import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/network/driver/driver_repository.dart';
import '../../../core/network/driver/driver_models.dart';

// Events
abstract class DriverTaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDriverTasks extends DriverTaskEvent {}
class AcceptTask extends DriverTaskEvent {
  final String taskId;
  AcceptTask(this.taskId);
  @override
  List<Object?> get props => [taskId];
}
class CompleteTask extends DriverTaskEvent {
  final String taskId;
  final String? mediaToken;
  CompleteTask(this.taskId, {this.mediaToken});
  @override
  List<Object?> get props => [taskId, mediaToken];
}

// State
abstract class DriverTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DriverTaskInitial extends DriverTaskState {}
class DriverTaskLoading extends DriverTaskState {}
class DriverTasksLoaded extends DriverTaskState {
  final List<DriverTaskSummary> tasks;
  DriverTasksLoaded(this.tasks);
  @override
  List<Object?> get props => [tasks];
}
class DriverTaskActionSuccess extends DriverTaskState {}
class DriverTaskError extends DriverTaskState {
  final String message;
  DriverTaskError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class DriverTaskBloc extends Bloc<DriverTaskEvent, DriverTaskState> {
  final DriverRepository repository;

  DriverTaskBloc({required this.repository}) : super(DriverTaskInitial()) {
    on<FetchDriverTasks>((event, emit) async {
      emit(DriverTaskLoading());
      try {
        final tasks = await repository.getAssignedTasks();
        emit(DriverTasksLoaded(tasks));
      } catch (e) {
        emit(DriverTaskError(e.toString()));
      }
    });

    on<AcceptTask>((event, emit) async {
      emit(DriverTaskLoading());
      try {
        await repository.acceptTask(event.taskId);
        emit(DriverTaskActionSuccess());
        add(FetchDriverTasks()); // Refresh list
      } catch (e) {
        emit(DriverTaskError(e.toString()));
      }
    });

    on<CompleteTask>((event, emit) async {
      emit(DriverTaskLoading());
      try {
        await repository.completeTask(event.taskId, mediaToken: event.mediaToken);
        emit(DriverTaskActionSuccess());
        add(FetchDriverTasks()); // Refresh list
      } catch (e) {
        emit(DriverTaskError(e.toString()));
      }
    });
  }
}
