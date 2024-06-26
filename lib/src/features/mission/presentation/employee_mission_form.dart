import 'package:flutter/material.dart';
import 'package:point_marketing/core/constants/app_padding.dart';
import 'package:point_marketing/core/constants/app_space.dart';
import 'package:point_marketing/src/common_widgets/page_scroll_bar.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/employee_notes_section.dart';
import 'package:point_marketing/src/features/mission/presentation/widgets/marketerNotesSection.dart';

class EmployeeMissionForm extends StatefulWidget {
  const EmployeeMissionForm({super.key});

  @override
  State<EmployeeMissionForm> createState() => _EmployeeMissionFormState();
}

class _EmployeeMissionFormState extends State<EmployeeMissionForm> {
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
  final TextEditingController _employeeNotesController =
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
      body: PageScrollBar(
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
                  // marketOfficalSection(
                  //     marketOfficalController: _marketOfficialController),
                  // AppSpace.vertical.space10,
                  // marketAdressSection(
                  //     marketAdressController: _marketAddressController),
                  // AppSpace.vertical.space20,
                  // const Text("İsim Soyisim : 'isimSoyisim' "),
                  // AppSpace.vertical.space20,
                  // const Text("Tanıtılan ürün : 'ürünİsmi' "),
                  // AppSpace.vertical.space20,
                  // startTimeSection(startTimeController: _startTimeController),
                  // AppSpace.vertical.space10,
                  // endTimeSetion(finishTimeController: _finishTimeController),
                  // AppSpace.vertical.space10,
                  // productNumberControlSection(
                  //     productNumberController: _productNumberController),
                  // AppSpace.vertical.space10,
                  // customerNumberControllerSection(
                  //     customerNumberController: _customerNumberController),
                  AppSpace.vertical.space10,
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text("Marketçi ilgisi:"),
                      ),
                      // marketInterestSection(
                      //   selectedOption: _selectedOption,
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       _selectedOption = newValue!;
                      //     });
                      //   },
                      //),
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
                      // customerAppreciationSaction(
                      //   selectedOption: _selectedOption2,
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       _selectedOption2 = newValue!;
                      //     });
                      //   },
                      //),
                      Expanded(
                        flex: 1,
                        child: AppSpace.horizontal.space10,
                      ),
                    ],
                  ),
                  AppSpace.vertical.space10,
                  // Row(
                  //   children: [
                  //     const Expanded(
                  //       flex: 2,
                  //       child: Text("Market stand yeri:"),
                  //     ),
                  //     marketStandLocationSection(
                  //       selectedOption: _selectedOption3,
                  //       onChanged: (String? newValue) {
                  //         setState(() {
                  //           _selectedOption3 = newValue!;
                  //         });
                  //       },
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: AppSpace.horizontal.space10,
                  //     ),
                  //   ],
                  // ),
                  AppSpace.vertical.space10,
                  Row(
                    children: [
                      const Expanded(child: Text("Marketçi notları: ")),
                      MarketerNotesSection(
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
                      EmployeeNotesSection(
                        controller: _employeeNotesController,
                        onChanged: (value) {
                          // Girilen değeri kullanmak için burada işlem yapabilirsiniz.
                          print('Eleman notları: $value');
                        },
                      ),
                    ],
                  ),
                  AppSpace.vertical.space10,
                  // ImagePickerPage(),
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
    _employeeNotesController.dispose();
    super.dispose();
  }
}
