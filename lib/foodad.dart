import 'package:alamuti/add_ads_category_page.dart';
import 'package:alamuti/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodAdForm extends StatelessWidget {
  const FoodAdForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 100,
        title: Text('ثبت آگهی'),
        backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
        leading: Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => Get.to(AddAdsCategoryPage()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.chevron_back,
                  size: 20,
                ),
                Text(
                  'بازگشت',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 18),
        child: Form(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 14),
                        child: Icon(
                          Icons.photo_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 14),
                        child: Icon(
                          Icons.photo_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 14),
                        child: Column(
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey,
                            ),
                            Text(
                              'افزودن عکس',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 8),
                child: Text(
                  'عنوان آگهی',
                  style: TextStyle(fontSize: 16),
                  textDirection: TextDirection.rtl,
                ),
              ),
              TextFormField(
                textDirection: TextDirection.rtl,
                style: TextStyle(backgroundColor: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black38.withOpacity(0.1), width: 2.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 8),
                child: Text(
                  'قیمت (به تومان)',
                  style: TextStyle(fontSize: 16),
                  textDirection: TextDirection.rtl,
                ),
              ),
              TextFormField(
                textDirection: TextDirection.rtl,
                style: TextStyle(backgroundColor: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black38.withOpacity(0.1), width: 2.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 8),
                child: Text(
                  'توضیحات',
                  style: TextStyle(fontSize: 16),
                  textDirection: TextDirection.rtl,
                ),
              ),
              TextFormField(
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                style: TextStyle(backgroundColor: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black38.withOpacity(0.1), width: 2.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Container(
                  child: SizedBox(
                    height: 47,
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(10, 210, 71, 0.5),
                      ),
                      onPressed: () {},
                      child: Text(
                        'ثبت',
                        style: TextStyle(color: Colors.grey[700], fontSize: 20),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
