import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';

import '../../util/book_shared_preferences.dart';
import '../../util/constants.dart';

class TabsOrderScreen extends StatefulWidget {
  @override
  _TabsOrderScreenState createState() => _TabsOrderScreenState();
}

class _TabsOrderScreenState extends State<TabsOrderScreen>
    with BookSharedPreferences {
  List<int> tabsOrder = defaultTabsOrder;
  List<String> tabNames = [];

  @override
  void initState() {
    super.initState();
    _getSharedPreferences();
  }

  _getSharedPreferences() async {
    setState(() {
      getTabsOrder();
      for (int i = 0; i < tabNum; i++) {
        tabNames.add(defaultTabsNamesOrder[tabsOrder[i]]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(resourceDragAndDropTabs),
      ),
      body: Container(
          alignment: Alignment.center,
          child: DragAndDropList<String>(
            tabNames,
            itemBuilder: (BuildContext context, item) {
              return SizedBox(
                child: Card(
                  child: ListTile(
                    title: Text(item,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: highlightedRussianTextSize)),
                  ),
                ),
              );
            },
            onDragFinish: (before, after) {
              String data = tabNames[before];
              tabNames.removeAt(before);
              tabNames.insert(after, data);

              int index = tabsOrder[before];
              tabsOrder.removeAt(before);
              tabsOrder.insert(after, index);
              setTabsOrder();
            },
            canBeDraggedTo: (one, two) => true,
            dragElevation: 8.0,
          )),
    );
  }
}
