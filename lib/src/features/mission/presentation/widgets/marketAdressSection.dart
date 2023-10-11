import 'package:flutter/material.dart';

class marketAdressSection extends StatelessWidget {
  const marketAdressSection({
    super.key,
    required TextEditingController marketAdressController,
  }) : _marketAdressController = marketAdressController;

  final TextEditingController _marketAdressController;

  @override
  Widget build(BuildContext context) {
    return Row(
     children: [
       const Expanded(child: Text("Market Adresi: ")),
       SizedBox(
         width: MediaQuery.of(context).size.width * 0.6,
         child: TextField(
           controller: _marketAdressController,
           maxLines: 2,
           onChanged: (value) {
             // Girilen değeri kullanmak için burada işlem yapabilirsiniz.
             print('Girilen saat: $value');
           }
           
         ),
       ),
     ],
                  );
  }
}