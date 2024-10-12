class PaymentMethodModel {
  String name;
  String image;

  PaymentMethodModel({required this.image, required this.name});

  static PaymentMethodModel empty() => PaymentMethodModel(image: "", name: "");
}
// class PaymentMethodModel extends Equatable {
//   final String image;
//   final String name;

//   const PaymentMethodModel({required this.image, required this.name});

//   @override
//   List<Object> get props => [image, name];
// }