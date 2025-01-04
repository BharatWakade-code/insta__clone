
import 'package:bloc/bloc.dart';
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
        emit(SuperHeroLoaded(heroesList: allSuperHeroes));
      } else {
        emit(SuperHeroError(msg: response.statusMessage ?? 'Data fetch error'));
      }
    } catch (e) {
      emit(SuperHeroError(msg: 'Error fetching superheroes: $e'));
    }
  }

  Future<List<Superhero>?> searchSuperHeroes(String query) async {
    emit(SuperHeroLoading());
    final filteredHeroes = allSuperHeroes?.where((hero) {
      final matches = hero.name.toLowerCase().contains(query.toLowerCase());
      return matches;
    }).toList();
    emit(SuperHeroLoaded(heroesList: filteredHeroes));
    return filteredHeroes;
  }
}
