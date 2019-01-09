import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/constants.dart';

class TabsOrderScreen extends StatefulWidget {
  @override
  _TabsOrderScreenState createState() => _TabsOrderScreenState();
}

class _TabsOrderScreenState extends State<TabsOrderScreen> {
  List<int> tabsOrder = defaultTabsOrder;
  List<String> tabNames = [];

  @override
  void initState() {
    super.initState();
    _getSharedPreferences();
  }

  _getSharedPreferences() async {
    setState(() {
      _getTabsOrder();
    });
  }

  _getTabsOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tabsOrder[0] = (prefs.getInt(tab0) ?? defaultTabsOrder[0]);
      tabsOrder[1] = (prefs.getInt(tab1) ?? defaultTabsOrder[1]);
      tabsOrder[2] = (prefs.getInt(tab2) ?? defaultTabsOrder[2]);
      tabsOrder[3] = (prefs.getInt(tab3) ?? defaultTabsOrder[3]);

      for (int i = 0; i < tabNum; i++) {
        tabNames.add(defaultTabsNamesOrder[tabsOrder[i]]);
      }
    });
  }

  _setTabsOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(tab0, tabsOrder[0]);
    prefs.setInt(tab1, tabsOrder[1]);
    prefs.setInt(tab2, tabsOrder[2]);
    prefs.setInt(tab3, tabsOrder[3]);
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
              _setTabsOrder();
            },
            canBeDraggedTo: (one, two) => true,
            dragElevation: 8.0,
          )),
    );
  }
}
