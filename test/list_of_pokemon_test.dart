import 'package:pokemon_app/model/list_of_pokemon.dart';
import 'package:test/test.dart';

void main() {
  group('ListOfPokemon & Pokemon', () {
    test('fromJson() should correctly parse JSON data', () {
      final resp = {
        "previous": "https://pokeapi.co/api/v2/pokemon?offset=0&limit=20",
        "next": "https://pokeapi.co/api/v2/pokemon?offset=40&limit=20",
        "results": [
          {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
          {"name": "charmander", "url": "https://pokeapi.co/api/v2/pokemon/4/"}
        ]
      };

      const expectedPrevUrl =
          'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20';
      const expectedNextUrl =
          'https://pokeapi.co/api/v2/pokemon?offset=40&limit=20';
      const expectedCurrentUrl =
          'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20';
      final expectedList = [
        Pokemon(name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/'),
        Pokemon(
            name: 'charmander', url: 'https://pokeapi.co/api/v2/pokemon/4/'),
      ];

      final listOfPokemon = ListOfPokemon.fromJson(resp, expectedCurrentUrl);

      expect(listOfPokemon.prevUrl, expectedPrevUrl);
      expect(listOfPokemon.nextUrl, expectedNextUrl);
      expect(listOfPokemon.currentUrl, expectedCurrentUrl);
      expect(listOfPokemon.list[0].name, expectedList[0].name);
      expect(listOfPokemon.list[0].url, expectedList[0].url);
      expect(listOfPokemon.list[1].name, expectedList[1].name);
      expect(listOfPokemon.list[1].url, expectedList[1].url);
    });
  });
}
