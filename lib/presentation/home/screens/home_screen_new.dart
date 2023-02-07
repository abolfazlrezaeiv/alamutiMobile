import 'package:alamuti/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreenNew extends StatefulWidget {
  HomeScreenNew({Key? key}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AppBottomNavigationBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            backgroundColor: Colors.transparent,
            expandedHeight: 250.0,
            collapsedHeight: 60,
            elevation: 0,
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/alamutsilver.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 1),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0.9),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "جستجو در الموتی",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xff28cac0),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(9)),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/categories.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: Card(
                    elevation: 10,
                    color: Colors.white,
                    child: Center(child: Text("Item $index")),
                  ),
                ),
              );
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  MySliverPersistentHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 180;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
