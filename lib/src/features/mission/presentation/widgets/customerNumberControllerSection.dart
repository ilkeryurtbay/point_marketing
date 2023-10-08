import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class customerNumberControllerSection extends StatelessWidget {
  const customerNumberControllerSection({
    super.key,
    required TextEditingController customerNumberController,
  }) : _customerNumberController = customerNumberController;

  final TextEditingController _customerNumberController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Text("Kaç müşteri ile görüşüldü:")),
        Expanded(
          child: TextField(
            controller: _customerNumberController,
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