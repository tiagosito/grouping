import 'package:flutter/material.dart';
import 'package:grouping/model/grouping_item_list.dart';
import 'package:grouping/model/grouping_item.dart';

class Grouping<T> extends StatefulWidget {
  const Grouping({
    Key key,
    double height,
    Text label,
    Color background,
    Icon iconAdd,
    @required this.onAdd,
    Text labelAdd,
    @required this.onTap,
    @required this.onRemove,
    @required this.items,
  })  : this.height = height != null ? height : 150,
        this.label = label != null ? label : null,
        this.background =
            background != null ? background : const Color(0xFFF5F5F5),
        this.labelAdd = labelAdd != null ? labelAdd : const Text('CATEGORY'),
        assert(onAdd != null, 'onAdd Function cannot be null'),
        this.iconAdd = iconAdd != null
            ? iconAdd
            : const Icon(Icons.add, size: 12, color: Colors.red),
        assert(onRemove != null, 'onRemove Function cannot be null'),
        super(key: key);

  ///Property name [height]:
  ///
  ///Value type: double
  ///
  ///Maximum component height
  ///
  ///Default value is 150.0
  ///
  final double height;

  ///Property name label:
  ///
  ///Tag that best describes your data
  ///
  ///Value type: Text
  ///
  ///Default value: const Text('CATEGORY'),
  ///
  final Text label;

  ///Property name [background]:
  ///
  ///Component background color
  ///
  ///Value type: Color
  ///
  ///Default value: const Color(0xFFF5F5F5),
  ///
  final Color background;

  ///Property name [iconAdd]:
  ///
  ///add item icon
  ///
  ///Value type: Icon
  ///
  ///Default value: const Icon(Icons.add, size: 12, color: Colors.red),
  ///
  final Icon iconAdd;

  ///Property name [onAdd]:
  ///
  ///Add item Function
  ///
  ///This property is required, that is, it cannot be null
  ///
  ///Value type: Function<T>()
  ///
  ///Expected return: Future<GroupingItem<T>>
  ///
  ///Follow the example:
  ///
  ///```dart
  ///onAdd: <ItemGroup>() async {
  ///  ModelExample result = await Navigator.push(
  ///    context,
  ///    MaterialPageRoute(
  ///      builder: (context) => TryGetValue(),
  ///    ),
  ///  );
  ///
  ///  if (result == null) {
  ///    print('No items were selected');
  ///  } else {
  ///    return Future.value(buildItemGroup(result));//Return function
  ///  }
  ///  return null;
  ///},
  ///
  ///```
  ///
  ///```dart
  ///
  ///buildItemGroup(ModelExample result) {//Return function
  ///  return GroupingItem<ModelExample>(
  ///    icon: Icon(Icons.payment, size: 35, color: Theme.of(context).primaryColor),
  ///    remove: Icon(Icons.delete, size: 15, color: Theme.of(context).primaryColor),
  ///    title: Text(
  ///      '${result.name.toUpperCase()} - ${result.age}',
  ///      style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
  ///    ),
  ///    titleLeading: Text('due date: 12/27/22', textAlign: TextAlign.right),
  ///    subtitle: Text(
  ///      '000000.00000.00.0000 0 00 00000 000000 000 0 00000 0 000',
  ///      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
  ///    ),
  ///    subtitleLeading: Text('U\$ 999.999.99', textAlign: TextAlign.right),
  ///    item: result,
  ///    background: Colors.grey[50],
  ///  );
  ///}
  ///```
  ///
  final Future<GroupingItem<T>> Function<T>() onAdd;

  ///Property name [labelAdd]:
  ///
  ///Label describes the data that will be added
  ///
  ///Value type: Text
  ///
  ///Default value: null
  ///
  final Text labelAdd;

  ///Property name [onTap]:
  ///
  ///Tap item Function
  ///
  ///This property is required, that is, it cannot be null
  ///
  ///Value type: Function(T)
  ///
  ///Expected return: Future<T>
  ///
  ///Follow the example:
  ///
  ///```dart
  ///onTap: (item) async {
  ///  print('Click do Item ${item.toString()}');
  ///  return item;
  ///},
  ///```
  ///
  final Future<T> Function(T) onTap;

