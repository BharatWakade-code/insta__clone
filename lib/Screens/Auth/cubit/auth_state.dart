part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Authloading extends AuthState {}

final class Authloaded extends AuthState {}

final class Userloaded extends AuthState {
  final String username;
  Userloaded({required this.username});
}


final class UserloadedError extends AuthState {
  final String username;
  UserloadedError({required this.username});
}