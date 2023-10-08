import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class marketOfficalSection extends StatelessWidget {
  const marketOfficalSection({
    super.key,
    required TextEditingController marketOfficalController,
  }) : _marketOfficalController = marketOfficalController;

  final TextEditingController _marketOfficalController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child:  Text("Market Yetkilisi: ")),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextField(
            controller: _marketOfficalController,
            maxLines: 1,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]+')),
              // Yukarıdaki RegExp, yalnızca harf ve boşluk karakterlerini kabul eder.
            ],
            onChanged: (value) {
              // Girilen değeri kullanmak için burada işlem yapabilirsiniz.
              print('Girilen saat: $value');
            },
          ),
        ),
      ],
    );
  }
}