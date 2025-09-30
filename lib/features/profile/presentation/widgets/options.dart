import 'package:flutter/material.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/profile/domain/settings_item.dart';

class OptionsList extends StatelessWidget {
  final List<SettingsItem> items;

  const OptionsList({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(22),
      color: context.colorScheme.secondaryContainer,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder:
            (_, _) => const Divider(
              height: 1,
              color: Color.fromARGB(80, 131, 131, 131),
            ),
        itemBuilder: (_, index) => _OptionTile(item: items[index]),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final SettingsItem item;

  const _OptionTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final iconColor = item.onTap != null ? context.colorScheme.primary : null;

    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.label),
      trailing: item.onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: item.onTap,
      iconColor: iconColor,
    );
  }
}
