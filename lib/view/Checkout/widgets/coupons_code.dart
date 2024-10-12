import 'package:flutter/material.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MCouponCode extends StatelessWidget {
  const MCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);

    return MRoundedContainer(
      showBorder: true,
      borderColor: dark ? MAppColors.darkerGrey : MAppColors.borderPrimary,
      backgroundColor: dark ? MAppColors.dark : MAppColors.white,
      padding: const EdgeInsets.only(
          top: MSizes.sm, bottom: MSizes.sm, right: MSizes.sm, left: MSizes.md),
      child: Row(
        children: [
          //TextField
          Flexible(
              child: TextFormField(
            decoration: InputDecoration(
              hintText: "Have a promo code? Enter Here",
              hintStyle: TextStyle(
                  color: dark ? MAppColors.darkModeWhite : MAppColors.black,
                  fontSize: 13),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          )),
          //Apply Button
          SizedBox(
              width: 80,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Apply",
                    style: TextStyle(
                        color:
                            dark ? MAppColors.darkModeWhite : MAppColors.white,
                        fontSize: 13),
                  )))
        ],
      ),
    );
  }
}
