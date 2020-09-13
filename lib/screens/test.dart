
import 'package:flutter/material.dart';
import 'package:drawerbehavior/drawerbehavior.dart';

class Drawer4 extends StatefulWidget {
  @override
  _Drawer4State createState() => _Drawer4State();
}

class _Drawer4State extends State<Drawer4> {
  final menu = new Menu(
    items: [
      new MenuItem(
        id: 'restaurant',
        title: 'THE PADDOCK',
      ),
      new MenuItem(
        id: 'other1',
        title: 'THE HERO',
      ),
      new MenuItem(
        id: 'other2',
        title: 'HELP US GROW',
      ),
      new MenuItem(
        id: 'other3',
        title: 'SETTINGS',
      ),
    ],
  );

  var selectedMenuItemId = 'restaurant';
  var _widget = Text("1");


  @override
  Widget build(BuildContext context) {
    return new DrawerScaffold(
      percentage:0.6,
      cornerRadius: 0,
      appBar: AppBarProps(
          title: Text("Drawer 4"),
          actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})]),
      menuView: new MenuView(
        menu: menu,
      // headerView: headerView(context),
        animation: true,
        color: Theme.of(context).primaryColor,
        selectedItemId: selectedMenuItemId,
        onMenuItemSelected: (String itemId) {
          selectedMenuItemId = itemId;
          if (itemId == 'restaurant') {
            setState(() => _widget = Text("1"));
          } else {
            setState(() => _widget = Text("default"));
          }
        },
      ),
      contentView: Screen(
        contentBuilder: (context) => Center(child: _widget),
        color: Colors.white,
      ),
    );
  }
}

