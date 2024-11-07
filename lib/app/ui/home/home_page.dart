import 'dart:convert';

import 'package:alamuti/app/controller/category_tag_selected_item_controller.dart';
import 'package:alamuti/app/controller/search_controller.dart';
import 'package:alamuti/app/controller/text_focus_controller.dart';
import 'package:alamuti/app/data/entities/advertisement.dart';
import 'package:alamuti/app/data/entities/list_page.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/ui/constants.dart';
import 'package:alamuti/app/ui/searchbar/searchbar.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:alamuti/app/ui/widgets/exception_indicators/empty_list_indicator.dart';
import 'package:alamuti/app/ui/widgets/exception_indicators/error_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CategoryFilterController categoryFilterController = Get.find();
  SearchKeywordController searchController = Get.find();
  TextFocusController textFocusController = Get.find();

  var searchTextEditingController = TextEditingController();
  var advertisementProvider = AdvertisementProvider();

  final _pagingController =
      PagingController<int, Advertisement>(firstPageKey: 1);

  @override
  void initState() {
    searchController.isSearchResult.value = false;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height / 6.1),
        child: Card(
          color: Colors.white,
          elevation: 3,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Search(
                pagingController: _pagingController,
                textEditingController: searchTextEditingController,
                categoryFilterController: categoryFilterController,
                searchController: searchController,
                textFocusController: textFocusController,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width / 12, vertical: mq.height / 53),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: Get.width / 2.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'همه ی آگهی ها',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.visible,
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          'دسته بندی : ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 2),
                        //   child: Icon(
                        //     CupertinoIcons.square_grid_2x2,
                        //     size: Get.width / 22,
                        //     color: Colors.white,
                        //     textDirection: TextDirection.rtl,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: WillPopScope(
        onWillPop: () async {
          if (searchController.isSearchResult.value == true) {
            searchController.isSearchResult.value = false;
            searchTextEditingController.text = '';
            _pagingController.refresh();
          } else {
            await SystemNavigator.pop();
          }

          return false;
        },
        child: RefreshIndicator(
          color: Colors.greenAccent,
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: PagedListView.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Advertisement>(
              itemBuilder: (context, ads, index) => GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  await advertisementProvider.getDetails(
                      id: ads.id, context: context);
                  Get.toNamed('/detail');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
                  elevation: 12,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height / 100, horizontal: Get.width / 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.cover,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: (ads.listviewPhoto == null)
                                ? Opacity(
                                    opacity: 0.2,
                                    child: Container(
                                      height: Get.height / 7,
                                      width: Get.height / 7,
                                      decoration: BoxDecoration(
                                        // color: Colors.grey,
                                        border: Border.all(
                                            color: Colors.grey, width: 5),
                                      ),
                                      child: FractionallySizedBox(
                                        heightFactor: 0.7,
                                        widthFactor: 0.7,
                                        child: Image.asset(
                                          'assets/logo/no-image.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : Image.memory(
                                    base64Decode(
                                      ads.listviewPhoto!,
                                    ),
                                    fit: BoxFit.cover,
                                    height: Get.height / 7,
                                    width: Get.height / 7,
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
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                  textDirection: TextDirection.rtl,
                                  overflow: TextOverflow.visible,
                                ),
                                SizedBox(height: Get.height / 14),
                                Text(
                                  'تومان ${ads.price.toString()}',
                                  style: TextStyle(
                                      fontFamily: persianNumber,
                                      fontWeight: FontWeight.w300),
                                  textDirection: TextDirection.rtl,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      ads.datePosted,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontFamily: persianNumber,
                                          fontSize: 13),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    // SizedBox(
                                    //   width: 2,
                                    // ),
                                    Text(
                                      ads.village,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontFamily: persianNumber,
                                          fontSize: 13),
                                      textDirection: TextDirection.rtl,
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
              ),
              firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
                error: _pagingController.error,
                onTryAgain: () async {
                  CircularProgressIndicator();
                  SignalRHelper signalRHelper = SignalRHelper(
                      handler: () => print(
                          'instance of signalr created! on receive registered'));
                  signalRHelper.joinToGroups();
                },
              ),
              noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(
                onTryAgain: () {
                  searchTextEditingController.text = '';
                  searchController.isSearchResult.value = false;
                  CircularProgressIndicator();
                  return _pagingController.refresh();
                },
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 0),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      ListPage<Advertisement> newPage;
      if (searchController.isSearchResult.value == true) {
        newPage = await advertisementProvider.search(
          number: pageKey,
          size: 6,
          searchInput: searchController.keyword.value,
        );
      } else {
        newPage = await advertisementProvider.getAll(
            number: pageKey,
            size: 6,
            adsType: categoryFilterController.selectedFilterString.value);
      }

      final previouslyFetchedItemsCount =
          _pagingController.itemList?.length ?? 0;

      final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final newItems = newPage.itemList;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  static showCategoryDialog({required context}) {
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        elevation: 3,
        content: Container(
          height: 400,
          width: 30,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: villages.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  villages[index],
                  textDirection: TextDirection.rtl,
                ),
              );
            },
          ),
        ));
    showDialog(
      barrierDismissible: true,
      builder: (BuildContext context) => alert,
      context: context,
    );
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    _pagingController.dispose();
    super.dispose();
  }
}
