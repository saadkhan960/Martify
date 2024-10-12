import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MChoiceChip extends StatelessWidget {
  const MChoiceChip(
      {super.key, required this.text, required this.selected, this.onSelected});
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return ChoiceChip(
      label: Text(
        text,
        style: TextStyle(
            color: selected
                ? dark
                    ? MAppColors.white
                    : MAppColors.primary
                : MAppColors.darkGrey),
      ),
      selected: selected,
      onSelected: onSelected,
      selectedColor: dark ? MAppColors.scafoldDark : MAppColors.white,
      checkmarkColor: MAppColors.primary,
      labelStyle: TextStyle(color: selected ? MAppColors.white : null),
      side: BorderSide(
          color: selected ? MAppColors.primary : MAppColors.darkGrey),
    );
  }
}


// class MChoiceChip extends StatelessWidget {
//   const MChoiceChip(
//       {super.key, required this.text, required this.selected, this.onSelected});
//   final String text;
//   final bool selected;
//   final void Function(bool)? onSelected;

//   @override
//   Widget build(BuildContext context) {
//     final isColor = MHelperFunctions.getColor(text);
//     final dark = MHelperFunctions.isDarkMode(context);
//     return ChoiceChip(
//       label: isColor != null
//           ? const SizedBox()
//           : Text(
//               text,
//               style: TextStyle(
//                   color: selected ? MAppColors.white : MAppColors.darkGrey),
//             ),
//       selected: selected,
//       onSelected: onSelected,
//       selectedColor: dark ? MAppColors.scafoldDark : MAppColors.white,
//       checkmarkColor: isColor != null ? MAppColors.white : MAppColors.primary,
//       labelStyle: TextStyle(color: selected ? MAppColors.white : null),
//       avatar: isColor != null
//           ? MRoundedContainer(
//               width: 50,
//               height: 50,
//               backgroundColor: selected ? isColor : isColor.withOpacity(0.5),
//             )
//           : null,
//       side: BorderSide(
//           color:
//               isColor ?? (selected ? MAppColors.primary : MAppColors.darkGrey)),
//       backgroundColor: dark ? MAppColors.scafoldDark : MAppColors.white,
//       shape: isColor != null ? const CircleBorder() : null,
//       labelPadding: isColor != null ? const EdgeInsets.all(0) : null,
//       padding: isColor != null ? const EdgeInsets.all(0) : null,
//     );
//   }
// }
