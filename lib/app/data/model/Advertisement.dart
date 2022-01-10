class Advertisement {
  late int id;
  late String title;
  late String description;
  late String price;
  late String? photo1;
  late String? photo2;
  late String datePosted;
  late String adsType;
  late String area;
  late String userId;
  late bool published;
  late String phoneNumber;
  late String village;
  Advertisement(
      {required this.id,
      required this.title,
      required this.description,
      required String price,
      required this.photo1,
      required this.photo2,
      required this.adsType,
      required this.area,
      required this.userId,
      required this.published,
      required this.phoneNumber,
      required this.village,
      required this.datePosted}) {
    var value = price
        .split('')
        .reversed
        .join()
        .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)},")
        .split('')
        .reversed
        .join();
    if (value.startsWith(',')) {
      value = value.substring(1, value.length);
    }

    this.price = value;
  }

  Advertisement.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    price = json["price"];
    photo1 = json["photo1"];
    photo2 = json["photo2"];
    datePosted = json["DaySended"];
    adsType = json['adsType'];
    area = json['area'];
    userId = json['userId'];
    phoneNumber = json['phoneNumber'];
    published = json['published'];
    village = json['village'];
  }
}
