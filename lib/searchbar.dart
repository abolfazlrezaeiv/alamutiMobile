import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlamutSearchBar extends StatefulWidget {
  const AlamutSearchBar({
    Key? key,
    required this.mq,
  }) : super(key: key);
  final double mq;

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
      width: MediaQuery.of(context).size.width / 1.1,
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
              ? Padding(
                  padding: EdgeInsets.only(left: widget.mq),
                  child: Opacity(
                    opacity: 0.5,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/logo/logo.png',
                          width: 70,
                        ),
                        Text(
                          'جستجو در',
                          style: TextStyle(color: Colors.black),
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
