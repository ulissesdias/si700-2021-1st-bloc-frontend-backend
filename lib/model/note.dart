class Note {
  int _dataLocation;
  String _title;
  String _description;

  Note() {
    /*
      0 = undefined
      1 = local
      2 = internet
    */
    _dataLocation = 1;
    _title = "";
    _description = "";
  }

  Note.fromMap(map) {
    this._title = map["title"];
    this._description = map["description"];
    this._dataLocation = map["dataLocation"];
  }

  String get title => _title;
  String get description => _description;
  int get dataLocation => _dataLocation;

  set title(String newTitle) {
    if (newTitle.length > 0) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length > 0) {
      this._description = newDescription;
    }
  }

  set dataLocation(int newLocation) {
    if (newLocation > 0 && newLocation < 3) {
      this._dataLocation = newLocation;
    }
  }

  toMap() {
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;
    return map;
  }
}
