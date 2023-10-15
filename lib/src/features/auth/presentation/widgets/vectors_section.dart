import 'dart:math';

import 'package:flutter/material.dart';

class VectorsSection extends StatelessWidget {
  const VectorsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.7,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.66,
            child: Transform.rotate(
              angle: 8.405975552353674 * (pi / 180),
              child: Image.asset("assets/vector1.png",),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * -0.1,
            child: Image.asset("assets/vector2.png"),
          ),
        ],
      ),
    );
  }
}