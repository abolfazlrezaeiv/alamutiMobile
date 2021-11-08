import 'package:alamuti/bottom_navbar.dart';
import 'package:alamuti/foodad.dart';
import 'package:alamuti/selectedTapController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddAdsCategoryPage extends StatefulWidget {
  AddAdsCategoryPage({Key? key}) : super(key: key);

  @override
  State<AddAdsCategoryPage> createState() => _AddAdsCategoryPageState();
}

class _AddAdsCategoryPageState extends State<AddAdsCategoryPage> {
  var categoryItems = [
    CategoryItem(icon: Icons.shopping_basket, title: 'مواد غذایی'),
    CategoryItem(icon: Icons.engineering, title: 'کسب و کار'),
    CategoryItem(icon: Icons.home_work, title: 'املاک'),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScreenController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
            title: Text(
              'ثبت آگهی',
              style: TextStyle(fontSize: 19),
              textDirection: TextDirection.rtl,
            ),
          ),
          bottomNavigationBar: AlamutBottomNavBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'دسته بندی آگهی خود را انتخاب کنید',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: categoryItems
                      .map(
                        (CategoryItem x) => GestureDetector(
                          onTap: () => Get.to(() => FoodAdForm()),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    x.title,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    child: Icon(
                                      x.icon,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryItem {
  final IconData icon;
  final String title;

  CategoryItem({required this.icon, required this.title});
}
