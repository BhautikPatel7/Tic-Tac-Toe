import 'package:flutter/material.dart';

// Model class to represent an item in the list
class Item {
  String header;
  String body;
  bool isExpanded;

  Item({required this.header, required this.body, this.isExpanded = false});
}

class ExpandableListView extends StatefulWidget {
  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  // List of items with header and body
  final List<Item> _data = [
    Item(header: 'Panel 1', body: 'This is the body of Panel 1'),
    Item(header: 'Panel 2', body: 'This is the body of Panel 2'),
    Item(header: 'Panel 3', body: 'This is the body of Panel 3'),
    Item(header: 'Panel 4', body: 'This is the body of Panel 4'),
  ];

  // This function will manage expanding and collapsing
  void _handlePanelTapped(int index) {
    setState(() {
      // Collapse all other panels
      for (int i = 0; i < _data.length; i++) {
        if (i == index) {
          print(_data[i].isExpanded);
          _data[i].isExpanded = !_data[i].isExpanded;
        } else {
          _data[i].isExpanded = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expandable List Demo'),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            _handlePanelTapped(index);
          },
          // Create ExpansionPanels dynamically
          children: _data.map<ExpansionPanel>((Item item) {
            int index = _data.indexOf(item);
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.header),
                );
              },
              body: ListTile(
                title: Text(item.body),
              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ),
      ),
    );
  }
}
