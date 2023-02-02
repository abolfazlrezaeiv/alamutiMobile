import 'package:alamuti/data/datasources/apicalls/advertisement_apicall.dart';
import 'package:alamuti/data/repositories/advertisement_repo.dart';
import 'package:alamuti/domain/blocs/home/home_screen_bloc.dart';
import 'package:alamuti/presentation/common/strings/app_string.dart';
import 'package:alamuti/presentation/home/widgets/advertisement_category_selector.dart';
import 'package:alamuti/presentation/home/widgets/home_search.dart';
import 'package:alamuti/presentation/home/widgets/single_advertisement_item.dart';
import 'package:alamuti/presentation/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AdvertisementAPICall(),
        ),
        RepositoryProvider(
          create: (context) =>
              AdvertisementRepository(context.read<AdvertisementAPICall>()),
        )
      ],
      child: BlocProvider(
        create: (context) => HomeScreenBloc(
            pageSize: 18,
            advertisementRepository: context.read<AdvertisementRepository>())
          ..add(HomeScreenLunchedEvent(category: '', pageNumber: 1)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: SafeArea(
              child: Card(
                elevation: 3,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent, width: 0),
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: HomeSearchField(
                        textEditingController: _searchTextEditingController,
                      ),
                    ),
                    SizedBox(height: 10),
                    AdvertisementCategorySelector(
                      onSelected: () {
                        onCategorySelected(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: AlamutBottomNavBar(),
          body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
              void _onRefresh() async {
                if (state is HomeScreenLoadResultState) {
                  context.read<HomeScreenBloc>().add(HomeScreenLunchedEvent(
                      pageNumber: 1, category: state.category));
                  _refreshController.refreshCompleted();
                }
              }

              void _onLoading() async {
                if (state is HomeScreenLoadResultState) {
                  if (state.advertisements.totalPages > state.pageNumber) {
                    context.read<HomeScreenBloc>().add(HomeScreenLoadEvent(
                        pageNumber: state.pageNumber + 1,
                        category: state.category));
                  }
                  _refreshController.loadComplete();
                }
              }

              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: ClassicHeader(
                  completeText: AppString.pageRefreshMessage,
                  releaseText: AppString.pullToRefreshMessage,
                ),
                footer: CustomFooter(
                  builder: (context, mode) => buildListFooter(mode),
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.advertisements.itemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          Get.toNamed('/detail');
                        },
                        child: SingleAdvertisementItem(
                            item: state.advertisements.itemList[index]),
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }

  SizedBox buildListFooter(LoadStatus? mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = SizedBox();
    } else if (mode == LoadStatus.loading) {
      body = CircularProgressIndicator();
    } else if (mode == LoadStatus.failed) {
      body = Text("Load Failed!Click retry!");
    } else if (mode == LoadStatus.canLoading) {
      body = Text("release to load more");
    } else {
      body = Text("No more Data");
    }
    return SizedBox(
      height: 55.0,
      child: Center(child: body),
    );
  }

  void onCategorySelected(BuildContext context) {
    FocusScope.of(context).unfocus();
    _scrollController.jumpTo(0);
    _searchTextEditingController.text = '';
  }
}
