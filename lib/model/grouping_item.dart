import 'package:flutter/material.dart';

class GroupingItem<T> {
  ///Property name [item]:
  ///
  ///Value type: T
  ///
  T item;

  ///Property name [icon]:
  ///
  ///Leading icon
  ///
  ///Value type: Icon
  ///
  Icon icon;

  ///Property name [remove]:
  ///
  ///Trailing icon
  ///
  ///Value type: Icon
  ///
  ///Default value: const Icon(Icons.delete, size: 12, color: Colors.red),
  ///
  Icon remove;

  ///Property name [removeHighlightColor]:
  ///
  /// The highlight color of the ink response when pressed. If this property is
  /// null then the highlight color of the theme, [ThemeData.highlightColor],
  /// will be used.
  ///
  /// Value type: Color
  ///
  /// Default value: [ThemeData.highlightColor],
  ///
  Color removeHighlightColor;

  ///Property name [title]:
  ///
  ///Tag that best describes your data
  ///
  ///This property is required, that is, it cannot be null
  ///
  Text title;

  ///Property name [titleLeading]:
  ///
  ///Title leading data
  ///
  Text titleLeading;

  ///Property name [subtitle]:
  ///
  ///Subtitle data
  ///
  Text subtitle;

  ///Property name [subtitle]:
  ///
  ///Subtitle leading data
  ///
  Text subtitleLeading;

  ///Property name [background]:
  ///
  ///Item background color
  ///
  ///Value type: Color
  ///
  Color background;

  ///Property name [hideRemoveButton]:
  ///
  ///Hide or show the Remove button
  ///
  ///Value type: bool
  ///
  /// Default value: true,
  ///
  bool showRemoveButton;

  ///Property name [_removing]:
  ///
  ///blocks functions when an item is being removed
  ///
  ///Internal use
  ///
  bool _removing;

  GroupingItem({
    T item,
    Icon icon,
    Icon remove,
    @required Text title,
    Text titleLeading,
    Text subtitle,
    Text subtitleLeading,
    Color background,
    bool showRemoveButton,
  }) {
    this.item = item;
    this.icon = icon;
    this.remove = remove != null
        ? remove
        : const Icon(Icons.delete, size: 12, color: Colors.red);
    this.removeHighlightColor = removeHighlightColor;
    this.title = title;
    this.titleLeading = titleLeading;
    this.subtitle = subtitle;
    this.subtitleLeading = subtitleLeading;
    this.background = background;
    this.showRemoveButton = showRemoveButton != null ? showRemoveButton : true;
    this._removing = false;
  }

  setIsRemoving(GroupingItem item) {
    item._removing = true;
  }

  bool getIsRemoving() => _removing;
}
