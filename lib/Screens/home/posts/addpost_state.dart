part of 'addpost_cubit.dart';

@immutable
sealed class AddpostState {}

final class AddpostInitial extends AddpostState {}

final class Addpostloaded extends AddpostState {}

final class Addpostloading extends AddpostState {}

final class AddpostError extends AddpostState {}


final class Imageloaded extends AddpostState {}
