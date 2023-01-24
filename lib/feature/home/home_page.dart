import 'dart:convert';

import 'package:alamuti/controller/ads_form_controller.dart';
import 'package:alamuti/controller/category_tag_selected_item_controller.dart';
import 'package:alamuti/controller/search_controller.dart';
import 'package:alamuti/data/apicall/advertisement_apicall.dart';
import 'package:alamuti/data/apicall/chat_message_apicall.dart';
import 'package:alamuti/data/apicall/signalr_helper.dart';
import 'package:alamuti/data/entities/advertisement.dart';
import 'package:alamuti/data/repository/advertisement_repo.dart';
import 'package:alamuti/feature/home/bloc/home_screen_bloc.dart';
import 'package:alamuti/feature/searchbar/searchbar.dart';
import 'package:alamuti/feature/theme.dart';
import 'package:alamuti/feature/widgets/bottom_navbar.dart';
import 'package:alamuti/feature/widgets/exception_indicators/empty_list_indicator.dart';
import 'package:alamuti/feature/widgets/exception_indicators/error_indicator.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  AdvertisementAPICall advertisementProvider = AdvertisementAPICall();

  final List<String> filterType = [
    '',
    AdsFormState.FOOD.toString(),
    AdsFormState.Trap.toString(),
    AdsFormState.JOB.toString(),
    AdsFormState.REALSTATE.toString()
  ];

  static const List<String> categories = [
    'همه',
    'مواد غذایی',
    'دام',
    'خدمات',
    'املاک',
  ];

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
    var mq = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => AdvertisementRepository(AdvertisementAPICall()),
      child: BlocProvider(
        create: (context) => HomeScreenBloc(
            advertisementRepository: context.read<AdvertisementRepository>())
          ..add(HomeScreenLoadEvent(pageKey: 1, adsCategory: '')),
        child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(mq.height / 6.1),
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: SearchTextField(
                          pagingController: _pagingController,
                          textEditingController: searchTextEditingController,
                          categoryFilterController: categoryFilterController,
                          searchController: searchController,
                        ),
                      ),
                      Obx(
                        () => ChipsChoice<int>.single(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            source: categories,
                            value: (i, v) => i,
                            label: (i, v) => v,
                          ),
                          choiceStyle: C2ChoiceStyle(
                            color: Color.fromRGBO(8, 212, 76, 1),
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
                          await advertisementProvider.getDetails(id: ads.id);
                          Get.toNamed('/detail');
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Colors.transparent, width: 0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          margin: index == 0
                              ? EdgeInsets.only(
                                  top: 15, bottom: 6, left: 8, right: 8)
                              : EdgeInsets.only(
                                  top: 8, bottom: 6, left: 8, right: 8),
                          elevation: 12,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height / 100,
                                horizontal: Get.width / 40),
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
                                                    color: Colors.grey,
                                                    width: 5),
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
                                    padding: EdgeInsets.symmetric(
                                        vertical: Get.height / 70),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                          height: Get.height / 14,
                                        ),
                                        Text(
                                          'تومان ${ads.price.toString()}',
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
                      firstPageErrorIndicatorBuilder: (context) =>
                          ErrorIndicator(
                        error: _pagingController.error,
                        onTryAgain: () async {
                          var messageProvider = MessageProvider();

                          SignalRHelper signalRHelper = SignalRHelper(
                              handler: () => print(
                                  'instance of signalr created! on reveive registered'));
                          var chats =
                              await messageProvider.getGroupsNoPagination();

                          chats.forEach(
                              (group) => signalRHelper.joinToGroup(group.name));
                          _pagingController.refresh();
                        },
                      ),
                      noItemsFoundIndicatorBuilder: (context) =>
                          EmptyListIndicator(
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
          },
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
          size: 6,
          searchInput: searchController.keyword.value,
        );
      } else {
        newPage = await advertisementProvider.getAll(
            number: pageKey,
            size: 6,
            category: categoryFilterController.selectedFilterString.value);
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
