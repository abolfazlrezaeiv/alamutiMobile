import 'package:alamuti/presentation/common/strings/app_string.dart';
import 'package:alamuti/presentation/home/bloc/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvertisementCategorySelector extends StatefulWidget {
  AdvertisementCategorySelector({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final VoidCallback onSelected;
  @override
  State<AdvertisementCategorySelector> createState() =>
      _AdvertisementCategorySelectorState();
}

class _AdvertisementCategorySelectorState
    extends State<AdvertisementCategorySelector> {
  var itemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Center(
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            scrollDirection: Axis.horizontal,
            itemCount: AppString.homeAdsCategoryList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  widget.onSelected();
                  context.read<HomeScreenBloc>().add(ChangeCategoryEvent(
                        pageNumber: 1,
                        category: AppString.filterType[index],
                      ));
                  setState(() {
                    itemIndex = index;
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: SizedBox(
                      child: Text(
                        AppString.homeAdsCategoryList[index],
                        style: itemIndex == index
                            ? TextStyle(
                                color: Color.fromRGBO(8, 212, 76, 1),
                                fontWeight: FontWeight.w600)
                            : TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
