class Advertisement {
  final int id;
  final String title;
  final String description;
  late String price;
  final String? photo1;
  final String? photo2;
  final String? listviewPhoto;
  final String datePosted;
  final String adsType;
  final String area;
  final String userId;
  final bool published;
  final String? phoneNumber;
  final String village;

  Advertisement(
      {required this.id,
      required this.title,
      required this.description,
      required String price,
      required this.photo1,
      required this.photo2,
      required this.listviewPhoto,
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

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toString(),
        photo1: json["photo1"],
        photo2: json["photo2"],
        listviewPhoto: json['listViewPhoto'],
        datePosted: json["daySended"],
        adsType: json['adsType'],
        area: json['area'].toString(),
        userId: json['userId'],
        phoneNumber: json['phoneNumber'],
        published: json['published'],
        village: json['village']);
  }
}
