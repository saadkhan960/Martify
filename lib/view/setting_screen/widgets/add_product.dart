import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/popups/full_screen_loader.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  AddProductScreenState createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final salePriceController = TextEditingController();
  final stockController = TextEditingController();
  final skuController = TextEditingController();
  final descriptionController = TextEditingController();

  List<File?> images = [null, null, null]; // To hold the images
  String? selectedBrand;
  String? selectedCategory;
  final picker = ImagePicker();

  // New TextControllers for Colors and Sizes
  final color1Controller = TextEditingController();
  final color2Controller = TextEditingController();
  final color3Controller = TextEditingController();

  final size1Controller = TextEditingController();
  final size2Controller = TextEditingController();
  final size3Controller = TextEditingController();

  // Brand Dropdown Data
  final List<Map<String, dynamic>> brands = [
    {
      'id': 1,
      'name': 'Nike',
      'image': 'assets/icons/brand/nike',
      'isFeatured': true,
      'productCount': 50
    },
    {
      'id': 2,
      'name': 'Interwood',
      'image': 'assets/icons/brand/interwood',
      'isFeatured': true,
      'productCount': 50
    },
    {
      'id': 3,
      'name': 'Zara',
      'image': 'assets/icons/brand/zara',
      'isFeatured': true,
      'productCount': 50
    },
    {
      'id': 4,
      'name': 'Toyzone',
      'image': 'assets/icons/brand/toyzone',
      'isFeatured': true,
      'productCount': 50
    },
    {
      'id': 5,
      'name': 'Scents N Stories',
      'image': 'assets/icons/brand/scents',
      'isFeatured': true,
      'productCount': 50
    },
    {
      'id': 6,
      'name': 'L\'Oréal',
      'image': 'assets/icons/brand/loreal',
      'isFeatured': true,
      'productCount': 50
    },
    {
      'id': 7,
      'name': 'Apple',
      'image': 'assets/icons/brand/apple',
      'isFeatured': true,
      'productCount': 50
    },
    {
      'id': 8,
      'name': 'Seasons',
      'image': 'assets/icons/brand/seasons',
      'isFeatured': true,
      'productCount': 50
    },
  ];

  final categories = {
    'Sports': 1,
    'Toys': 10,
    'Cosmetics': 2,
    'Furniture': 3,
    'Pets': 4,
    'Cloths': 5,
    'Shoes': 6,
    'Electronics': 7,
  };

  // Pick Image from Gallery
  Future<void> pickImage(int index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      images[index] = File(pickedFile!.path);
    });
  }

  // Future<void> addProductToFirebase() async {
  //   try {
  //     if (_formKey.currentState!.validate() &&
  //         selectedBrand != null &&
  //         selectedCategory != null) {
  //       FullScreenLoader.show(context,
  //           lottieAsset: MImages.docerAnimation); // Start loader

  //       // Upload images to Firebase Storage
  //       List<String> imageUrls = [];
  //       for (File? image in images) {
  //         if (image != null) {
  //           final ref = FirebaseStorage.instance
  //               .ref()
  //               .child('product_images/${DateTime.now().toIso8601String()}');
  //           await ref.putFile(image);
  //           imageUrls.add(await ref.getDownloadURL());
  //         }
  //       }

  //       // Handle Color and Size Lists
  //       List<String> colors = [];
  //       List<String> sizes = [];

  //       if (color1Controller.text.isNotEmpty) colors.add(color1Controller.text);
  //       if (color2Controller.text.isNotEmpty) colors.add(color2Controller.text);
  //       if (color3Controller.text.isNotEmpty) colors.add(color3Controller.text);

  //       if (size1Controller.text.isNotEmpty) sizes.add(size1Controller.text);
  //       if (size2Controller.text.isNotEmpty) sizes.add(size2Controller.text);
  //       if (size3Controller.text.isNotEmpty) sizes.add(size3Controller.text);

  //       // Add product to Firestore (await the add operation)
  //       await FirebaseFirestore.instance.collection('products').add({
  //         'title': titleController.text,
  //         'price': double.parse(priceController.text),
  //         'sale_price': salePriceController.text.isEmpty
  //             ? null
  //             : double.parse(salePriceController.text),
  //         'stock': int.parse(stockController.text),
  //         'sku': "MT-${skuController.text}",
  //         'description': descriptionController.text,
  //         'images': imageUrls,
  //         'colors': colors.isNotEmpty ? colors : null, // Add only if not empty
  //         'sizes': sizes.isNotEmpty ? sizes : null, // Add only if not empty
  //         'brand':
  //             int.parse(selectedBrand!), // Now storing as int from dropdown
  //         'categoryId': categories[selectedCategory], // Storing category id
  //         'isFeatured': true,
  //       });

  //       // Show success message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Product added successfully!')));

  //       // Clear fields after submission
  //       _formKey.currentState!.reset();
  //       titleController.clear();
  //       priceController.clear();
  //       salePriceController.clear();
  //       stockController.clear();
  //       skuController.clear();
  //       descriptionController.clear();
  //       color1Controller.clear();
  //       color2Controller.clear();
  //       color3Controller.clear();
  //       size1Controller.clear();
  //       size2Controller.clear();
  //       size3Controller.clear();

  //       setState(() {
  //         images = [null, null, null];
  //         selectedBrand = null;
  //         selectedCategory = null;
  //       });
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Please fill all required fields')));
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to add product: ${e.toString()}')));
  //   } finally {
  //     // Hide the loader even if there's an error
  //     FullScreenLoader.hide(context);
  //   }
  // }

  Future<void> addProductToFirebase() async {
    if (_formKey.currentState!.validate() &&
        selectedBrand != null &&
        selectedCategory != null) {
      FullScreenLoader.show(context, lottieAsset: MImages.docerAnimation);
      // Upload images to Firebase Storage
      List<String> imageUrls = [];
      for (File? image in images) {
        if (image != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('product_images/${DateTime.now().toIso8601String()}');
          await ref.putFile(image);
          imageUrls.add(await ref.getDownloadURL());
        }
      }

      // Get selected brand details
      final brand = brands.firstWhere((b) => b['name'] == selectedBrand);

      // Handle Color and Size Lists
      List<String> colors = [];
      List<String> sizes = [];

      if (color1Controller.text.isNotEmpty) colors.add(color1Controller.text);
      if (color2Controller.text.isNotEmpty) colors.add(color2Controller.text);
      if (color3Controller.text.isNotEmpty) colors.add(color3Controller.text);

      if (size1Controller.text.isNotEmpty) sizes.add(size1Controller.text);
      if (size2Controller.text.isNotEmpty) sizes.add(size2Controller.text);
      if (size3Controller.text.isNotEmpty) sizes.add(size3Controller.text);

      // Add product to Firestore
      FirebaseFirestore.instance.collection('products').add({
        'title': titleController.text,
        'price': double.parse(priceController.text),
        'sale_price': salePriceController.text == ""
            ? null
            : double.parse(salePriceController.text),
        'stock': int.parse(stockController.text),
        'sku': "MT-${skuController.text}",
        'description': descriptionController.text,
        'images': imageUrls,
        'colors': colors.isNotEmpty ? colors : null, // Add only if not empty
        'sizes': sizes.isNotEmpty ? sizes : null, // Add only if not empty
        'brand': brand['id'],
        'categoryId': categories[selectedCategory],
        'isFeatured': true,
      });
      // Clear fields after submission
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully!')));
      _formKey.currentState!.reset();
      titleController.clear();
      priceController.clear();
      salePriceController.clear();
      stockController.clear();
      skuController.clear();
      descriptionController.clear();
      color1Controller.clear();
      color2Controller.clear();
      color3Controller.clear();
      size1Controller.clear();
      size2Controller.clear();
      size3Controller.clear();

      setState(() {
        images = [null, null, null];
        selectedBrand = null;
        selectedCategory = null;
      });
      FullScreenLoader.hide(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) => value!.isEmpty ? 'Enter title' : null,
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter price' : null,
                ),
                TextFormField(
                  controller: salePriceController,
                  decoration: const InputDecoration(labelText: 'Sale Price'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: stockController,
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: skuController,
                  decoration: const InputDecoration(labelText: 'SKU'),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),

                // Color Input Fields
                const Text("Colors (optional)",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: color1Controller,
                  decoration: const InputDecoration(labelText: 'Color 1'),
                ),
                TextFormField(
                  controller: color2Controller,
                  decoration: const InputDecoration(labelText: 'Color 2'),
                ),
                TextFormField(
                  controller: color3Controller,
                  decoration: const InputDecoration(labelText: 'Color 3'),
                ),

                // Size Input Fields
                const Text("Sizes (optional)",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: size1Controller,
                  decoration: const InputDecoration(labelText: 'Size 1'),
                ),
                TextFormField(
                  controller: size2Controller,
                  decoration: const InputDecoration(labelText: 'Size 2'),
                ),
                TextFormField(
                  controller: size3Controller,
                  decoration: const InputDecoration(labelText: 'Size 3'),
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => pickImage(i),
                          child: Container(
                            height: 100,
                            color: Colors.grey[200],
                            child: images[i] == null
                                ? const Icon(Icons.add_a_photo)
                                : Image.file(images[i]!, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  value: selectedBrand,
                  decoration: const InputDecoration(labelText: 'Brand'),
                  items: brands.map((brand) {
                    return DropdownMenuItem(
                      value: brand['name'],
                      child: Text(brand['name']),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => selectedBrand = value.toString()),
                  validator: (value) => value == null ? 'Select a brand' : null,
                ),
                DropdownButtonFormField(
                  value: selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: categories.keys.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => selectedCategory = value),
                  validator: (value) =>
                      value == null ? 'Select a category' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: addProductToFirebase,
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
