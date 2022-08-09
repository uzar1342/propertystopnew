class PropertyDetails {
  final String title, value;

  PropertyDetails({
    required this.title,
    required this.value,
  });
}

class PropertyDetailPlaces {
  final String place, desc;

  PropertyDetailPlaces({
    required this.place,
    required this.desc,
  });
}

class Property {
  final String image, name, configuration, location, description;
  final bool ready;
  final List<String> amenities, features, images;
  final List<PropertyDetails> propDets;
  final List<PropertyDetailPlaces> propPlaces;
  final double lat, lng;

  Property({
    required this.image,
    required this.name,
    required this.configuration,
    required this.location,
    required this.ready,
    required this.description,
    required this.amenities,
    required this.features,
    required this.images,
    required this.propDets,
    required this.propPlaces,
    required this.lat,
    required this.lng,
  });
}

// ignore: non_constant_identifier_names
List<Property> dummy_properties = [
  Property(
      image: "assets/property_images/1.jpeg",
      name: "Amara - Lodha",
      configuration: "Flat - 4 Wings",
      location: "Geeta Nagar Phase 2, Thane, Maharashtra, India",
      ready: false,
      amenities: [
        "Swimming Pool",
        "Laundry Room",
        "Gym",
        "Fire Alarm",
        "Reserved Parking"
      ],
      features: [
        "TV Cable & WIFI",
        "Microwave",
        "Air Conditioning",
        "Central Heating",
        "Fully Furnished",
        "Semi Furnished"
      ],
      images: [
        'assets/property_images/1.jpeg',
        'assets/property_images/2.jpeg',
        'assets/property_images/3.jpeg'
      ],
      propDets: [
        PropertyDetails(title: "Maharera Number", value: "MAH56745"),
        PropertyDetails(title: "Property Status", value: "Active"),
        PropertyDetails(title: "Possesssion Date", value: "16 June, 2022"),
        PropertyDetails(title: "Floors", value: "18 floors"),
        PropertyDetails(title: "Wings", value: "4 wings"),
        PropertyDetails(title: "Property Type", value: "Commercial"),
      ],
      propPlaces: [
        PropertyDetailPlaces(place: "Park/Garden", desc: "Shivar Garden"),
        PropertyDetailPlaces(place: "School/Play School", desc: "NH"),
      ],
      lat: 19.284760000000,
      lng: 72.867500000000,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
  Property(
      image: "assets/property_images/2.jpeg",
      name: "Bunty - JP Infra",
      configuration: "Apartment - 5 Wings",
      location: "Mira Road East, Thane, Maharashtra, India",
      ready: true,
      amenities: [
        "Swimming Pool",
        "Laundry Room",
        "Gym",
        "Fire Alarm",
        "Reserved Parking"
      ],
      features: [
        "TV Cable & WIFI",
        "Microwave",
        "Air Conditioning",
        "Central Heating",
        "Fully Furnished",
        "Semi Furnished"
      ],
      images: [
        'assets/property_images/1.jpeg',
        'assets/property_images/2.jpeg',
        'assets/property_images/3.jpeg'
      ],
      propDets: [
        PropertyDetails(title: "Maharera Number", value: "MAH56745"),
        PropertyDetails(title: "Property Status", value: "Active"),
        PropertyDetails(title: "Possesssion Date", value: "16 June, 2022"),
        PropertyDetails(title: "Floors", value: "18 floors"),
        PropertyDetails(title: "Wings", value: "4 wings"),
        PropertyDetails(title: "Property Type", value: "Commercial"),
      ],
      propPlaces: [
        PropertyDetailPlaces(place: "Park/Garden", desc: "Shivar Garden"),
        PropertyDetailPlaces(place: "School/Play School", desc: "NH"),
      ],
      lat: 19.284760000000,
      lng: 72.867500000000,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
  Property(
      image: "assets/property_images/3.jpeg",
      name: "Kalpataru Namaah",
      configuration: "Flat - 2 Wings",
      location: "Geeta Nagar Phase 2, Thane, Maharashtra, India",
      ready: false,
      amenities: [
        "Swimming Pool",
        "Laundry Room",
        "Gym",
        "Fire Alarm",
        "Reserved Parking"
      ],
      features: [
        "TV Cable & WIFI",
        "Microwave",
        "Air Conditioning",
        "Central Heating",
        "Fully Furnished",
        "Semi Furnished"
      ],
      images: [
        'assets/property_images/1.jpeg',
        'assets/property_images/2.jpeg',
        'assets/property_images/3.jpeg'
      ],
      propDets: [
        PropertyDetails(title: "Maharera Number", value: "MAH56745"),
        PropertyDetails(title: "Property Status", value: "Active"),
        PropertyDetails(title: "Possesssion Date", value: "16 June, 2022"),
        PropertyDetails(title: "Floors", value: "18 floors"),
        PropertyDetails(title: "Wings", value: "4 wings"),
        PropertyDetails(title: "Property Type", value: "Commercial"),
      ],
      propPlaces: [
        PropertyDetailPlaces(place: "Park/Garden", desc: "Shivar Garden"),
        PropertyDetailPlaces(place: "School/Play School", desc: "NH"),
      ],
      lat: 19.284760000000,
      lng: 72.867500000000,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
];
