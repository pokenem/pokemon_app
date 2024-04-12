import 'package:pokemon_app/model/pokemon_info.dart';
import 'package:test/test.dart';

void main() {
  group('Test fromJson, toJson, getStringFromTypes in PokemonInfo', () {
    test('fromJson() should correctly parse JSON data', () {
      Map<dynamic, dynamic> resp = {
        'name': 'bulbasaur',
        'height': 7,
        'weight': 69,
        "sprites": {
          'front_default':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
        },
        "types": [
          {
            "slot": 1,
            "type": {
              "name": "grass",
              "url": "https://pokeapi.co/api/v2/type/12/"
            }
          },
          {
            "slot": 2,
            "type": {
              "name": "poison",
              "url": "https://pokeapi.co/api/v2/type/4/"
            }
          }
        ],
      };

      PokemonInfo pokemonInfoResp = PokemonInfo.fromJson(resp);

      String expectedName = 'bulbasaur';
      int expectedHeight = 7;
      String expectedImageUrl =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png';
      List<String> expectedTypes = ['grass', 'poison'];
      int expectedWeight = 69;
      expect(pokemonInfoResp.types, expectedTypes);
      expect(pokemonInfoResp.height, expectedHeight);
      expect(pokemonInfoResp.weight, expectedWeight);
      expect(pokemonInfoResp.name, expectedName);
      expect(pokemonInfoResp.imageUrl, expectedImageUrl);
    });

    test('toJson() should correctly convert object to JSON', () {
      Map<dynamic, dynamic> resp = {
        'name': 'bulbasaur',
        'height': 7,
        'weight': 69,
        "sprites": {
          'front_default':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
        },
        "types": [
          {
            "type": {"name": "grass"}
          },
          {
            "type": {"name": "poison"}
          }
        ],
      };
      Map<dynamic, dynamic> pokemonInfo = PokemonInfo(
              name: 'bulbasaur',
              height: 7,
              imageUrl:
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
              types: ['grass', 'poison'],
              weight: 69)
          .toJson();
      expect(pokemonInfo, resp);
    });

    test('Test getStringFromTypes', () {
      PokemonInfo pokemonInfo = PokemonInfo(
          name: 'bulbasaur',
          height: 7,
          imageUrl:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
          types: ['grass', 'poison'],
          weight: 69);
      String res = pokemonInfo.getStringFromTypes();
      String expectedRes = 'grass, poison';
      expect(res, expectedRes);
    });
  });
}
