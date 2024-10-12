import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:martify/Data/address_repository/address_repo.dart';
import 'package:martify/Model/address_model.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/internet%20Exceptions/connectivity_services.dart';
import 'package:martify/utils/popups/full_screen_loader.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressState()) {
    on<AllUserAddresses>(_allUserAddresses);
    on<ChangeCountry>(_changeCountry);
    on<AddAddress>(_addAddress);
    on<SelectedAddress>(_selectedAddress);
    on<SelectDeleteAddress>(_selectDeleteAddress);
    on<DeleteAddress>(_deleteAddress);
    on<RemoveHold>(_removeHold);
  }

  void _selectedAddress(
      SelectedAddress event, Emitter<AddressState> emit) async {
    try {
      if (state.removeHold == true) {
        emit(state.copyWith(removeHold: false));
        emit(state.copyWith(selectedDeleteAddress: ""));
        return;
      }
      //------------Step1 Start Loading-------------
      FullScreenLoader.show(event.context, lottieAsset: MImages.docerAnimation);
      //check that new selected address is alredy slected or not
      if (state.selectedAddress.id == event.newSelectedaddres.id) {
        FullScreenLoader.hide(event.context);
        SnackbarService.showSimpleMessage(
            context: event.context, message: "Address Already Selected");
        return;
      }
      //Clear the previous selected address
      if (state.selectedAddress.id.isNotEmpty) {
        await AddressRepo.updateSelectedField(state.selectedAddress.id, false);
      }
      //assign the new selected address
      event.newSelectedaddres.selectedAddress = true;
      emit(state.copyWith(selectedAddress: event.newSelectedaddres));
      if (state.selectedAddress.id.isNotEmpty) {
        await AddressRepo.updateSelectedField(event.newSelectedaddres.id, true);
      }
      FullScreenLoader.hide(event.context);
      SnackbarService.showSucccess(
          context: event.context, message: "Address Selected Successfully");
    } catch (e) {
      FullScreenLoader.hide(event.context);
      if (kDebugMode) {
        print("Error while fetch user addresses, Error: $e");
      }
    }
  }

  void _allUserAddresses(
      AllUserAddresses event, Emitter<AddressState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      // Fetch user addresses
      final addresses = await AddressRepo.fetchUserAddressess();
      if (addresses.isEmpty) {
        emit(state.copyWith(nodatafound: true));
      } else {
        emit(state.copyWith(nodatafound: false));
      }

      // Find the address where selectedValue is true
      final selectedAddress = addresses.firstWhere(
        (address) => address.selectedAddress == true,
        orElse: () => AddressModel.empty(),
      );

      // Only add selected address to the top if it's valid (not empty)
      if (!selectedAddress.isEmpty()) {
        // Assuming you implement this method
        addresses.removeWhere((address) => address == selectedAddress);
        addresses.insert(0, selectedAddress); // Add selected address to the top
      }

      // Emit state with selected address and all addresses
      emit(state.copyWith(
        selectedAddress: selectedAddress,
        allAddress: addresses,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      if (kDebugMode) {
        print("Error while fetch user addresses, Error: $e");
      }
    }
  }

  void _changeCountry(ChangeCountry event, Emitter<AddressState> emit) {
    emit(state.copyWith(country: event.country));
  }

  void _addAddress(AddAddress event, Emitter<AddressState> emit) async {
    try {
      //------------Step1 Start Loading-------------
      FullScreenLoader.show(event.context, lottieAsset: MImages.docerAnimation);

      //Step2 ------Check Internet Connectivity---------
      ConnectivityService connectivityService =
          ConnectivityService(event.context);
      final bool isConnected = await connectivityService.checkConnectivity();
      if (!isConnected) {
        FullScreenLoader.hide(event.context);
        SnackbarService.showError(
            context: event.context, message: "No Internet Connection");
        return;
      }

      // Step3 ----Form Validation-------
      if (!state.addressFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      }

      // Step4-----Privacy Policy Check-------
      if (state.country.isEmpty) {
        FullScreenLoader.hide(event.context);
        SnackbarService.showWarning(
            context: event.context, message: "Please Select Country");
        return;
      }

      // Create json
      final Map<String, dynamic> addressJson = {
        'name': state.fullNameController.text.trim(),
        'phoneNumber': state.phoneNumberController.text.trim(),
        'street': state.streetController.text.trim(),
        'city': state.cityController.text.trim(),
        'state': state.stateController.text.trim(),
        'postalCode': state.postalCodeController.text.trim(),
        'country': state.country,
        'dateTime': DateFormat('d-M-yyyy').format(DateTime.now()),
        'selectedAddress': false,
      };

      // Send json to Firestore to add address
      final newlyAddedAddress = await AddressRepo.addAddress(addressJson);

      // Now add new address in allAddress model
      // Create an updated list of addresses
      final updatedAddresses = List<AddressModel>.from(state.allAddress)
        ..add(newlyAddedAddress);

      // Emit the updated state with the new address list
      emit(state.copyWith(allAddress: updatedAddresses));
      emit(state.copyWith(nodatafound: false));
      add(AllUserAddresses());

      // Clear text fields
      state.fullNameController.clear();
      state.phoneNumberController.clear();
      state.streetController.clear();
      state.cityController.clear();
      state.stateController.clear();
      state.postalCodeController.clear();

      // Clear country in state
      emit(state.copyWith(country: ''));

      // Stop Loading
      FullScreenLoader.hide(event.context);

      // Move back to previous screen
      Navigator.pop(event.context);

      SnackbarService.showSucccess(
          context: event.context, message: "Address Added Successfully");
    } catch (e) {
      FullScreenLoader.hide(event.context);
      if (kDebugMode) {
        print("Error while adding address, Error: $e");
      }
      SnackbarService.showError(
          context: event.context, message: "Something Went Wrong!");
    }
  }

  void _selectDeleteAddress(
      SelectDeleteAddress event, Emitter<AddressState> emit) {
    if (state.removeHold == false) {
      emit(state.copyWith(removeHold: true));
      emit(state.copyWith(selectedDeleteAddress: event.selectedAddress.id));
    } else {
      emit(state.copyWith(removeHold: false));
      emit(state.copyWith(selectedDeleteAddress: ""));
    }
  }

  void _removeHold(RemoveHold event, Emitter<AddressState> emit) {
    emit(state.copyWith(removeHold: false));
    emit(state.copyWith(selectedDeleteAddress: ""));
  }

  void _deleteAddress(DeleteAddress event, Emitter<AddressState> emit) async {
    try {
      Navigator.of(event.context).pop();
      //------------Step1 Start Loading-------------
      FullScreenLoader.show(event.context, lottieAsset: MImages.docerAnimation);

      //Step2 ------Check Internet Connectivity---------
      ConnectivityService connectivityService =
          ConnectivityService(event.context);
      final bool isConnected = await connectivityService.checkConnectivity();
      if (!isConnected) {
        FullScreenLoader.hide(event.context);
        SnackbarService.showError(
            context: event.context, message: "No Internet Connection");
        return;
      }
      await AddressRepo.deleteSelectedField(state.selectedDeleteAddress);
      add(AllUserAddresses());
      add(RemoveHold());
      FullScreenLoader.hide(event.context);
      SnackbarService.showSucccess(
          context: event.context,
          message: "Selected Address Deleted Successfully");
    } catch (e) {
      FullScreenLoader.hide(event.context);
      if (kDebugMode) {
        print("Error while deleting address, Error: $e");
      }
      SnackbarService.showError(
          context: event.context, message: "Something Went Wrong!");
    }
  }
}
