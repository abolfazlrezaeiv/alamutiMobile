import 'package:alamuti/app/controller/category_tag_selected_item_controller.dart';
import 'package:alamuti/app/controller/search_controller.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Search extends StatefulWidget {
  final PagingController pagingController;
  final TextEditingController textEditingController;
  final CategoryFilterController categoryFilterController;
  final SearchController searchController;
  Search(
      {Key? key,
      required this.pagingController,
      required this.textEditingController,
      required this.categoryFilterController,
      required this.searchController})
      : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: PhysicalModel(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          elevation: 4.0,
          shadowColor: Colors.grey.withOpacity(1),
          child: TextField(
            controller: widget.textEditingController,
            style: TextStyle(
                backgroundColor: Colors.white,
                fontSize: Get.width / 27,
                fontFamily: persianNumber,
                fontWeight: FontWeight.w300),
            onSubmitted: (value) {
              if (widget.textEditingController.text.isEmpty) {
                widget.pagingController.refresh();
              } else {
                _seach();
              }
            },
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'نام منطقه یا محصول مورد نظرتان را وارد کنید',
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
                  size: Get.width / 15,
                  color: Color.fromRGBO(8, 212, 76, 0.5),
                ),
                onPressed: () {
                  if (widget.textEditingController.text.isEmpty) {
                    widget.pagingController.refresh();
                  } else {
                    _seach();
                  }
                },
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 0.6),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 0.6,
                  style: BorderStyle.solid,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                // color: Color.fromRGBO(112, 112, 112, 0.2), width: 2.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _seach() {
    FocusScope.of(context).unfocus();

    widget.searchController.isSearchResult.value = true;

    widget.categoryFilterController.selectedTapIndex.value = 0;

    widget.searchController.keyword.value = widget.textEditingController.text;

    widget.pagingController.refresh();

    widget.searchController.keyword.value = widget.textEditingController.text;
  }
}
