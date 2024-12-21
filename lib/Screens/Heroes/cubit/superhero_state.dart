part of 'superhero_cubit.dart';

@immutable
sealed class SuperheroState {}

final class SuperheroInitial extends SuperheroState {}

final class SuperHeroLoading extends SuperheroState {}

final class SuperHeroLoaded extends SuperheroState {}

final class SuperHeroSuccesful extends SuperheroState {
  final String msg;
  SuperHeroSuccesful({required this.msg});
}

final class SuperHeroError extends SuperheroState {
  final String msg;
  SuperHeroError({required this.msg});
}
