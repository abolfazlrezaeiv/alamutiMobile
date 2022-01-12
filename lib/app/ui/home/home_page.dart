import 'dart:convert';
import 'package:alamuti/app/controller/ConnectionController.dart';
import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/controller/advertisementController.dart';
import 'package:alamuti/app/controller/category_tag_selected_item.dart';
import 'package:alamuti/app/controller/homeLoadingController.dart';
import 'package:alamuti/app/controller/scroll_position.dart';
import 'package:alamuti/app/controller/search_avoid_update.dart';
import 'package:alamuti/app/controller/selected_category_filter.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/details/detail_page.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  final String? adstype;
  HomePage({Key? key, this.adstype}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdvertisementProvider advertisementProvider = AdvertisementProvider();

  SignalRHelper signalHelper = SignalRHelper();

  TextEditingController searchTextEditingController = TextEditingController();

  MessageProvider messageProvider = MessageProvider();

  ScrollController listControl = ScrollController();

  GetStorage storage = GetStorage();

  HomeScrollController homeScrollController = Get.put(HomeScrollController());

  HomeLoadingController homeLoadingController =
      Get.put(HomeLoadingController());

  CategorySelectedFilterController categorySelectedFilter =
      Get.put(CategorySelectedFilterController());

  ConnectionController connectionController = Get.put(ConnectionController());

  CategorySelectedChipsController categorySelectedChips =
      Get.put(CategorySelectedChipsController());

  ListAdvertisementController listAdvertisementController =
      Get.put(ListAdvertisementController());

  CheckIsSearchedController checkIsSearchController =
      Get.put(CheckIsSearchedController());

  List<String> filterType = [
    '',
    AdsFormState.FOOD.toString(),
    AdsFormState.JOB.toString(),
    AdsFormState.REALSTATE.toString()
  ];
  List<String> options = [
    'همه',
    'میوه و مواد غذایی',
    'مشاغل',
    'املاک',
  ];

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      advertisementProvider.getAll(context: context);
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void scrollListener() {
      homeScrollController.scrollPosition.value = listControl.position.pixels;
    }

    listControl.addListener(scrollListener);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (listControl.hasClients) {
        listControl.jumpTo(homeScrollController.scrollPosition.value);
      }
    });
    getChatMessageGroups() async {
      return await messageProvider.getGroups();
    }

    homeLoadingController.isFilterTapped.value = false;
    signalHelper.initiateConnection();
    signalHelper.reciveMessage();
    signalHelper.createGroup(
      storage.read(CacheManagerKey.USERID.toString()),
    );
    getChatMessageGroups();
    messageProvider.getGroups();
    connectionController.checkConnectionStatus();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height / 5.7),
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
                                fontSize: Get.width / 27,
                                fontFamily: persianNumber,
                                fontWeight: FontWeight.w300),
                            onSubmitted: (value) async {
                              FocusScope.of(context).unfocus();
                              checkIsSearchController.isSearchResult.value =
                                  true;
                              categorySelectedChips.selected.value = 0;
                              await advertisementProvider.search(
                                  context: context,
                                  searchInput:
                                      searchTextEditingController.text);

                              // _searchTextEditingController.text = '';
                            },
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              // helperText: 'dddddd',
                              hintText:
                                  'نام منطقه یا محصول مورد نظرتان را وارد کنید',
                              hintStyle: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  fontSize: Get.width / 31),
                              label: SizedBox(
                                width: Get.width / 3,
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
                                            fontSize: Get.width / 28),
                                      ),
                                      Image.asset(
                                        'assets/logo/logo.png',
                                        width: Get.width / 8,
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

                                  await advertisementProvider.search(
                                      context: context,
                                      searchInput:
                                          searchTextEditingController.text);

                                  checkIsSearchController.isSearchResult.value =
                                      true;

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
                    Obx(() => ChipsChoice<int>.single(
                          value: categorySelectedChips.selected.value,
                          onChanged: (val) {
                            FocusScope.of(context).unfocus();
                            searchTextEditingController.text = '';

                            checkIsSearchController.isSearchResult.value =
                                false;
                            categorySelectedFilter.selected.value =
                                filterType[val];

                            homeLoadingController.isFilterTapped.value = true;
                            // showLoaderDialog(context);
                            advertisementProvider.getAll(
                                context: context,
                                adstype: categorySelectedFilter.selected.value);
                            categorySelectedChips.selected.value = val;
                            homeScrollController.scrollPosition.value = 0.0;

                            WidgetsBinding.instance?.addPostFrameCallback((_) {
                              if (listControl.hasClients) {
                                listControl.jumpTo(
                                    homeScrollController.scrollPosition.value);
                              }
                            });
                          },
                          choiceItems: C2Choice.listFrom<int, String>(
                            source: options,
                            value: (i, v) => i,
                            label: (i, v) => v,
                          ),
                          choiceStyle: C2ChoiceStyle(
                              color: Color.fromRGBO(8, 212, 76, 1)),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: Obx(
        () => WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();

            return false;
          },
          child: RefreshIndicator(
            onRefresh: () async {
              connectionController.checkConnectionStatus();
              searchTextEditingController.text = '';

              return advertisementProvider.getAll(
                context: context,
              );
            },
            child: ListView.builder(
              controller: listControl,
              itemCount: listAdvertisementController.adsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: Get.height / 5,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();

                      Get.to(
                          () => AdsDetail(
                                byteImage1: listAdvertisementController
                                    .adsList[index].photo1,
                                byteImage2: listAdvertisementController
                                    .adsList[index].photo2,
                                price: listAdvertisementController
                                    .adsList[index].price
                                    .toString(),
                                phoneNumber: listAdvertisementController
                                    .adsList[index].phoneNumber,
                                sendedDate: listAdvertisementController
                                    .adsList[index].datePosted,
                                title: listAdvertisementController
                                    .adsList[index].title,
                                adsType: listAdvertisementController
                                    .adsList[index].adsType,
                                userId: listAdvertisementController
                                    .adsList[index].userId,
                                area: listAdvertisementController
                                    .adsList[index].area,
                                village: listAdvertisementController
                                    .adsList[index].village,
                                description: listAdvertisementController
                                    .adsList[index].description,
                              ),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width / 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: (listAdvertisementController
                                                .adsList[index].photo1 ==
                                            null)
                                        ? Opacity(
                                            opacity: 0.6,
                                            child: Image.asset(
                                              'assets/logo/no-image.png',
                                              fit: BoxFit.cover,
                                              height: Get.height / 6,
                                              width: Get.height / 6,
                                            ),
                                          )
                                        : Image.memory(
                                            base64Decode(
                                              listAdvertisementController
                                                  .adsList[index].photo1,
                                            ),
                                            fit: BoxFit.cover,
                                            height: Get.height / 6,
                                            width: Get.height / 6,
                                          ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Get.height / 70),
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
                                          height: Get.height / 18,
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
}
