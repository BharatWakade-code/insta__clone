part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class IsLiked extends HomeState {
  final bool isLiked;
  IsLiked({required this.isLiked});
}
