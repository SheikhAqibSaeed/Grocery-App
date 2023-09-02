import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../screens/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
            text: '30\Rs.',
            color: Colors.green,
            textSize: 20,
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            '34\Rs.',
            style: TextStyle(
                fontSize: 16,
                color: color,
                decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
