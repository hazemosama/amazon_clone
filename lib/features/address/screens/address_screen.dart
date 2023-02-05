import 'package:amazon_clone/common/widgets/custom_appbar.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../constants/app_colors.dart';
import '../../../providers/user_provider.dart';

enum AddressType {
  home,
  office,
}

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';

  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressServices addressServices = AddressServices();

  AddressType _addressType = AddressType.home;

  List<String> countries = [
    "Country",
    "Egypt",
    "Cairo",
  ];

  String selectedCountry = "Country";
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _governorateController = TextEditingController();
  final TextEditingController _nearestLandMarkController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _cityController.dispose();
    _governorateController.dispose();
    _nearestLandMarkController.dispose();
  }

  void _saveAddress() {
    addressServices.saveAddress(context: context, address: _addressController.text);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    _addressController.text = address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(67),
        child: CustomAppBar(
          backButton: false,
          searchBar: false,
          trailing: GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(right: 12, top: 28),
              child: Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.isEmpty ? 'Add address' : 'Edit address',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _addressController,
                  hintText: address.isEmpty ? 'Address' : address,
                  radius: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: CustomButton(
                    onPressed: _saveAddress,
                    text: 'Confirm',
                    color: const Color(0xffffd814),
                    radius: 8,
                    height: 52,
                    textSize: 17,
                  ),
                ),
                const Divider(color: Colors.black26, thickness: 1.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: const [
                      Icon(Icons.warning, color: Colors.amber),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 300,
                        child: Text(
                          'adding a new address feature is not working right now,'
                          ' you can add/edit your address in one text from the upper field.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.black26, thickness: 1.0),
                const Text(
                  'Add a new address',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xfff0f2f2),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: const Color(0xffc9cdcd),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x41000000),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                        BoxShadow(
                          color: Color(0xfff0f2f2),
                          offset: Offset(-4, 0),
                        ),
                        BoxShadow(
                          color: Color(0xfff0f2f2),
                          offset: Offset(4, 0),
                        ),
                      ]),
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    value: selectedCountry,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 30,
                    iconEnabledColor: Colors.black,
                    style: const TextStyle(fontSize: 17.5, color: Colors.black),
                    items: countries
                        .map(
                          (String item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountry = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 9),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Full name',
                  radius: 6,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 52,
                        width: 135,
                        decoration: BoxDecoration(
                            color: const Color(0xfff0f2f2),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: const Color(0xffc9cdcd),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x41000000),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                              BoxShadow(
                                color: Color(0xfff0f2f2),
                                offset: Offset(-2, 0),
                              ),
                              BoxShadow(
                                color: Color(0xfff0f2f2),
                                offset: Offset(2, 0),
                              ),
                            ]),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 18,
                            ).copyWith(right: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          hint: Row(
                            children: [
                              Flag.fromCode(
                                FlagsCode.EG,
                                height: 18,
                                width: 28,
                              ),
                              const Text(
                                '+20',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          iconEnabledColor: Colors.black,
                          style: const TextStyle(
                              fontSize: 17.5, color: Colors.black),
                          items: [
                            DropdownMenuItem(
                              value: '',
                              child: Row(
                                children: [
                                  Flag.fromCode(
                                    FlagsCode.EG,
                                    height: 30,
                                    width: 30,
                                  ),
                                  const Text('+20'),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountry = newValue!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 225,
                        child: CustomTextField(
                          controller: _phoneController,
                          hintText: 'e.g. 1XXXXXXXXX',
                          radius: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 11, bottom: 5),
                  child: Text(
                    'May be used to assist delivery',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                const Divider(color: Colors.black38),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.location_on_sharp,
                        color: AppColors.secondaryColor,
                      ),
                      SizedBox(width: 11),
                      Text(
                        'Add location on map',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textTeal,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.black38),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: _streetController,
                  hintText: 'Street name',
                  radius: 3.5,
                ),
                const SizedBox(height: 7),
                CustomTextField(
                  controller: _buildingController,
                  hintText: 'Building name/no',
                  radius: 3.5,
                ),
                const SizedBox(height: 7.5),
                CustomTextField(
                  controller: _floorController,
                  hintText: 'Floor, apartment, or villa no.',
                  radius: 3.5,
                ),
                const SizedBox(height: 7.5),
                CustomTextField(
                  controller: _cityController,
                  hintText: 'City/Area (El Nozha & New Cairo City)',
                  radius: 3.5,
                ),
                const SizedBox(height: 7.5),
                CustomTextField(
                  controller: _streetController,
                  hintText: 'District',
                  radius: 3.5,
                  enabled: false,
                ),
                const SizedBox(height: 7.5),
                CustomTextField(
                  controller: _governorateController,
                  hintText: 'Governorate',
                  radius: 3.5,
                  enabled: false,
                ),
                const SizedBox(height: 7.5),
                CustomTextField(
                  controller: _nearestLandMarkController,
                  hintText: 'Nearest landmark',
                  radius: 3.5,
                ),
                const SizedBox(height: 13),
                const Text(
                  'Add delivery instructions',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Address type',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Radio(
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                      activeColor: AppColors.secondaryColor,
                      value: AddressType.home,
                      groupValue: _addressType,
                      onChanged: (AddressType? val) {
                        setState(() {
                          _addressType = val!;
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Home (7am-9pm, all days',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Radio(
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                      activeColor: AppColors.secondaryColor,
                      value: AddressType.office,
                      groupValue: _addressType,
                      onChanged: (AddressType? val) {
                        setState(() {
                          _addressType = val!;
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Office (9am-6pm, Weekdays',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 32),
                  child: CustomButton(
                    onPressed: () {},
                    text: 'Add address',
                    color: const Color(0xffffd814),
                    radius: 8,
                    height: 52,
                    textSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
