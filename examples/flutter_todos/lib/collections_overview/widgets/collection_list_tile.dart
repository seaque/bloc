import 'package:collections_repository/collections_repository.dart';
import 'package:flutter/material.dart';

class CollectionListTile extends StatelessWidget {
  const CollectionListTile({
    required this.collection,
    this.onTap});

  final Collection collection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodyMedium?.color;

    return ListTile(
      onTap: onTap,
      title: Text(
        collection.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: captionColor,
        ),
      ),
      trailing: onTap == null
          ? null
          : const Icon(
              Icons.edit_rounded,
            ),
    );
  }
}
