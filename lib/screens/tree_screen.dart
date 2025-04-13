// // tree_screen.dart
// import 'package:flutter/material.dart';
// // import 'dart:math';

// class TreeScreen extends StatefulWidget {
//   @override
//   _TreeScreenState createState() => _TreeScreenState();
// }

// class _TreeScreenState extends State<TreeScreen> {
//   final TextEditingController _inputController = TextEditingController();
//   List<String> nodes = [];
//   String selectedTraversal = 'Inorder';
//   List<String> traversalResult = [];

//   void _performTraversal() {
//     setState(() {
//       traversalResult.clear();
//       if (selectedTraversal == 'Inorder') {
//         _inorder(0);
//       } else if (selectedTraversal == 'Preorder') {
//         _preorder(0);
//       } else if (selectedTraversal == 'Postorder') {
//         _postorder(0);
//       }
//     });
//   }

//   void _inorder(int index) {
//     if (index >= nodes.length || nodes[index].isEmpty) return;
//     _inorder(2 * index + 1);
//     traversalResult.add(nodes[index]);
//     _inorder(2 * index + 2);
//   }

//   void _preorder(int index) {
//     if (index >= nodes.length || nodes[index].isEmpty) return;
//     traversalResult.add(nodes[index]);
//     _preorder(2 * index + 1);
//     _preorder(2 * index + 2);
//   }

//   void _postorder(int index) {
//     if (index >= nodes.length || nodes[index].isEmpty) return;
//     _postorder(2 * index + 1);
//     _postorder(2 * index + 2);
//     traversalResult.add(nodes[index]);
//   }

//   Widget _buildTree() {
//     if (nodes.isEmpty) return Container();
//     return _buildLevel(0, 0);
//   }

//   Widget _buildLevel(int index, int depth) {
//     if (index >= nodes.length || nodes[index].isEmpty) return Container();
//     return Column(
//       children: [
//         if (depth > 0) SizedBox(height: 12),
//         Text(nodes[index], style: TextStyle(fontSize: 20)),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildLevel(2 * index + 1, depth + 1),
//             SizedBox(width: 20),
//             _buildLevel(2 * index + 2, depth + 1),
//           ],
//         )
//       ],
//     );
//   }

//   void _buildTreeData() {
//     nodes = _inputController.text.split(',').map((e) => e.trim()).toList();
//     setState(() {
//       traversalResult.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Tree Traversal Visualizer')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _inputController,
//                 decoration: InputDecoration(
//                   labelText: 'Enter nodes (comma-separated)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 12),
//               ElevatedButton(
//                 onPressed: _buildTreeData,
//                 child: Text('Build Tree'),
//               ),
//               SizedBox(height: 10),
//               DropdownButton<String>(
//                 value: selectedTraversal,
//                 onChanged: (value) =>
//                     setState(() => selectedTraversal = value!),
//                 items: ['Inorder', 'Preorder', 'Postorder']
//                     .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                     .toList(),
//               ),
//               SizedBox(height: 8),
//               ElevatedButton(
//                 onPressed: _performTraversal,
//                 child: Text('Start Traversal'),
//               ),
//               SizedBox(height: 20),
//               Text('Tree Structure:',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               _buildTree(),
//               SizedBox(height: 20),
//               Text('Traversal Result:',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               Wrap(
//                 spacing: 8,
//                 children:
//                     traversalResult.map((e) => Chip(label: Text(e))).toList(),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
// import 'dart:math';

class TreeScreen extends StatefulWidget {
  @override
  _TreeScreenState createState() => _TreeScreenState();
}

class _TreeScreenState extends State<TreeScreen> {
  final TextEditingController _inputController = TextEditingController();
  List<String> nodes = [];
  String selectedTraversal = 'Inorder';
  List<String> traversalResult = [];

  void _performTraversal() {
    setState(() {
      traversalResult.clear();
      if (selectedTraversal == 'Inorder') {
        _inorder(0);
      } else if (selectedTraversal == 'Preorder') {
        _preorder(0);
      } else if (selectedTraversal == 'Postorder') {
        _postorder(0);
      }
    });
  }

  void _inorder(int index) {
    if (index >= nodes.length || nodes[index].isEmpty) return;
    _inorder(2 * index + 1);
    traversalResult.add(nodes[index]);
    _inorder(2 * index + 2);
  }

  void _preorder(int index) {
    if (index >= nodes.length || nodes[index].isEmpty) return;
    traversalResult.add(nodes[index]);
    _preorder(2 * index + 1);
    _preorder(2 * index + 2);
  }

  void _postorder(int index) {
    if (index >= nodes.length || nodes[index].isEmpty) return;
    _postorder(2 * index + 1);
    _postorder(2 * index + 2);
    traversalResult.add(nodes[index]);
  }

  Widget _buildTree() {
    if (nodes.isEmpty) return Container();
    return _buildLevel(0, 0);
  }

  Widget _buildLevel(int index, int depth) {
    if (index >= nodes.length || nodes[index].isEmpty) return Container();
    return Column(
      children: [
        if (depth > 0) SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.deepPurple[100],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
            ],
          ),
          child: Text(
            nodes[index],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLevel(2 * index + 1, depth + 1),
            SizedBox(width: 30),
            _buildLevel(2 * index + 2, depth + 1),
          ],
        ),
      ],
    );
  }

  void _buildTreeData() {
    nodes = _inputController.text.split(',').map((e) => e.trim()).toList();
    setState(() {
      traversalResult.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('🌳 Tree Traversal Visualizer'),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      labelText: 'Enter nodes (comma-separated)',
                      prefixIcon: Icon(Icons.code),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _buildTreeData,
                          icon: Icon(Icons.nature),
                          label: Text('Build Tree'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      DropdownButton<String>(
                        value: selectedTraversal,
                        onChanged: (value) =>
                            setState(() => selectedTraversal = value!),
                        items: ['Inorder', 'Preorder', 'Postorder']
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        dropdownColor: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _performTraversal,
                    icon: Icon(Icons.play_arrow),
                    label: Text('Start Traversal'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text('Tree Structure:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 10),
                  Center(child: _buildTree()),
                  SizedBox(height: 20),
                  Text('Traversal Result:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    children: traversalResult
                        .map((e) => Chip(
                              label: Text(e,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              backgroundColor:
                                  Colors.deepPurpleAccent.withOpacity(0.2),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