  ///Property name [onRemove]:
  ///
  ///Remove item Function
  ///
  ///This property is required, that is, it cannot be null
  ///
  ///Value type: Function<T>(T)
  ///
  ///Expected return: Future<bool>
  ///
  ///Follow the example:
  ///
  ///```dart
  ///onRemove: <ModelExample>(item) async {
  ///  //Simulating a call to the server
  ///  var requestHTTP = await Future.delayed(Duration(seconds: 3));
  ///
  ///  Future<bool> result = requestHTTP != null ? Future.value(true) : Future.value(false);
  ///
  ///  print('Tentativa de Remover item ${item.toString()} = $result');
  ///  return result;
  ///},
  ///```
  ///
  final Future<bool> Function<T>(T) onRemove;

  ///Property name [items]:
  ///
  ///A list of items to be added to the grouping
  ///
  ///Value type: [GroupItemList]
  ///
  final GroupItemList items;

  @override
  _GroupingState<T> createState() => _GroupingState<T>();
}

class _GroupingState<T> extends State<Grouping<T>> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        constraints: BoxConstraints(maxHeight: widget.height),
        color: widget.background,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null)
              Row(
                children: [
                  Expanded(child: widget.label),
                ],
              ),
            if (widget.label != null)
              SizedBox(
                height: 4.0,
              ),
            ValueListenableBuilder(
              valueListenable: widget.items,
              builder: (context, _, __) {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: widget.height - 80),
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: widget.items.getListItems.length,
                    itemBuilder: (context, index) {
                      var item = widget.items.getListItems[index];
                      return Material(
                        color: item.background,
                        child: InkWell(
                          onTap: () async {
                            if (item.getIsRemoving()) {
                              debugPrint(
                                  '${item.item.toString()} is being removed');
                              return;
                            }
                            debugPrint(item.item.toString());
                            await widget.onTap(item.item);
                          },
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  if (item.getIsRemoving())
                                    Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    ),
                                  if (item.icon != null)
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          minWidth: 35, maxWidth: 35),
                                      child: item.icon,
                                    ),
                                  if (item.showRemoveButton)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Material(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(35.0),
                                        child: InkWell(
                                          highlightColor:
                                              item.removeHighlightColor,
                                          borderRadius:
                                              BorderRadius.circular(35.0),
                                          onTap: () async {
                                            if (item.getIsRemoving()) {
                                              return;
                                            }

                                            try {
                                              item.setIsRemoving(item);
                                              widget.items.updateList();
                                              var result = await widget
                                                  .onRemove(item.item);
                                              if (result == null) {
                                                return;
                                              } else {
                                                widget.items.removeItem(item);
                                              }
                                            } catch (e) {
                                              debugPrint(e);
                                            }
                                          },
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 35,
                                              maxWidth: 35,
                                              minHeight: 35,
                                              maxHeight: 35,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35.0),
                                              ),
                                              child: Center(child: item.remove),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: item.icon == null ? 0 : 50,
                                        right: item.remove == null ? 0 : 40),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: (item
                                                                .showRemoveButton &&
                                                            (item.subtitle ==
                                                                    null ||
                                                                item.subtitle ==
                                                                    null))
                                                        ? 9.0
                                                        : 0.0),
                                                child: item.title,
                                              ),
                                            ),
                                            if (item.titleLeading != null)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: 120),
                                                  child: item.titleLeading,
                                                ),
                                              ),
                                          ],
                                        ),
                                        if (item.subtitle != null)
                                          SizedBox(
                                            height: 4,
                                          ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (item.subtitle != null)
                                              Expanded(
                                                child: item.subtitle,
                                              ),
                                            if (item.subtitleLeading != null)
                                              item.subtitle == null
                                                  ? Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: ConstrainedBox(
                                                          constraints:
                                                              BoxConstraints(
                                                                  maxWidth:
                                                                      120),
                                                          child: item
                                                              .subtitleLeading,
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxWidth: 120),
                                                        child: item
                                                            .subtitleLeading,
                                                      ),
                                                    ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            //SizedBox(height: widget.items.getListItems == null || widget.items.getListItems.length == 0 ? 0.0 : 24.0),
            Material(
              color: widget.background,
              child: InkWell(
                onTap: () async {
                  var result = await widget.onAdd();

                  if (result != null) {
                    widget.items.setListItem(result);

                    if (widget.items.getListItems.length > 1) {
                      _scrollToEnd();
                    }
                  }
                },
                child: Container(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      widget.iconAdd,
                      widget.labelAdd,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _scrollToEnd() async {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: Duration(microseconds: 350),
      curve: Curves.fastOutSlowIn,
    );
  }
}
