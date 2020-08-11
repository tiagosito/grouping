import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grouping/grouping.dart';

void main() {
  final grouping = Grouping(
    items: GroupItemList(items: []),
    onTap: (item) {
      return item;
    },
    onRemove: <ModelExample>(item) async {
      //Simulating a call to the server
      var requestHTTP = await Future.delayed(Duration(seconds: 3));

      Future<bool> result = requestHTTP != null ? Future.value(true) : Future.value(false);

      print('Tentativa de Remover item ${item.toString()} = $result');
      return result;
    },
    onAdd: <ItemGroup>() async {
      var result = await Future.delayed(Duration(milliseconds: 350));

      if (result == null) {
        print('No items were selected');
      } else {
        return Future.value(buildGroupItem());
      }
      return null;
    },
  );

  test('Items is not null', () {
    expect(grouping.items != null, true);
    expect(grouping.items.getListItems.length, 0);
  });
  test('Items == 0', () {
    expect(grouping.items.getListItems.length, 0);
  });

  test('onTap is not null', () {
    expect(grouping.onTap != null, true);
  });

  test('onRemove is not null', () {
    expect(grouping.onRemove != null, true);
  });

  test('onAdd is not null', () {
    expect(grouping.onAdd != null, true);
  });
}

buildGroupItem() {
  return GroupingItem<ModelExample>(
    title: Text(
      'Name',
    ),
    item: ModelExample(name: 'Tiago', age: 36),
  );
}

class ModelExample {
  final String name;
  final int age;

  ModelExample({this.name, this.age});

  @override
  String toString() {
    return '$name $age';
  }

  factory ModelExample.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ModelExample(
      name: json["name"],
      age: json["age"],
    );
  }

  static List<ModelExample> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ModelExample.fromJson(item)).toList();
  }

  @override
  operator ==(object) => this.name.toLowerCase().contains(object.toLowerCase()) || this.age.toString().contains(object);

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}
