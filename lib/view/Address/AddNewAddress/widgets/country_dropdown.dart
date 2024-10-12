import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/Addresses/address_bloc.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class CountryDropdown extends StatelessWidget {
  CountryDropdown({super.key});
  final List<String> countryList = [
    "Australia",
    "Bahrain",
    "Brazil",
    "Canada",
    "China",
    "Egypt",
    "France",
    "Germany",
    "India",
    "Iran",
    "Iraq",
    "Italy",
    "Japan",
    "Jordan",
    "Kuwait",
    "Lebanon",
    "Mexico",
    "Oman",
    "Pakistan",
    "Palestine",
    "Qatar",
    "Russia",
    "Saudi Arabia",
    "South Africa",
    "Syria",
    "Turkey",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Yemen"
  ];

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return DropdownButtonFormField<String>(
      dropdownColor: dark ? MAppColors.dark : MAppColors.white,
      hint: RichText(
        text: TextSpan(
          text: "Select Country",
          style: Theme.of(context).textTheme.bodyLarge,
          children: const [
            TextSpan(
              text: ' *', // Asterisk
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      decoration: const InputDecoration(
        prefixIcon: Icon(Iconsax.global),
        labelText: "Country",
      ),
      items: countryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
                color: dark ? MAppColors.darkModeWhite : MAppColors.black),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        context.read<AddressBloc>().add(ChangeCountry(country: newValue ?? ""));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a country';
        }
        return null;
      },
      isExpanded: true,
      menuMaxHeight: 300,
    );
  }
}
