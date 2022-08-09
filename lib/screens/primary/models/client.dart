class Client {
  final String name;

  Client({
    required this.name,
  });
}

// ignore: non_constant_identifier_names
List<Client> dummy_clients = [
  Client(name: "JP Infra"),
  Client(name: "Lodha"),
  Client(name: "Bunty"),
];
