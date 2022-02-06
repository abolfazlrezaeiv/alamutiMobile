import 'dart:convert';
import 'package:alamuti/app/binding/detail_binding.dart';
import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/category_tag_selected_item_controller.dart';
import 'package:alamuti/app/controller/search_controller.dart';
import 'package:alamuti/app/data/entities/advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/ui/details/detail_page.dart';
import 'package:alamuti/app/ui/searchbar/searchbar.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:alamuti/app/ui/widgets/exception_indicators/empty_list_indicator.dart';
import 'package:alamuti/app/ui/widgets/exception_indicators/error_indicator.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/cupertino.dart';
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
  SearchController searchController = Get.find();

  TextEditingController searchTextEditingController = TextEditingController();
  AdvertisementProvider advertisementProvider = AdvertisementProvider();

  final List<String> filterType = [
    '',
    AdsFormState.FOOD.toString(),
    AdsFormState.Trap.toString(),
    AdsFormState.JOB.toString(),
    AdsFormState.REALSTATE.toString()
  ];

  static const List<String> options = [
    'همه',
    'مواد غذایی',
    'دام',
    'مشاغل',
    'املاک',
  ];

  final double width = Get.width;
  final double height = Get.height;

  final _pagingController = PagingController<int, Advertisement>(
      firstPageKey: 1, invisibleItemsThreshold: 2);

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height / 5.9),
        child: SafeArea(
          minimum: EdgeInsets.only(top: 30),
          child: Card(
            elevation: 7,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Search(
                  pagingController: _pagingController,
                  textEditingController: searchTextEditingController,
                  categoryFilterController: categoryFilterController,
                  searchController: searchController,
                ),
                Obx(() => ChipsChoice<int>.single(
                      padding: EdgeInsets.all(0),
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      value: categoryFilterController.selectedTapIndex.value,
                      onChanged: (val) {
                        FocusScope.of(context).unfocus();
                        searchTextEditingController.text = '';
                        searchController.isSearchResult.value = false;
                        categoryFilterController.selectedFilterString.value =
                            filterType[val];

                        _pagingController.refresh();
                        categoryFilterController.selectedTapIndex.value = val;
                      },
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                      choiceStyle: C2ChoiceStyle(
                        color: Color.fromRGBO(8, 212, 76, 1),
                      ),
                    ))
              ],
            ),
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
                  Get.to(
                      () => AdsDetail(
                            id: ads.id,
                          ),
                      binding: DetailPageBinding(),
                      transition: Transition.fadeIn);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: height / 100, horizontal: width / 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.cover,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: (ads.listviewPhoto == null)
                                  ? Opacity(
                                      opacity: 0.2,
                                      child: Image.asset(
                                        'assets/logo/no-image.png',
                                        fit: BoxFit.cover,
                                        height: height / 6,
                                        width: height / 6,
                                      ),
                                    )
                                  : Image.memory(
                                      base64Decode(
                                        ads.listviewPhoto!,
                                      ),
                                      fit: BoxFit.cover,
                                      height: height / 6,
                                      width: height / 6,
                                    ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height / 70),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  SizedBox(
                                    height: height / 18,
                                  ),
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
              ),
              firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
                error: _pagingController.error,
                onTryAgain: () async {
                  var messageProvider = MessageProvider();

                  SignalRHelper signalRHelper = SignalRHelper(
                      handler: () => print(
                          'instance of signalr created! on reveive registered'));
                  var chats = await messageProvider.getGroupsNoPagination();

                  chats.forEach(
                      (group) => signalRHelper.joinToGroup(group.name));
                  _pagingController.refresh();
                },
              ),
              noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(
                onTryAgain: () {
                  searchTextEditingController.text = '';
                  searchController.isSearchResult.value = false;
                  return _pagingController.refresh();
                },
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 0,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var newPage;
      if (searchController.isSearchResult.value == true) {
        newPage = await advertisementProvider.search(
          number: pageKey,
          size: 10,
          searchInput: searchController.keyword.value,
        );
      } else {
        newPage = await advertisementProvider.getAll(
            number: pageKey,
            size: 10,
            adstype: categoryFilterController.selectedFilterString.value);
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

  @override
  void dispose() {
    searchTextEditingController.dispose();
    _pagingController.dispose();
    super.dispose();
  }
}
