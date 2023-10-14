import 'package:flutter/material.dart';
import 'package:point_marketing/core/constants/app_padding.dart';
import 'package:point_marketing/core/constants/app_space.dart';
import 'package:point_marketing/core/constants/app_string.dart';
import 'package:point_marketing/core/util/build_context_extension.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/image_picker_section.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/market_information_section.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/interest_section.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/missions_sucsess_buton.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/notes_section.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/number_control_section.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/passive_market_information_section.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/time_section.dart';

class employeMissionForm extends StatefulWidget {
  const employeMissionForm({Key? key});

  @override
  State<employeMissionForm> createState() => _employeMissionFormState();
}

class _employeMissionFormState extends State<employeMissionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
  final TextEditingController _employeNotesController = TextEditingController();
  final TextEditingController _marketerNotesController =
      TextEditingController();
  final TextEditingController _marketOfficialNameController =
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PassiveMarketInformationSection(
                      text: AppString.date,
                    ),
                    AppSpace.vertical.space20,
                    const Text(
                      AppString.marketInformation,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    AppSpace.vertical.space20,
                    const PassiveMarketInformationSection(
                      text: AppString.mOCText,
                    ),
                    AppSpace.vertical.space10,
                    MarketInformationSection(
                      labelText: AppString.marketOfficalName,
                      controller: _marketOfficialNameController,
                    ),
                    AppSpace.vertical.space10,
                    const PassiveMarketInformationSection(
                      text: AppString.mACText,
                    ),
                    AppSpace.vertical.space20,
                    const Text(
                      AppString.employeInformation,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    AppSpace.vertical.space20,
                    const PassiveMarketInformationSection(
                      text: AppString.employeOfficalName,
                    ),
                    AppSpace.vertical.space10,
                    TimeSection(
                      controller: _startTimeController,
                      labelText: AppString.startTime,
                    ),
                    AppSpace.vertical.space10,
                    TimeSection(
                      controller: _endTimeController,
                      labelText: AppString.endTime,
                    ),
                    AppSpace.vertical.space20,
                    const Text(
                      AppString.promotionResult,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    AppSpace.vertical.space20,
                    NumberControlSection(
                      controller: _customerNumberController,
                      labelText: AppString.customerNumberText,
                    ),
                    AppSpace.vertical.space10,
                    Row(
                      children: [
                        Expanded(
                          child: TimeSection(
                            controller: _startTimeController,
                            labelText: AppString.startTime,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Expanded(
                          child: TimeSection(
                            controller: _endTimeController,
                            labelText: AppString.endTime,
                          ),
                        ),
                      ],
                    ),
                    AppSpace.vertical.space10,
                    NumberControlSection(
                      controller: _productNumberController,
                      labelText: AppString.productNumberText,
                    ),
                    AppSpace.vertical.space10,
                    InterestSection(
                      hintText: AppString.marketerInterest,
                      selectedOption: _selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption = newValue!;
                        });
                      },
                    ),
                    AppSpace.vertical.space10,
                    InterestSection(
                      selectedOption: _selectedOption2,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption2 = newValue!;
                        });
                      },
                      hintText: AppString.consumerInterest,
                    ),
                    AppSpace.vertical.space10,
                    InterestSection(
                      selectedOption: _selectedOption3,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption3 = newValue!;
                        });
                      },
                      hintText: AppString.marketStandLocation,
                    ),
                    AppSpace.vertical.space10,
                    NotesSection(
                      controller: _marketerNotesController,
                       labelText: AppString.marketerNotes,
                      
                    ),
                    AppSpace.vertical.space10,
                    NotesSection(
                      controller: _employeNotesController,
                      
                      labelText: AppString.employeNotes,
                    ),
                    AppSpace.vertical.space10,
                    ImagePickerPage(),
                    CustomSubmitButton(formKey: _formKey, ),
                  ],
                ),
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
    _employeNotesController.dispose();
    _marketAddressController.dispose();
    _marketOfficialNameController.dispose();
    super.dispose();
  }
}
