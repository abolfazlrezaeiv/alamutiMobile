import 'dart:convert';
import 'package:alamuti/app/binding/advertisement_update_binding.dart';
import 'package:alamuti/app/data/entities/advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/advetisement_form_page/advertisement_update_from_page.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:alamuti/app/ui/widgets/exception_indicators/empty_user_advertisement_screen.dart';
import 'package:alamuti/app/ui/widgets/exception_indicators/error_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UserAdvertisement extends StatefulWidget {
  UserAdvertisement({
    Key? key,
  }) : super(key: key);

  @override
  State<UserAdvertisement> createState() => _UserAdvertisementState();
}

class _UserAdvertisementState extends State<UserAdvertisement> {
  final AdvertisementProvider advertisementProvider = AdvertisementProvider();

  final _userAdvertisementPagingController =
      PagingController<int, Advertisement>(
          firstPageKey: 1, invisibleItemsThreshold: 2);

  @override
  void initState() {
    _userAdvertisementPagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Color.fromRGBO(78, 198, 122, 1.0),
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'آگهی های من',
        hasBackButton: true,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: RefreshIndicator(
        color: Colors.greenAccent,
        onRefresh: () async => _userAdvertisementPagingController.refresh(),
        child: PagedListView.separated(
          pagingController: _userAdvertisementPagingController,
          builderDelegate: PagedChildBuilderDelegate<Advertisement>(
            itemBuilder: (context, ads, index) => Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent, width: 0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              elevation: 12,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.height / 100, horizontal: Get.width / 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: (ads.photo1 == null)
                            ? (ads.photo2 == null)
                                ? Opacity(
                                    opacity: 0.2,
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Image.asset(
                                        'assets/logo/no-image.png',
                                        fit: BoxFit.cover,
                                        height: Get.height / 6,
                                        width: Get.height / 6,
                                      ),
                                    ),
                                  )
                                : Image.memory(
                                    base64Decode(
                                      ads.photo2!,
                                    ),
                                    fit: BoxFit.cover,
                                    height: Get.height / 6,
                                    width: Get.height / 6,
                                  )
                            : Image.memory(
                                base64Decode(
                                  ads.photo1!,
                                ),
                                fit: BoxFit.cover,
                                height: Get.height / 6,
                                width: Get.height / 6,
                              ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height / 70),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              ads.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(
                              height: Get.height / 13,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ads.published == false
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width / 80,
                                            vertical: Get.width / 80),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 8),
                                          child: Text(
                                            'در صف انتشار',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: Get.width / 36,
                                                color: Colors.grey),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.greenAccent,
                                              width: 0.7,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  width: Get.width / 45,
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.defaultDialog(
                                          radius: 5,
                                          title: 'از حذف آگهی مطمعن هستید؟',
                                          barrierDismissible: false,
                                          titlePadding: EdgeInsets.all(20),
                                          titleStyle: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                          ),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'آگهی به طور کامل حذف میشود و قابل بازگشت نیست',
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          cancel: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                'انصراف',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 14,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          confirm: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: TextButton(
                                                onPressed: () async {
                                                  Get.back();
                                                  await advertisementProvider
                                                      .deleteAds(
                                                          id: ads.id,
                                                          context: context);

                                                  _userAdvertisementPagingController
                                                      .refresh();
                                                },
                                                child: Text(
                                                  'حذف',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 14,
                                                      color: Colors.red),
                                                )),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'حذف',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(3),
                                        // backgroundColor:
                                        //     MaterialStateProperty.all(
                                        //   Color.fromRGBO(255, 186, 182, 1.0),
                                        // ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.white,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(
                                            () => AdvertisementUpdateForm(
                                                ads: ads),
                                            binding:
                                                AdvertisementUpdateFormBinding(),
                                            transition: Transition.fadeIn);
                                      },
                                      child: Text(
                                        'ویرایش',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all(1.5),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Color.fromRGBO(119, 224, 151, 1.0),
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
              error: _userAdvertisementPagingController.error,
              onTryAgain: () => _userAdvertisementPagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) =>
                EmptyUserAdsScreenIndicator(
              onTryAgain: () {},
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 0,
          ),
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var newPage = await advertisementProvider.getUserAds(
        number: pageKey,
        size: 6,
      );

      final previouslyFetchedItemsCount =
          _userAdvertisementPagingController.itemList?.length ?? 0;

      final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final newItems = newPage.itemList;

      if (isLastPage) {
        _userAdvertisementPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _userAdvertisementPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _userAdvertisementPagingController.error = error;
    }
  }

  @override
  void dispose() {
    _userAdvertisementPagingController.dispose();
    super.dispose();
  }
}
