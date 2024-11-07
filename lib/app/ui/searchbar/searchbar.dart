import 'package:alamuti/app/controller/category_tag_selected_item_controller.dart';
import 'package:alamuti/app/controller/search_controller.dart';
import 'package:alamuti/app/controller/text_focus_controller.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Search extends StatefulWidget {
  final PagingController pagingController;
  final TextEditingController textEditingController;
  final CategoryFilterController categoryFilterController;
  final TextFocusController textFocusController;
  final SearchKeywordController searchController;
  Search(
      {Key? key,
      required this.pagingController,
      required this.textEditingController,
      required this.categoryFilterController,
      required this.textFocusController,
      required this.searchController})
      : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 15),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: PhysicalModel(
          borderRadius: BorderRadius.circular(9),
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.black,
          child: Obx(
            () => Focus(
              onFocusChange: (focus) =>
                  widget.textFocusController.isFocused.value = focus,
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
                    _search();
                  }
                },
                textAlign: TextAlign.right,
                decoration: InputDecoration(
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
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
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
                      // color: alamutPrimaryColor,
                      color: Colors.black26,
                    ),
                    onPressed: () {
                      if (widget.textEditingController.text.isEmpty) {
                        widget.pagingController.refresh();
                      } else {
                        _search();
                      }
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      CupertinoIcons.multiply_circle_fill,
                      textDirection: TextDirection.ltr,
                      color: widget.textFocusController.isFocused.value == true
                          ? Colors.grey
                          : Colors.transparent,
                    ),
                    onPressed: () {
                      widget.searchController.isSearchResult.value = false;
                      widget.textEditingController.text = '';
                      FocusScope.of(context).unfocus();
                      widget.pagingController.refresh();
                    },
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.6),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 0.6,
                      style: BorderStyle.solid,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide:
                          BorderSide(color: alamutPrimaryColor, width: 1.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _search() {
    FocusScope.of(context).unfocus();
    widget.searchController.isSearchResult.value = true;
    widget.categoryFilterController.selectedTapIndex.value = 0;
    widget.searchController.keyword.value = widget.textEditingController.text;
    widget.pagingController.refresh();
    widget.searchController.keyword.value = widget.textEditingController.text;
  }
}
