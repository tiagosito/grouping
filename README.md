
<img src="https://github.com/tiagosito/grouping/raw/master/doc/assets/grouping_logo_full.png" width="100%" alt="logo" />
<h2 align="center">
  A component for you to group similar content, being able to add new, select or remove existing ones.
</h2>

<p align="center">
<a href="https://pub.dartlang.org/packages/grouping">
  <img alt="Pub Package" src="https://img.shields.io/pub/v/grouping.svg">
</a>
  <a href="https://www.buymeacoffee.com/tiagosito" target="_blank"><img alt="Buy Me A Coffee" src="https://i.imgur.com/aV6DDA7.png" </a>
</p>
 
  
## Overview

A simple data grouper

#### Contributing
  - [https://github.com/tiagosito/grouping](https://github.com/tiagosito/grouping)


#### Getting Started


In _pubspec.yaml_:
```yaml
dependencies:
  grouping: any
```

### Adding, Select and Removing data :
<img src="https://github.com/tiagosito/grouping/blob/master/doc/assets/grouping.gif?raw=true" width="30%" alt="Using grouping" />

```dart
import 'package:grouping/grouping.dart';

Grouping(
label: Text('Category'.toUpperCase(), style: TextStyle(color: Theme.of(context).primaryColor)),
iconAdd: Icon(
  Icons.add,
  size: 12,
  color: Theme.of(context).primaryColor,
),
labelAdd: Text('Add new category', style: TextStyle(color: Theme.of(context).primaryColor)),
height: 350,
//background: Colors.red,
items: _listItemsGroup,
onTap: (item) async {
  print('Click do Item ${item.toString()}');

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
  ModelExample result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TryGetValue(),
    ),
  );

  if (result == null) {
    print('No items were selected');
  } else {
    return Future.value(buildItemGroup(result));
  }
  return null;
},
),

buildItemGroup(ModelExample result) {
  return GroupingItem<ModelExample>(
    icon: Icon(Icons.payment, size: 35, color: Theme.of(context).primaryColor),
    remove: Icon(Icons.delete, size: 15, color: Theme.of(context).primaryColor),
    title: Text(
      '${result.name.toUpperCase()} - ${result.age}',
      style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
    ),
    titleLeading: Text('due date: ${(DateTime.now().second % 2 == 0) ? '09/27/22' : '12/27/22'}', textAlign: TextAlign.right),
    subtitle: Text(
      (DateTime.now().second % 2 == 0)
          ? '256789.48592.70.9874 0 11'
          : '000000.00000.00.0000 0 00 00000 000000 000 0 00000 0 000',
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
    ),
    subtitleLeading: Text((DateTime.now().second % 2 == 0) ? 'U\$ 777.777.77' : 'U\$ 999.999.99', textAlign: TextAlign.right),
    item: result,
    //showRemoveButton: true, // default == true
    // background: Colors.grey[500],
  );
}
```

##### Model example
```dart
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
}
```

## Features and bugs

Please send feature requests and bugs at the [issue tracker](https://github.com/tiagosito/grouping/issues).
