import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/Addresses/address_bloc.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/validators/validators.dart';
import 'package:martify/view/Address/AddNewAddress/widgets/country_dropdown.dart';

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Add New Address",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Form(
            key: context.read<AddressBloc>().state.addressFormKey,
            child: Column(
              children: [
                // Full Name
                BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    return TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: state.fullNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.user),
                        label: RichText(
                          text: TextSpan(
                            text: "Full Name",
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: const [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                      validator: (value) =>
                          MValidators.validateField(value, "Full Name"),
                    );
                  },
                ),
                const SizedBox(height: MSizes.spaceBtwItems),

                // Phone Number
                BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    return TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: state.phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.call),
                        label: RichText(
                          text: TextSpan(
                            text: "Phone Number",
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: const [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                      validator: (value) =>
                          MValidators.validatePhoneNumber(value),
                    );
                  },
                ),
                const SizedBox(height: MSizes.spaceBtwItems),

                // Street / Postal Code
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<AddressBloc, AddressState>(
                        builder: (context, state) {
                          return TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: state.streetController,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.building_31),
                              label: RichText(
                                text: TextSpan(
                                  text: "Street",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: const [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            validator: (value) =>
                                MValidators.validateField(value, "Street"),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: MSizes.spaceBtwItems),
                    Expanded(
                      child: BlocBuilder<AddressBloc, AddressState>(
                        builder: (context, state) {
                          return TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: state.postalCodeController,
                            keyboardType: TextInputType.streetAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.code),
                              labelText: "Postal Code",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MSizes.spaceBtwItems),

                // City / State
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<AddressBloc, AddressState>(
                        builder: (context, state) {
                          return TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: state.cityController,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.buliding),
                              label: RichText(
                                text: TextSpan(
                                  text: "City",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: const [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            validator: (value) =>
                                MValidators.validateField(value, "City"),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: MSizes.spaceBtwItems),
                    Expanded(
                      child: BlocBuilder<AddressBloc, AddressState>(
                        builder: (context, state) {
                          return TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: state.stateController,
                            keyboardType: TextInputType.streetAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.activity),
                              labelText: "State",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MSizes.spaceBtwItems),

                // Country Names DropDown
                CountryDropdown(),

                const SizedBox(height: MSizes.spacerBtwSections),

                // Save Button
                BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<AddressBloc>()
                              .add(AddAddress(context: context));
                        },
                        child: const Text("Save"),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
