import 'package:rick_and_morty/feature/data/models/person_models.dart';

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
  @override
  Future<List<PersonModel>> getAllPersons(int page) async {
    throw UnimplementedError();
  }

  @override
  Future<List<PersonModel>> searchPerson(String query) {
    throw UnimplementedError();
  }
}
