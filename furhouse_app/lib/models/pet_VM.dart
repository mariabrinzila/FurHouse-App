class PetVM {
  int petId = 0;
  final String name;
  final String gender;
  final String category;
  final String breed;
  final String ageUnit;
  final int ageValue;
  final String location;
  final String details;
  final String priority;
  final String? description;
  final String userEmail;
  final String photoPath;
  String dateAdded;
  final bool adopted;
  final String? adoptedBy;

  PetVM({
    required this.name,
    required this.gender,
    required this.category,
    required this.breed,
    required this.ageUnit,
    required this.ageValue,
    required this.location,
    required this.details,
    required this.priority,
    required this.description,
    required this.userEmail,
    required this.photoPath,
    required this.dateAdded,
    required this.adopted,
    required this.adoptedBy,
  });

  set id(int identifier) {
    petId = identifier;
  }

  Map<String, dynamic> toMap() {
    return {
      "pet_id": petId,
      "name": name,
      "gender": gender,
      "category": category,
      "breed": breed,
      "age_unit": ageUnit,
      "age_value": ageValue,
      "location": location,
      "details": details,
      "priority": priority,
      "description": description,
      "user_email": userEmail,
      "date_added": dateAdded,
      "adopted": adopted == false ? 0 : 1,
    };
  }
}
