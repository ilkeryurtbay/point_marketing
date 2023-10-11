import 'package:flutter/material.dart';
import 'package:point_marketing/core/constants/app_padding.dart';
import 'package:point_marketing/core/constants/app_space.dart';
import 'package:point_marketing/core/util/build_context_extension.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/agentNotesSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/customerAppreciationSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/customerNumberControllerSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/endTimeSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/imagePickerSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/marketAdressSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/marketOfficalSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/marketStandLocationSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/marketerInterestSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/marketerNotesSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/productNumberControlSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/startTimeSection.dart';

class AgentMissionForm extends StatefulWidget {
  const AgentMissionForm({super.key});

  @override
  State<AgentMissionForm> createState() => _AgentMissionFormState();
}

class _AgentMissionFormState extends State<AgentMissionForm> {
  final TextEditingController _marketOfficialController =
      TextEditingController();
  final TextEditingController _marketAddressController =
      TextEditingController();
  final TextEditingController _finishTimeController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _productNumberController =
      TextEditingController();
  final TextEditingController _customerNumberController =
      TextEditingController();
  final TextEditingController _marketOfficialNotesController =
      TextEditingController();
  final TextEditingController _agentNotesController = TextEditingController();

  String? _selectedOption;
  String? _selectedOption2;
  String? _selectedOption3;

  double scrollBarRadius = 10;
  double scrollbarThickness = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Görev Formu"),
      ),
      body: RawScrollbar(
        thumbVisibility: true,
        padding: AppPadding.onlyRight4,
        thumbColor: context.mainThemeColor,
        thickness: scrollbarThickness,
        radius: Radius.circular(scrollBarRadius),
        interactive: true,
        child: Padding(
          padding: AppPadding.pagePadding,
          child: SingleChildScrollView(
            child: Padding(
              padding: AppPadding.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Market Adı : 'marketAdı' "),
                      AppSpace.horizontal.space40,
                      const Text("Tarih : 'tarih' "),
                    ],
                  ),
                  AppSpace.vertical.space20,
                  marketOfficalSection(
                      marketOfficalController: _marketOfficialController),
                  AppSpace.vertical.space10,
                  marketAdressSection(
                      marketAdressController: _marketAddressController),
                  AppSpace.vertical.space20,
                  const Text("İsim Soyisim : 'isimSoyisim' "),
                  AppSpace.vertical.space20,
                  const Text("Tanıtılan ürün : 'ürünİsmi' "),
                  AppSpace.vertical.space20,
                  startTimeSection(startTimeController: _startTimeController),
                  AppSpace.vertical.space10,
                  endTimeSetion(finishTimeController: _finishTimeController),
                  AppSpace.vertical.space10,
                  productNumberControlSection(
                      productNumberController: _productNumberController),
                  AppSpace.vertical.space10,
                  customerNumberControllerSection(
                      customerNumberController: _customerNumberController),
                  AppSpace.vertical.space10,
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text("Marketçi ilgisi:"),
                      ),
                      marketInterestSection(
                        selectedOption: _selectedOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue!;
                          });
                        },
                      ),
                      Expanded(
                        flex: 1,
                        child: AppSpace.horizontal.space10,
                      ),
                    ],
                  ),
                  AppSpace.vertical.space10,
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text("Müşteri beğenisi:"),
                      ),
                      customerAppreciationSaction(
                        selectedOption: _selectedOption2,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption2 = newValue!;
                          });
                        },
                      ),
                      Expanded(
                        flex: 1,
                        child: AppSpace.horizontal.space10,
                      ),
                    ],
                  ),
                  AppSpace.vertical.space10,
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text("Market stand yeri:"),
                      ),
                      marketStandLocationSection(
                        selectedOption: _selectedOption3,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption3 = newValue!;
                          });
                        },
                      ),
                      Expanded(
                        flex: 1,
                        child: AppSpace.horizontal.space10,
                      ),
                    ],
                  ),
                  AppSpace.vertical.space10,
                  Row(
                    children: [
                      const Expanded(child: Text("Marketçi notları: ")),
                      marketerNotesSection(
                        controller: _marketOfficialNotesController,
                        onChanged: (value) {
                          // Girilen değeri kullanmak için burada işlem yapabilirsiniz.
                          print('Marketçi notları: $value');
                        },
                      ),
                    ],
                  ),
                  AppSpace.vertical.space10,
                  Row(
                    children: [
                      const Expanded(child: Text("Eleman notları: ")),
                      agentNotesSection(
                        controller: _agentNotesController,
                        onChanged: (value) {
                          // Girilen değeri kullanmak için burada işlem yapabilirsiniz.
                          print('Eleman notları: $value');
                        },
                      ),
                    ],
                  ),
                  AppSpace.vertical.space10,
                  ImagePickerPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _marketOfficialController.dispose();
    _marketAddressController.dispose();
    _finishTimeController.dispose();
    _startTimeController.dispose();
    _productNumberController.dispose();
    _customerNumberController.dispose();
    _marketOfficialNotesController.dispose();
    _agentNotesController.dispose();
    super.dispose();
  }
}
