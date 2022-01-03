// import 'package:alamuti/app/controller/selectedTapController.dart';
// import 'package:alamuti/app/ui/home/home_page.dart';
// import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
// import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
// import 'package:alamuti/app/ui/widgets/category_items.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/route_manager.dart';

// class FilterCatergoryPage extends StatelessWidget {
//   FilterCatergoryPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ScreenController>(
//       builder: (controller) {
//         return Scaffold(
//             appBar: AlamutiAppBar(
//               appBar: AppBar(),
//               title: 'دسته بندی',
//               hasBackButton: false,
//               backwidget: HomePage(),
//             ),
//             bottomNavigationBar: AlamutBottomNavBar(),
//             body: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20.0),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Container(
//                       width: Get.width,
//                       child: Text(
//                         "دسته بندی مورد نظر خود را انتخاب کنید",
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         textDirection: TextDirection.rtl,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Column(
//                     children: categoryItems
//                         .map(
//                           (x) => GestureDetector(
//                             onTap: () {
//                               Get.to(
//                                   () => HomePage(
//                                         adstype: x.state.toString(),
//                                       ),
//                                   transition: Transition.noTransition);
//                             },
//                             child: Card(
//                               elevation: 0.3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       x.title,
//                                       textDirection: TextDirection.rtl,
//                                       style: TextStyle(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                     SizedBox(
//                                       width: 15,
//                                     ),
//                                     Container(
//                                       child: Icon(
//                                         x.icon,
//                                         color: Colors.grey,
//                                         size: 40,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 ],
//               ),
//             ));
//       },
//     );
//   }
// }
