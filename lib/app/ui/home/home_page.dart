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
import 'package:alamuti/app/ui/details/detail_page.dart';
import 'package:alamuti/app/ui/imgaebase64.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class HomePage extends StatefulWidget {
  final String? adstype;

  const HomePage({Key? key, this.adstype}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTap = 4;
  bool isTyping = false;
  TextEditingController _textEditingController = TextEditingController();
  var ap = AdvertisementProvider();

  List<Advertisement> adsList = [];

  ConnectionController connectionController = Get.put(ConnectionController());

  ScreenController screenController = Get.put(ScreenController());

  ListAdvertisementController listAdvertisementController =
      Get.put(ListAdvertisementController());

  NewMessageController newMessageController = Get.put(NewMessageController());

  late SignalRHelper signalHelper;

  var mp = MessageProvider();

  getChatMessageGroups() async {
    return await mp.getGroups();
  }

  @override
  void initState() {
    super.initState();
    getChatMessageGroups();
    mp.getGroups();
    ap.getAll();
    // ap.getAll(widget.adstype ?? " ").then((value) {
    //   if (value == null) {
    //     print('value is null');
    //   }
    //   setState(() {
    //     adsList = value;
    //   });
    //   print(adsList.length);
    // });

    // signalHelper = SignalRHelper();
    // signalHelper.initiateConnection();
    // signalHelper.reciveMessage();
    connectionController.checkConnectionStatus();
  }

  int tag = 0;
  @override
  Widget build(BuildContext context) {
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
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height / 5.7),
        child: SafeArea(
          // minimum: EdgeInsets.symmetric(vertical: 35),
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
                          controller: _textEditingController,
                          onTap: () {
                            setState(() {
                              isTyping = true;
                            });
                          },
                          onSubmitted: (value) {
                            if (value == '') {
                              setState(() {
                                isTyping = false;
                              });
                            }
                          },
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            prefixIcon: isKeyboardOpen
                                ? Opacity(
                                    opacity: 0.5,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3),
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
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (_textEditingController.text.isNotEmpty) {
                                  ap.findAll(_textEditingController.text)
                                    ..then((value) {
                                      if (value == null || value.length == 0) {
                                        // print('value is null');
                                        Get.rawSnackbar(
                                          messageText: Text(
                                            'چیزی پیدا نشد',
                                            style:
                                                TextStyle(color: Colors.white),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          adsList = value;
                                        });
                                      }

                                      // print(adsList.length);
                                    });
                                }

                                // _textEditingController.clear();
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
          ? Center(
              child: Text('لطفا اتصال به اینترنت همراه خود را بررسی کنید'),
            )
          : Obx(() => ListView.builder(
                itemCount: listAdvertisementController.adsList.length,
                itemBuilder: (BuildContext context, int Index) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 5,
                    child: GestureDetector(
                      onTap: () => Get.to(
                          () => AdsDetail(
                                byteImage1: listAdvertisementController
                                    .adsList[Index].photo1,
                                byteImage2: listAdvertisementController
                                    .adsList[Index].photo2,
                                price: listAdvertisementController
                                    .adsList[Index].price
                                    .toString(),
                                sendedDate: listAdvertisementController
                                    .adsList[Index].datePosted,
                                title: listAdvertisementController
                                    .adsList[Index].title,
                                userId: listAdvertisementController
                                    .adsList[Index].userId,
                                description: listAdvertisementController
                                    .adsList[Index].description,
                              ),
                          transition: Transition.noTransition),
                      child: Obx(() => Container(
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
                                    horizontal:
                                        MediaQuery.of(context).size.width / 50),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: (listAdvertisementController
                                                    .adsList[Index].photo1 ==
                                                null)
                                            ? Opacity(
                                                opacity: 0.6,
                                                child: Image.asset(
                                                  'assets/logo/no-image.png',
                                                  fit: BoxFit.fitHeight,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6,
                                                ),
                                              )
                                            : Image.memory(
                                                base64Decode(
                                                  listAdvertisementController
                                                      .adsList[Index].photo1,
                                                ),
                                                fit: BoxFit.fitHeight,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                              ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              70),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            listAdvertisementController
                                                .adsList[Index].title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15),
                                            textDirection: TextDirection.rtl,
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                18,
                                          ),
                                          Text(
                                            '${listAdvertisementController.adsList[Index].price.toString()}  تومان',
                                            style: TextStyle(
                                                fontFamily: 'IRANSansXFaNum',
                                                fontWeight: FontWeight.w300),
                                            textDirection: TextDirection.rtl,
                                          ),
                                          Text(
                                            listAdvertisementController
                                                .adsList[Index].datePosted,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontFamily: 'IRANSansXFaNum',
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
                          )),
                    ),
                  );
                },
              )),
    );
  }
}
