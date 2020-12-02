class HeroClass {
  String id;
  String name;
  String intelligence;
  String speed;
  String power;
  String image;

  HeroClass(
      {this.id,
      this.name,
      this.intelligence,
      this.speed,
      this.power,
      this.image});

  HeroClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    print(id);
    print(name);
    intelligence = json['powerstats'] != null
        ? new Powerstats.fromJson(json['powerstats']).intelligence
        : null;
    speed = json['powerstats'] != null
        ? new Powerstats.fromJson(json['powerstats']).speed
        : null;
    power = json['powerstats'] != null
        ? new Powerstats.fromJson(json['powerstats']).power
        : null;
    image = json['image'] != null
        ? new ImageClass.fromJson(json['image']).url
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['intelligence'] = this.intelligence;
    data['speed'] = this.speed;
    data['power'] = this.power;
    data['image'] = this.image;
    return data;
  }
}

class Powerstats {
  String intelligence;
  String speed;
  String power;

  Powerstats({this.intelligence, this.speed, this.power});

  Powerstats.fromJson(Map<String, dynamic> json) {
    intelligence = json['intelligence'];
    speed = json['speed'];
    power = json['power'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intelligence'] = this.intelligence;
    data['speed'] = this.speed;
    data['power'] = this.power;
    return data;
  }
}

class ImageClass {
  String url;

  ImageClass({this.url});

  ImageClass.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
