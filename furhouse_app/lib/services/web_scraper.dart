import 'package:chaleno/chaleno.dart';
import 'package:furhouse_app/common/constants/picker_values.dart';

class WebScraper {
  void scrapCatBreeds() async {
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

    allBreedValues.addAll(catBreedValues);
  }

  void scrapDogBreeds() async {
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

    allBreedValues.addAll(dogBreedValues);
  }

  void scrapRabbitBreeds() async {
    var url = 'https://rabbitpedia.com/rabbit-breeds/';

    var response = await Chaleno().load(url);

    if (response != null) {
      var breeds = response.getElementsByClassName('wp-caption-text');
      int j, breedsSize = breeds.length;

      for (j = 0; j < breedsSize; j++) {
        if (breeds[j].text != null && breeds[j].text != "") {
          rabbitBreedValues.add(breeds[j].text as String);
        }
      }
    }

    rabbitBreedValues.sort();

    allBreedValues.addAll(rabbitBreedValues);
  }

  void scrapRodentBreeds() async {
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

    allBreedValues.addAll(rodentBreedValues);
  }

  void scrapBirdBreeds() async {
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

    allBreedValues.addAll(birdBreedValues);
  }
}
