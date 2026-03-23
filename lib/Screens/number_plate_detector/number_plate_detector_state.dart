import 'package:meta/meta.dart';

@immutable
abstract class NumberPlateState {}

class NumberPlateInitial extends NumberPlateState {}

class NumberPlateLoading extends NumberPlateState {}

class NumberPlateConnected extends NumberPlateState {}

class NumberPlateDetected extends NumberPlateState {
  final String plate;

  NumberPlateDetected(this.plate);
}

class NumberPlateError extends NumberPlateState {
  final String message;

  NumberPlateError(this.message);
}

class NumberPlateDisconnected extends NumberPlateState {}