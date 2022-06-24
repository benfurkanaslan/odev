import 'package:flutter/material.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;

                });
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey),),
                child: selected ? Icon(
                  Icons.check,
                  size: 17,
                  color: Colors.green,
                ) :null,
              ),
            ),
            SizedBox(width: 12,),
            Text('Agree to terms and conditions.')
          ],
        ),
      ],
    );
  }
}
