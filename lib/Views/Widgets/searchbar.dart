import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlamutSearchBar extends StatefulWidget {
  const AlamutSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AlamutSearchBar> createState() => _AlamutSearchBarState();
}

class _AlamutSearchBarState extends State<AlamutSearchBar> {
  TextEditingController _textEditingController = TextEditingController();
  bool isTyping = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
          prefixIcon: !isTyping
              ? Opacity(
                  opacity: 0.5,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2.3),
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
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Color.fromRGBO(112, 112, 112, 0.2),
              width: 2.0,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              CupertinoIcons.search,
              size: 40,
              color: Color.fromRGBO(112, 112, 112, 0.5),
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _textEditingController.clear();
            },
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Color.fromRGBO(112, 112, 112, 0.2),
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
