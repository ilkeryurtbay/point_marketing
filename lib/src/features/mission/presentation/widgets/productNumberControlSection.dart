import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class productNumberControlSection extends StatelessWidget {
  const productNumberControlSection({
    super.key,
    required TextEditingController productNumberController,
  }) : _productNumberController = productNumberController;

  final TextEditingController _productNumberController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: Text("İkram edilen bardak/paket sayısı:")),
        Expanded(
          child: TextField(
            controller: _productNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: const InputDecoration(
              hintText: 'Sayıyı buraya girin',
            ),
            onChanged: (value) {
              // Girilen sayıyı kullanmak için burada işlem yapabilirsiniz.
              print('Girilen sayı: $value');
            },
          ),
        )
      ],
    );
  }
}