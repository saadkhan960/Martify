import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';

class MSettingsMenuTile extends StatelessWidget {
  const MSettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onPressed,
  });
  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      leading: Icon(icon, size: 28, color: MAppColors.primary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onPressed,
    );
  }
}
