import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_models.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  /// Calls the https://rickandmortyapi.com/api/character/?page=1 endpoint.
  ///
  /// Throws a [ServerExseption] for all error codes.
  Future<List<PersonModel>> getAllPersons(int page);

  /// Calls the https://rickandmortyapi.com/api/character/?name=rick endpoint.
  ///
  /// Throws a [ServerExseption] for all error codes.
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourseImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourseImpl({required this.client});
  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    print(url);

    final responce = await client
        .get(Uri.parse(url), headers: {"Content.Type": "application/json"});
    if (responce.statusCode == 200) {
      final persons = json.decode(responce.body);
      return (persons["results"] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
