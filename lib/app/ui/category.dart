import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'food_form/food_form.dart';
import 'home/home_page.dart';
import 'job_form/job_form.dart';
import 'widgets/category_items.dart';
import 'realstate_form/realstate_form.dart';

class Category extends StatelessWidget {
  const Category({
    Key? key,
    required this.mq,
    required this.title,
  }) : super(key: key);
  final title;
  final Size mq;

  @override
  Widget build(BuildContext context) {
    final ScreenController c = Get.put(ScreenController());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: mq.width,
              child: Text(
                title,
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
                  (x) => GestureDetector(
                    onTap: () => Get.to(() {
                      if (c.getScreen() == 3) {
                        return HomePage();
                      }

                      if (x.icon == Icons.engineering) {
                        return JobForm();
                      }
                      if (x.icon == Icons.home_work) {
                        return RealStateForm();
                      }
                      if (x.icon == Icons.shopping_basket) {
                        return FoodForm();
                      }
                      return FoodForm();
                    }, transition: Transition.noTransition),
                    child: Card(
                      elevation: 0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              x.title,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
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
    );
  }
}

class CategoryItem {
  final IconData icon;
  final String title;

  CategoryItem({required this.icon, required this.title});
}
