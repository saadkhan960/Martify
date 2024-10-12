import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  // Empty model constructor (singleton)
  static final AddressModel _emptyInstance = AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
    dateTime: null,
    selectedAddress: false,
  );

  factory AddressModel.empty() {
    return _emptyInstance;
  }

  // Method to check if this address is empty
  bool isEmpty() {
    return this == AddressModel.empty();
  }

  // Convert AddressModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateTime': dateTime,
      'selectedAddress': selectedAddress,
    };
  }

  // Create AddressModel from Map (when retrieving data from Firestore)
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      postalCode: map['postalCode'] ?? '',
      country: map['country'] ?? '',
      dateTime: map['dateTime'] ?? '',
      selectedAddress: map['selectedAddress'] ?? false,
    );
  }

  // Create AddressModel from Firestore DocumentSnapshot
  // factory AddressModel.fromDocumentSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> doc) {
  //   final data = doc.data()!;
  //   return AddressModel.fromMap(data);
  // }
  factory AddressModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return AddressModel(
      id: doc.id, // Get the document ID here
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      postalCode: data['postalCode'] ?? '',
      country: data['country'] ?? '',
      dateTime: data['dateTime'] ?? '',
      selectedAddress: data['selectedAddress'] ?? false,
    );
  }

  // CopyWith method to create a copy of AddressModel with updated fields
  AddressModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    String? dateTime,
    bool? selectedAddress,
  }) {
    return AddressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      dateTime: dateTime ?? this.dateTime,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }

  @override
  String toString() {
    return [
      street,
      city,
      if (postalCode.isNotEmpty) postalCode,
      if (state.isNotEmpty) state,
      country,
    ].where((part) => part.isNotEmpty).join(', ');
  }
}
