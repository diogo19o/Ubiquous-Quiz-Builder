class Album {
  final String id;

  Album({this.id});

  factory Album.fromJson(Map<String, dynamic> json) {
    var all = json['respostasDaPergunta'];
    print(all.runtimeType);
    for (var a in all) {
      print(a.runtimeType);
      print(a['RespostaID']);
    }

    return Album(
      id: all[0]['RespostaID'],
    );
  }
}
