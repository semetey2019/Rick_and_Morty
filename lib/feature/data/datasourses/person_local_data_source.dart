import 'dart:convert';

import 'package:rick_and_morty/feature/data/models/person_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  /// Gets the cached [List<PersonModel>] wich was gotten the last time.
  /// the user had an internet connection.
  /// Throws [CacheException] if no cached data is present.

  Future<List<PersonModel>> getLastPersonFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

const CACHED_PERSONS_LIST = "CACHED_PERSONS_LIST";

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<PersonModel>> getLastPersonFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    print("persons to write Cache: ${jsonPersonsList.length}");
    return Future.value(jsonPersonsList);
  }
}
