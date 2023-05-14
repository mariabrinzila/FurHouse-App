import 'package:chaleno/chaleno.dart';

class WebScraper {
  void scrapCatBreeds(List<String> catBreedValues) async {
    var url = 'https://vetschoice.guildinsurance.com.au/cats/cat-breeds';

    var response = await Chaleno().load(url);

    if (response != null) {
      var breeds = response.getElementsByClassName('breeds-image');
      int j, breedsSize = breeds.length;

      for (j = 0; j < breedsSize; j++) {
        if (breeds[j].text != null) {
          catBreedValues.add(breeds[j].title as String);
        }
      }
    }
  }

  void scrapDogBreeds(List<String> dogBreedValues) async {
    var url = 'https://vetschoice.guildinsurance.com.au/dogs/dog-breeds';

    var response = await Chaleno().load(url);

    if (response != null) {
      var breeds = response.getElementsByClassName('breeds-image');
      int j, breedsSize = breeds.length;

      for (j = 0; j < breedsSize; j++) {
        if (breeds[j].text != null) {
          dogBreedValues.add(breeds[j].title as String);
        }
      }
    }
  }
}
