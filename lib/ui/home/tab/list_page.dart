import 'package:flutter/material.dart';


class ListTabPage extends StatefulWidget {
  final List<_Item> _items = [];

  @override
  State createState() {
    return _ListTabPageState();
  }
}

class _ListTabPageState extends State<ListTabPage> {

  final _item = _Item(
      'https://libreshot.com/wp-content/uploads/2015/09/beach.jpg',
      'Beach and parasol in Corfu (Kerkyra), Greece with deck chairs.');

  void onFloatingPressed() {
    setState(() {
      widget._items.add(_item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(itemBuilder: (context, index) {
          if (index < widget._items.length) {
            return _buildItem(index);
          }
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.indigoAccent,
            onPressed: onFloatingPressed,
            tooltip: 'add item'));
  }

  Widget _buildItem(int index) {
    return Card(
      elevation: 3,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
            child: Image.network(widget._items[index].url, fit: BoxFit.fitWidth),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
            child: Text(
              widget._items[index].text,
              maxLines: 2,
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

class _Item {
  String url;
  String text;

  _Item(this.url, this.text);
}
