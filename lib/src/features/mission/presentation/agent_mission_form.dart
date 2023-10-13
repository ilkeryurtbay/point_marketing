import 'package:flutter/material.dart';
import 'package:point_marketing/core/constants/app_padding.dart';
import 'package:point_marketing/core/constants/app_space.dart';
import 'package:point_marketing/core/constants/app_string.dart';
import 'package:point_marketing/core/util/build_context_extension.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/imagePickerSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/market_information_section.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/interestSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/notesSection.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/number_control_section.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/time_section.dart';

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
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _productNumberController =
      TextEditingController();
  final TextEditingController _customerNumberController =
      TextEditingController();
  final TextEditingController _marketOfficialNotesController =
      TextEditingController();
  final TextEditingController _agentNotesController = TextEditingController();
  final TextEditingController _marketerNotesController =
      TextEditingController();

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
                  MarketInformationSection(
                    labelText: AppString.mOCText,
                    controller: _marketOfficialController,
                  ),
                  AppSpace.vertical.space10,
                  MarketInformationSection(
                      labelText: AppString.mACText,
                      controller: _marketAddressController),
                  AppSpace.vertical.space20,
                  const Text("İsim Soyisim : 'isimSoyisim' "),
                  AppSpace.vertical.space20,
                  const Text("Tanıtılan ürün : 'ürünİsmi' "),
                  AppSpace.vertical.space20,
                  TimeSection(
                    labelText: AppString.startTime,
                    controller: _startTimeController,
                  ),
                  AppSpace.vertical.space10,
                  TimeSection(
                    labelText: AppString.endtTime,
                    controller: _endTimeController,
                  ),
                  AppSpace.vertical.space10,
                  NumberControlSection(
                    controller: _productNumberController,
                    labelText: AppString.productNumberText,
                  ),
                  AppSpace.vertical.space10,
                  NumberControlSection(
                    controller: _customerNumberController,
                    labelText: AppString.customerNumberText,
                  ),
                  AppSpace.vertical.space10,
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(AppString.marketerInterest),
                      ),
                      InterestSection(
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
                        child: Text(AppString.consumerInterest),
                      ),
                      InterestSection(
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
                        child: Text(AppString.marketStandLocation),
                      ),
                      InterestSection(
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
                  NotesSection(
                    controller: _marketerNotesController,
                    onChanged: (String value) {},
                    labelText: AppString.marketerNotes,
                  ),
                  AppSpace.vertical.space10,
                  NotesSection(
                    controller: _marketerNotesController,
                    onChanged: (String value) {},
                    labelText: AppString.agentNotes,
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
    _startTimeController.dispose();
    _endTimeController.dispose();
    _productNumberController.dispose();
    _customerNumberController.dispose();
    _marketOfficialNotesController.dispose();
    _agentNotesController.dispose();
    _agentNotesController.dispose();
    _marketAddressController.dispose();
    super.dispose();
  }
}
