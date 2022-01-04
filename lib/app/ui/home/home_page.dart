import 'dart:convert';
import 'package:alamuti/app/controller/ConnectionController.dart';
import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/controller/advertisementController.dart';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/data/model/Advertisement.dart';
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
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  final String? adstype;

  const HomePage({Key? key, this.adstype}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isTyping = false;

  var _searchTextEditingController = TextEditingController();

  var ap = AdvertisementProvider();

  List<Advertisement> adsList = [];

  var connectionController = Get.put(ConnectionController());

  var screenController = Get.put(ScreenController());

  var listAdvertisementController = Get.put(ListAdvertisementController());

  var newMessageController = Get.put(NewMessageController());

  var signalHelper = SignalRHelper();

  var mp = MessageProvider();
  var storage = GetStorage();
  getChatMessageGroups() async {
    return await mp.getGroups();
  }

  @override
  void initState() {
    super.initState();
    ap.getAll();
  }

  int tag = 0;
  @override
  Widget build(BuildContext context) {
    signalHelper.initiateConnection();
    signalHelper.reciveMessage();
    signalHelper.createGroup(
      storage.read(CacheManagerKey.USERID.toString()),
    );
    getChatMessageGroups();
    mp.getGroups();

    connectionController.checkConnectionStatus();
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom == 0;
    var filterType = [
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
                        child: TextField(
                          controller: _searchTextEditingController,
                          style: TextStyle(
                              backgroundColor: Colors.white,
                              fontSize: Get.width / 27,
                              fontFamily: persianNumber,
                              fontWeight: FontWeight.w300),
                          onSubmitted: (value) async {
                            FocusScope.of(context).unfocus();

                            await ap.search(_searchTextEditingController.text);
                          },
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(
                              8,
                            ),
                            prefixIcon: isKeyboardOpen
                                ? Opacity(
                                    opacity: 0.5,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width / 2.3),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/logo/logo.png',
                                            width: 60,
                                          ),
                                          Text(
                                            'جستجو در',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Text(''),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(112, 112, 112, 0.2),
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                CupertinoIcons.search,
                                size: 30,
                                color: Color.fromRGBO(8, 212, 76, 0.5),
                              ),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                await ap
                                    .search(_searchTextEditingController.text);
                              },
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(112, 112, 112, 0.2),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ChipsChoice<int>.single(
                      value: tag,
                      onChanged: (val) {
                        ap.getAll(filterType[val]);
                        setState(() => tag = val);
                      },
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                      choiceStyle:
                          C2ChoiceStyle(color: Color.fromRGBO(8, 212, 76, 1)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: (!connectionController.isConnected.value)
          ? RefreshIndicator(
              onRefresh: () async {
                print('hi');
                connectionController.checkConnectionStatus();
                return await ap.getAll();
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.wifi_slash),
                    Text('لطفا اتصال به اینترنت همراه خود را بررسی کنید'),
                  ],
                ),
              ),
            )
          : Obx(
              () => RefreshIndicator(
                onRefresh: () async {
                  connectionController.checkConnectionStatus();
                  return await ap.getAll();
                },
                child: ListView.builder(
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
                                    userId: listAdvertisementController
                                        .adsList[index].userId,
                                    description: listAdvertisementController
                                        .adsList[index].description,
                                  ),
                              transition: Transition.noTransition);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height / 70),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              listAdvertisementController
                                                  .adsList[index].title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                              textDirection: TextDirection.rtl,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height / 18,
                                          ),
                                          Text(
                                            '${listAdvertisementController.adsList[index].price.toString()}  تومان',
                                            style: TextStyle(
                                                fontFamily: persianNumber,
                                                fontWeight: FontWeight.w300),
                                            textDirection: TextDirection.rtl,
                                          ),
                                          Text(
                                            listAdvertisementController
                                                .adsList[index].datePosted,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontFamily: persianNumber,
                                                fontSize: 13),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
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
    );
  }
}
