import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:insta_clone/Services/Network/services.dart';
import 'package:insta_clone/models/allsuperheroes.dart';
import 'package:insta_clone/utils/contstants.dart';
import 'package:meta/meta.dart';

part 'superhero_state.dart';

class SuperheroCubit extends Cubit<SuperheroState> {
  SuperheroCubit() : super(SuperheroInitial());

  List<Superhero>? allSuperHeroes;

  Future<void> getSuperHeroes() async {
    emit(SuperHeroLoading()); // Emit loading state
    try {
      final response = await ApiClient().getRequest(Constanst.allSupers);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final superHeroes = data.map((item) {
          return Superhero.fromJson(item);
        }).toList();
        allSuperHeroes = superHeroes;
        emit(SuperHeroSuccesful(
            msg: response.statusMessage ?? 'Data fetched successfully'));
      } else {
        emit(SuperHeroError(msg: response.statusMessage ?? 'Data fetch error'));
      }
    } catch (e) {
      emit(SuperHeroError(msg: 'Error fetching superheroes: $e'));
    }
  }
}
