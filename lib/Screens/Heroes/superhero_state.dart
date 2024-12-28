part of 'superhero_cubit.dart';

@immutable
sealed class SuperheroState {}

final class SuperheroInitial extends SuperheroState {}

final class SuperHeroLoading extends SuperheroState {}

final class SuperHeroLoaded extends SuperheroState {
  final List<Superhero>? heroesList;
  SuperHeroLoaded({required this.heroesList});
}

final class SuperHeroSuccesful extends SuperheroState {
  final String msg;
  SuperHeroSuccesful({required this.msg});
}

final class SuperHeroError extends SuperheroState {
  final String msg;
  SuperHeroError({required this.msg});
}

final class SuperHeroSearchSuccess extends SuperheroState {}
