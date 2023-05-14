import 'package:chaleno/chaleno.dart';

class WebScraper {
  void scrapCatBreeds(List<String> catBreedValues) async {
    var url = 'https://vetschoice.guildinsurance.com.au/cats/cat-breeds';

    var response = await Chaleno().load(url);

    if (response != null) {
      var breeds = response.getElementsByClassName('breeds-image');
      int j, breedsSize = breeds.length;

      for (j = 0; j < breedsSize; j++) {
        if (breeds[j].title != null) {
          catBreedValues.add(breeds[j].title as String);
        }
      }
    }

    catBreedValues.sort();
  }

  void scrapDogBreeds(List<String> dogBreedValues) async {
    var url = 'https://vetschoice.guildinsurance.com.au/dogs/dog-breeds';

    var response = await Chaleno().load(url);

    if (response != null) {
      var breeds = response.getElementsByClassName('breeds-image');
      int j, breedsSize = breeds.length;

      for (j = 0; j < breedsSize; j++) {
        if (breeds[j].title != null) {
          dogBreedValues.add(breeds[j].title as String);
        }
      }
    }

    dogBreedValues.sort();
  }

  void scrapRabbitBreeds(List<String> rabbitBreedValues) async {
    var url =
        'https://www.goodhousekeeping.com/life/pets/g26950009/best-rabbit-breeds/';

    var response = await Chaleno().load(url);

    if (response != null) {
      var breeds = response.getElementsByClassName('css-13wrog e1tmud0h7');
      int j, breedsSize = breeds.length;

      for (j = 0; j < breedsSize; j++) {
        if (breeds[j].text != null) {
          rabbitBreedValues.add(breeds[j].text as String);
        }
      }
    }

    rabbitBreedValues.sort();
  }

  void scrapRodentBreeds(List<String> rodentBreedValues) async {
    var url = 'https://www.thesprucepets.com/small-rodents-as-pets-1237271';

    var response = await Chaleno().load(url);

    if (response != null) {
      var breeds =
          response.getElementsByClassName('mntl-sc-block-heading__link');
      int j, breedsSize = breeds.length;

      for (j = 0; j < breedsSize; j++) {
        if (breeds[j].text != null) {
          rodentBreedValues.add(breeds[j].text as String);
        }
      }
    }

    rodentBreedValues.sort();
  }

  void scrapBirdBreeds(List<String> birdBreedValues) async {
    var url = 'https://lafeber.com/pet-birds/types-of-birds/';

    var response = await Chaleno().load(url);

    if (response != null) {
      var breeds = response.querySelectorAll('.title a');
      int j, breedsSize = breeds.length;

      for (j = 0; j < breedsSize; j++) {
        if (breeds[j].text != null) {
          birdBreedValues.add(breeds[j].text as String);
        }
      }
    }

    birdBreedValues.sort();
  }
}
