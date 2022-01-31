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
          child: Padding(
            padding: EdgeInsets.only(top: height / 100),
            child: Container(
              child: Card(
                elevation: 6,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Column(
                  children: [
                    Container(
                      // height: Get.height / 13,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            controller: searchTextEditingController,
                            style: TextStyle(
                                backgroundColor: Colors.white,
                                fontSize: width / 27,
                                fontFamily: persianNumber,
                                fontWeight: FontWeight.w300),
                            onSubmitted: (value) {
                              _seach();
                            },
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              hintText:
                                  'نام منطقه یا محصول مورد نظرتان را وارد کنید',
                              hintStyle: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  fontSize: width / 31),
                              label: SizedBox(
                                width: width / 3,
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'جستجو در',
                                        style: TextStyle(
                                            backgroundColor: Colors.transparent,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: width / 28),
                                      ),
                                      Image.asset(
                                        'assets/logo/logo.png',
                                        width: width / 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              prefixIcon: IconButton(
                                icon: Icon(
                                  CupertinoIcons.search,
                                  size: width / 15,
                                  color: Color.fromRGBO(8, 212, 76, 0.5),
                                ),
                                onPressed: () {
                                  _seach();
                                },
                              ),
                              fillColor: Colors.white,
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 0.6),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 0.6,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(112, 112, 112, 0.2),
                                    width: 2.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChipsChoice<int>.single(
                            mainAxisAlignment: MainAxisAlignment.center,
                            value:
                                categoryFilterController.selectedTapIndex.value,
                            onChanged: (val) {
                              FocusScope.of(context).unfocus();
                              searchTextEditingController.text = '';
                              searchController.isSearchResult.value = false;
                              categoryFilterController
                                  .selectedFilterString.value = filterType[val];

                              _pagingController.refresh();
                              categoryFilterController.selectedTapIndex.value =
                                  val;
                            },
                            choiceItems: C2Choice.listFrom<int, String>(
                              source: options,
                              value: (i, v) => i,
                              label: (i, v) => v,
                            ),
                            choiceStyle: C2ChoiceStyle(
                              color: Color.fromRGBO(8, 212, 76, 1),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
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

  _seach() {
    FocusScope.of(context).unfocus();

    searchController.isSearchResult.value = true;

    categoryFilterController.selectedTapIndex.value = 0;

    searchController.keyword.value = searchTextEditingController.text;

    _pagingController.refresh();

    searchController.keyword.value = searchTextEditingController.text;
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
    _pagingController.dispose();
    super.dispose();
  }
}
