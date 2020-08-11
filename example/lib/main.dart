import 'package:flutter/material.dart';
import 'package:grouping/grouping.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grouping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Group(),
    );
  }
}

class Group extends StatefulWidget {
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  List<GroupingItem<ModelExample>> list = [];
  GroupItemList _listItemsGroup = GroupItemList(items: []);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grouping'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
            child: Grouping(
              label: Text('Category'.toUpperCase(), style: TextStyle(color: Theme.of(context).primaryColor)),
              iconAdd: Icon(
                Icons.add,
                size: 12,
                color: Theme.of(context).primaryColor,
              ),
              labelAdd: Text('Add new category', style: TextStyle(color: Theme.of(context).primaryColor)),
              height: 250,
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
          ),
        ],
      ),
    );
  }

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
}

class TryGetValue extends StatefulWidget {
  @override
  _TryGetValueState createState() => _TryGetValueState();
}

class _TryGetValueState extends State<TryGetValue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          RaisedButton(
            child: Text('Ok'),
            onPressed: () {
              var item = ModelExample(name: 'Tiago', age: DateTime.now().second);
              Navigator.pop(context, item);
            },
          )
        ],
      ),
    );
  }
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
