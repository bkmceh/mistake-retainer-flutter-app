class Mistake {

  String id;

  String causer;

  String mistake;

  String date;

  Mistake(this.causer, this.mistake, this.date);

  Mistake.fromMappedJson(Map<String, dynamic> json)
      : id = json['id'] ?? 'ID',
        causer = json['causer'] ?? 'NAME',
        mistake = json['mistake'] ?? 'MISTAKE',
        date = json['date'] ?? 'DATE';
}

class MistakeList {
  List<Mistake> mistakes;
  
  MistakeList.fromMappedJson(List<dynamic> json) {
    mistakes = json.map((mistake) => Mistake.fromMappedJson(mistake)).toList();
  }
}

class MistakeStore {
  static List<Mistake> mistakeData = List();
}