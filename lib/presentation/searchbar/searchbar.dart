import 'package:alamuti/presentation/common/strings/app_asset.dart';
import 'package:alamuti/presentation/common/strings/app_string.dart';
import 'package:alamuti/presentation/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSearchTextField extends StatefulWidget {
  final TextEditingController textEditingController;

  HomeSearchTextField({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  _HomeSearchTextFieldState createState() => _HomeSearchTextFieldState();
}

class _HomeSearchTextFieldState extends State<HomeSearchTextField> {
  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(8);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: PhysicalModel(
        borderRadius: radius,
        color: Colors.white,
        shadowColor: Colors.black,
        child: TextField(
          controller: widget.textEditingController,
          style: TextStyle(
              backgroundColor: Colors.white,
              fontSize: 15,
              fontFamily: persianNumber,
              fontWeight: FontWeight.w300),
          onSubmitted: (value) {
            if (widget.textEditingController.text.isEmpty) {
            } else {
              _search();
            }
          },
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: AppString.searchHintText,
            hintStyle: TextStyle(
                backgroundColor: Colors.transparent,
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontSize: 13),
            label: SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'جستجو در',
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  Image.asset(
                    AppAsset.appLogo,
                    width: 50,
                  ),
                ],
              ),
            ),
            prefixIcon: IconButton(
              icon: Icon(
                CupertinoIcons.search,
                size: 30,
                color: Color.fromRGBO(8, 212, 76, 0.5),
              ),
              onPressed: () {
                if (widget.textEditingController.text.isEmpty) {
                } else {
                  _search();
                }
              },
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.6),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(
                color: Colors.red,
                width: 0.6,
                style: BorderStyle.solid,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: radius,
                borderSide: BorderSide(
                    color: Color.fromRGBO(112, 112, 112, 0.6), width: 1.5)),
          ),
        ),
      ),
    );
  }

  _search() {
    FocusScope.of(context).unfocus();
  }
}
