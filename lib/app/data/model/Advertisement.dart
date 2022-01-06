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
  }
}

// var ads = [
//   Advertisement(
//       datePosted: 'دقایقی پیش',
//       description:
//           '''در خیلی از روستاها دیگر درهای چوبی و خانه‌های کاهگلی و چشمه‌ی آب دیده نمی‌شود و صبح‌ها بوی دود تنور به مشام نمی‌رسد، اما در خطه‌ی بکر الموت که یکی از مناطق دیدنی استان قزوین است همچنان برخی آداب و رسوم گذشته پابرجاست.
// یکی از این آداب پختن نان سنتی است. خانم «طیبه شفیعی اصل» بانویی ۶۳ ساله از اهالی روستای محمدآباد بخش الموت غربی، همچنان برای مصرف خانواده‌ی خود در خانه نان سنتی می‌پزد و این رسم را همچنان زنده نگه داشته است.''',
//       id: 1,
//       photo: 'assets/photos/bread.jpeg',
//       price: 2000,
//       title: 'نان سنتی الموت'),
//   Advertisement(
//       datePosted: 'دیروز',
//       description:
//           '''یك كارشناس گیاهان دارویی درباره خاصیت های گیاه هندوانه كوهی به ایسنا گفت: رنگ میوه آن سبز با خطوط موازی سبز و یا زرد كمرنگ است و داخل آن قرمز و پر از دانه های كوچك و لزج است. با وجود ظاهر كوچكش، ریشه بسیار محكم و طولانی با پوست ضخیم دارد كه اغلب پس از خشك شدن از مغز چوبی آن جدا می شود.''',
//       id: 2,
//       photo: 'assets/photos/khormalo.jpeg',
//       price: 2500,
//       title: 'موز الموت'),
//   Advertisement(
//       datePosted: 'دیروز',
//       description:
//           '''در خیلی از روستاها دیگر درهای چوبی و خانه‌های کاهگلی و چشمه‌ی آب دیده نمی‌شود و صبح‌ها بوی دود تنور به مشام نمی‌رسد، اما در خطه‌ی بکر الموت که یکی از مناطق دیدنی استان قزوین است همچنان برخی آداب و رسوم گذشته پابرجاست.
// یکی از این آداب پختن نان سنتی است. خانم «طیبه شفیعی اصل» بانویی ۶۳ ساله از اهالی روستای محمدآباد بخش الموت غربی، همچنان برای مصرف خانواده‌ی خود در خانه نان سنتی می‌پزد و این رسم را همچنان زنده نگه داشته است.''',
//       id: 3,
//       photo: 'assets/photos/fruits.jpeg',
//       price: 4500,
//       title: 'میوه الموت'),
//   Advertisement(
//       datePosted: 'هفته پیش',
//       description:
//           '''در خیلی از روستاها دیگر درهای چوبی و خانه‌های کاهگلی و چشمه‌ی آب دیده نمی‌شود و صبح‌ها بوی دود تنور به مشام نمی‌رسد، اما در خطه‌ی بکر الموت که یکی از مناطق دیدنی استان قزوین است همچنان برخی آداب و رسوم گذشته پابرجاست.
// یکی از این آداب پختن نان سنتی است. خانم «طیبه شفیعی اصل» بانویی ۶۳ ساله از اهالی روستای محمدآباد بخش الموت غربی، همچنان برای مصرف خانواده‌ی خود در خانه نان سنتی می‌پزد و این رسم را همچنان زنده نگه داشته است.''',
//       id: 4,
//       photo: 'assets/photos/khormalo.jpeg',
//       price: 35600,
//       title: 'خرمالو'),
// ];
