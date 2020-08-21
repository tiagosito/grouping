import 'package:flutter/material.dart';

import 'grouping_item.dart';

class GroupItemList<T> extends ValueNotifier {
  GroupItemList({List<T> items}) : super(items) {
    if (items == null || items.length == 0) {
      return;
    } else {
      items.forEach((element) {
        setListItem((element as GroupingItem));
      });
    }
  }

  ///Property name [listItems] :
  ///
  ///A list to group [GroupingItem]
  ///
  ///Value type: ValueNotifier<List<GroupingItem>>
  ///
  /// Default value: [],
  ///
  ValueNotifier<List<GroupingItem>> listItems =
      ValueNotifier<List<GroupingItem>>([]);

  ///Metod name [getListItems] :
  ///
  ///A method that brings items from the ValueNotifier list [listItems]
  ///
  ///Note: can return null
  ///
  List<GroupingItem> get getListItems => listItems?.value ?? null;

  ///
  ///A method that inserts the data into the [listItems]
  ///
  ///Note: returns an exception if the [item] is null
  ///
  setListItem(GroupingItem item) {
    if (item == null) {
      return throw ('ItemGroup cannot be null or empty');
    }

    if (this.listItems == null) {
      List<GroupingItem> list = [item];
      this.listItems = ValueNotifier<List<GroupingItem>>(list);
    } else {
      var itemsTemp =
          this.listItems.value.where((element) => element == item).toList();
      if (itemsTemp != null && itemsTemp.length > 0) {
        this.listItems.value.remove(item);
      }
      this.listItems.value.add(item);
    }

    updateList();
  }

  ///
  ///A method that remove the data into the [listItems]
  ///
  ///Note: returns an exception if the [item] is null
  ///
  ///or if the [listItems] is null
  ///
  ///or if the [listItems].length is equal 0
  ///
  removeItem(T item) {
    if (item == null) {
      return throw ('Item cannot be null');
    }

    if (this.getListItems == null) {
      return throw ('The list cannot be null');
    }

    if (this.getListItems.length == 0) {
      return throw ('The list is already empty');
    }

    this.listItems.value.remove(item);

    updateList();
  }

  ///
  ///A method that update [listItems]
  ///
  updateList() {
    notifyListeners();
  }
}
