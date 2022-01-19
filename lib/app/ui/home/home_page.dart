import 'dart:convert';
import 'package:alamuti/app/binding/detail_binding.dart';
import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/advertisement_controller.dart';
import 'package:alamuti/app/controller/advertisement_pagination_controller.dart';
import 'package:alamuti/app/controller/advertisement_request_controller.dart';
import 'package:alamuti/app/controller/category_tag_selected_item_controller.dart';
import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/scroll_position.dart';
import 'package:alamuti/app/controller/search_avoid_update.dart';
import 'package:alamuti/app/controller/search_keyword_controller.dart';
import 'package:alamuti/app/controller/selected_category_filter_controller.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/ui/details/detail_page.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signalr_core/signalr_core.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdvertisementProvider advertisementProvider = AdvertisementProvider();

  TextEditingController searchTextEditingController = TextEditingController();

  ScrollController _scrollControl = ScrollController();

  GetStorage storage = GetStorage();

  HomeScrollController homeScrollController = Get.find();

  CategorySelectedFilterController categorySelectedFilter = Get.find();

  CategorySelectedChipsController categorySelectedChips = Get.find();

  ListAdvertisementController listAdvertisementController = Get.find();

  CheckIsSearchedController checkIsSearchController = Get.find();

  SearchKeywordController searchKeywordController = Get.find();

  AdvertisementPaginationController advertisementPaginationController =
      Get.find();

  AdvertisementRequestController advertisementRequestController = Get.find();

  List<String> filterType = [
    '',
    AdsFormState.FOOD.toString(),
    AdsFormState.Trap.toString(),
    AdsFormState.JOB.toString(),
    AdsFormState.REALSTATE.toString()
  ];

  List<String> options = [
    'همه',
    'مواد غذایی',
    'دام',
    'مشاغل',
    'املاک',
  ];

  final double width = Get.width;

  final double height = Get.height;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((duration) {
      if (advertisementRequestController.shouldSend.value == true) {
        checkIsSearchController.isSearchResult.value = false;

        homeScrollController.scrollPosition.value = 0;

        categorySelectedChips.selected.value = 0;

        advertisementPaginationController.currentPage.value = 1;

        advertisementProvider.getAll(context: context, adstype: null);
      }
      advertisementRequestController.shouldSend.value = true;
      getMessages();
    });
    _scrollControl.addListener(paginationScrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scrollControl.addListener(positionScrollListener);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (_scrollControl.hasClients) {
        _scrollControl.jumpTo(homeScrollController.scrollPosition.value);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height / 5.7),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
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
                      height: 50,
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
                            onSubmitted: (value) async {
                              FocusScope.of(context).unfocus();

                              advertisementPaginationController
                                  .currentPage.value = 1;

                              WidgetsBinding.instance
                                  ?.addPostFrameCallback((_) {
                                if (_scrollControl.hasClients) {
                                  _scrollControl.jumpTo(0);
                                }
                              });

                              checkIsSearchController.isSearchResult.value =
                                  true;

                              categorySelectedChips.selected.value = 0;

                              searchKeywordController.keyword.value =
                                  searchTextEditingController.text;

                              await advertisementProvider.search(
                                  context: context,
                                  searchInput:
                                      searchTextEditingController.text);

                              searchKeywordController.keyword.value =
                                  searchTextEditingController.text;
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
                                  size: 30,
                                  color: Color.fromRGBO(8, 212, 76, 0.5),
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();

                                  WidgetsBinding.instance
                                      ?.addPostFrameCallback((_) {
                                    if (_scrollControl.hasClients) {
                                      _scrollControl.jumpTo(0);
                                    }
                                  });

                                  advertisementPaginationController
                                      .currentPage.value = 1;

                                  await advertisementProvider.search(
                                      context: context,
                                      searchInput:
                                          searchTextEditingController.text);

                                  searchKeywordController.keyword.value =
                                      searchTextEditingController.text;

                                  advertisementRequestController
                                      .shouldSend.value = false;

                                  categorySelectedChips.selected.value = 0;
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
                            value: categorySelectedChips.selected.value,
                            onChanged: (val) {
                              FocusScope.of(context).unfocus();
                              searchTextEditingController.text = '';

                              advertisementPaginationController
                                  .currentPage.value = 1;

                              checkIsSearchController.isSearchResult.value =
                                  false;
                              categorySelectedFilter.selected.value =
                                  filterType[val];

                              advertisementProvider.getAll(
                                  context: context,
                                  adstype:
                                      categorySelectedFilter.selected.value);
                              categorySelectedChips.selected.value = val;
                              homeScrollController.scrollPosition.value = 0.0;

                              WidgetsBinding.instance
                                  ?.addPostFrameCallback((_) {
                                if (_scrollControl.hasClients) {
                                  _scrollControl.jumpTo(homeScrollController
                                      .scrollPosition.value);
                                }
                              });
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
          await SystemNavigator.pop();
          return false;
        },
        child: Obx(
          () => RefreshIndicator(
            color: Colors.greenAccent,
            onRefresh: () async {
              advertisementPaginationController.currentPage.value = 1;

              searchTextEditingController.text = '';

              return advertisementProvider.getAll(
                  context: context, isRefreshIndicator: true);
            },
            child: ListView.builder(
              controller: _scrollControl,
              itemCount: listAdvertisementController.adsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: height / 5,
                  child: GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await advertisementProvider.getDetails(
                          id: listAdvertisementController.adsList[index].id,
                          context: context);
                      Get.to(
                          () => AdsDetail(
                                id: listAdvertisementController
                                    .adsList[index].id,
                              ),
                          binding: DetailPageBinding(),
                          transition: Transition.fadeIn);
                    },
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: (listAdvertisementController
                                                .adsList[index].listviewPhoto ==
                                            null)
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
                                              listAdvertisementController
                                                  .adsList[index].listviewPhoto,
                                            ),
                                            fit: BoxFit.cover,
                                            height: height / 6,
                                            width: height / 6,
                                          ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height / 70),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          listAdvertisementController
                                              .adsList[index].title,
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
                                          'تومان ${listAdvertisementController.adsList[index].price.toString()}',
                                          style: TextStyle(
                                              fontFamily: persianNumber,
                                              fontWeight: FontWeight.w300),
                                          textDirection: TextDirection.rtl,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              listAdvertisementController
                                                  .adsList[index].datePosted,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontFamily: persianNumber,
                                                  fontSize: 13),
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Text(
                                              listAdvertisementController
                                                  .adsList[index].village,
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
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void positionScrollListener() {
    homeScrollController.scrollPosition.value = _scrollControl.position.pixels;
  }

  void paginationScrollListener() {
    if (_scrollControl.offset >= _scrollControl.position.maxScrollExtent &&
        checkIsSearchController.isSearchResult.value == false) {
      if (advertisementPaginationController.hasNext.value == true) {
        advertisementPaginationController.currentPage.value =
            advertisementPaginationController.currentPage.value + 1;
        advertisementProvider.getAll(
            context: context, adstype: categorySelectedFilter.selected.value);
      }
    } else if (_scrollControl.offset >=
            _scrollControl.position.maxScrollExtent &&
        checkIsSearchController.isSearchResult.value == true) {
      if (advertisementPaginationController.hasNext.value == true) {
        advertisementPaginationController.currentPage.value =
            advertisementPaginationController.currentPage.value + 1;
        advertisementProvider.search(
            context: context,
            searchInput: searchKeywordController.keyword.value);
      }
    }
  }

  getMessages() async {
    final ChatGroupController chatGroupController =
        Get.put(ChatGroupController());

    final SignalRHelper signalHelper = SignalRHelper();

    final MessageProvider messageProvider = MessageProvider();
    messageProvider.getGroups();
    chatGroupController.groupList.listen((p0) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        if (signalHelper.getConnectionStatus() ==
            HubConnectionState.disconnected) {
          await signalHelper.initiateConnection();
        }

        chatGroupController.groupList.forEach((element) {
          signalHelper.createGroup(
            element.name,
          );
        });

        await signalHelper.reciveMessage();
      });
    });
  }
}
