import 'package:flutter/material.dart';

class VisualizerWidgets {
  static Widget buildBoxedList(List<String> items,
      {bool reverse = false, bool horizontal = false, bool arrow = false}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(12),
        child: horizontal
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildBoxes(items, arrow),
                ),
              )
            : ListView(
                reverse: reverse,
                children: _buildBoxes(items, arrow),
              ),
      ),
    );
  }

  static List<Widget> _buildBoxes(List<String> items, bool arrow) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(Container(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[100], borderRadius: BorderRadius.circular(8)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(items[i],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text('[$i]', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ]),
      ));
      if (arrow && i != items.length - 1)
        widgets.add(Icon(Icons.arrow_forward, color: Colors.blue[600]));
    }
    return widgets;
  }

  static Widget buildResultDisplay(String result, Color backgroundColor) {
    if (result.isEmpty) return SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: backgroundColor.withOpacity(0.3)),
      ),
      child: Text(
        result,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget getStructureIcon(String structure) {
    switch (structure) {
      case 'Array':
        return Icon(Icons.view_list, color: Colors.blue[600]);
      case 'Stack':
        return Icon(Icons.layers, color: Colors.orange[600]);
      case 'Queue':
        return Icon(Icons.queue, color: Colors.green[600]);
      case 'Linked List':
        return Icon(Icons.link, color: Colors.purple[600]);
      case 'Tree':
        return Icon(Icons.account_tree, color: Colors.brown[600]);
      case 'Graph':
        return Icon(Icons.hub, color: Colors.teal[600]);
      case 'Hash Table':
        return Icon(Icons.table_chart, color: Colors.indigo[600]);
      case 'Heap':
        return Icon(Icons.trending_up, color: Colors.red[600]);
      default:
        return Icon(Icons.data_usage);
    }
  }
}
