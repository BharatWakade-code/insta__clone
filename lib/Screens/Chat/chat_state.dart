part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatListLoading extends ChatState {}

final class ChatListLoaded extends ChatState {}

final class Userloaded extends ChatState {
  final String username;
  Userloaded({required this.username});
}


final class UserloadedError extends ChatState {
  final String message;
  UserloadedError({required this.message});
}