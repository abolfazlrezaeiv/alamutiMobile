import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        child: SizedBox(
          height: 47,
          child: TextButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(10, 210, 71, 0.5),
            ),
            onPressed: () {},
            child: Text(
              'ثبت',
              style: TextStyle(color: Colors.grey[700], fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
