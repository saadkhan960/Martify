part of 'address_bloc.dart';

class AddressState extends Equatable {
  final List<AddressModel> allAddress;
  final AddressModel selectedAddress;
  final bool isLoading;
  final bool formSubmitLoading;
  final GlobalKey<FormState> addressFormKey;
  final TextEditingController fullNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController streetController;
  final TextEditingController postalCodeController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final String country;
  final bool removeHold;
  final bool nodatafound;
  final String selectedDeleteAddress;

  AddressState({
    this.selectedDeleteAddress = "",
    this.nodatafound = false,
    this.removeHold = false,
    this.isLoading = false,
    this.formSubmitLoading = false,
    this.allAddress = const <AddressModel>[],
    AddressModel? selectedAddress,
    GlobalKey<FormState>? addressFormKey,
    TextEditingController? fullNameController,
    TextEditingController? phoneNumberController,
    TextEditingController? streetController,
    TextEditingController? postalCodeController,
    TextEditingController? cityController,
    TextEditingController? stateController,
    this.country = '',
  })  : selectedAddress = selectedAddress ?? AddressModel.empty(),
        addressFormKey = addressFormKey ?? GlobalKey<FormState>(),
        fullNameController = fullNameController ?? TextEditingController(),
        phoneNumberController =
            phoneNumberController ?? TextEditingController(),
        streetController = streetController ?? TextEditingController(),
        postalCodeController = postalCodeController ?? TextEditingController(),
        cityController = cityController ?? TextEditingController(),
        stateController = stateController ?? TextEditingController();

  AddressState copyWith({
    String? selectedDeleteAddress,
    bool? nodatafound,
    bool? removeHold,
    bool? isLoading,
    bool? formSubmitLoading,
    List<AddressModel>? allAddress,
    AddressModel? selectedAddress,
    GlobalKey<FormState>? addressFormKey,
    TextEditingController? fullNameController,
    TextEditingController? phoneNumberController,
    TextEditingController? streetController,
    TextEditingController? postalCodeController,
    TextEditingController? cityController,
    TextEditingController? stateController,
    String? country,
  }) {
    return AddressState(
      selectedDeleteAddress:
          selectedDeleteAddress ?? this.selectedDeleteAddress,
      nodatafound: nodatafound ?? this.nodatafound,
      removeHold: removeHold ?? this.removeHold,
      formSubmitLoading: formSubmitLoading ?? this.formSubmitLoading,
      isLoading: isLoading ?? this.isLoading,
      allAddress: allAddress ?? this.allAddress,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      addressFormKey: addressFormKey ?? this.addressFormKey,
      fullNameController: fullNameController ?? this.fullNameController,
      phoneNumberController:
          phoneNumberController ?? this.phoneNumberController,
      streetController: streetController ?? this.streetController,
      postalCodeController: postalCodeController ?? this.postalCodeController,
      cityController: cityController ?? this.cityController,
      stateController: stateController ?? this.stateController,
      country: country ?? this.country,
    );
  }

  @override
  List<Object> get props => [
        selectedDeleteAddress,
        nodatafound,
        removeHold,
        isLoading,
        allAddress,
        selectedAddress,
        addressFormKey,
        fullNameController,
        phoneNumberController,
        streetController,
        postalCodeController,
        cityController,
        stateController,
        country,
        formSubmitLoading,
      ];
}
