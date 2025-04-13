// // stack_queue_screen.dart
// import 'package:flutter/material.dart';

// class StackQueueScreen extends StatefulWidget {
//   @override
//   _StackQueueScreenState createState() => _StackQueueScreenState();
// }

// class _StackQueueScreenState extends State<StackQueueScreen> {
//   List<String> stack = [];
//   List<String> queue = [];
//   TextEditingController controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Stack & Queue Simulator')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: controller,
//               decoration: InputDecoration(labelText: 'Enter value'),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                     onPressed: _pushStack, child: Text('Push Stack')),
//                 ElevatedButton(onPressed: _popStack, child: Text('Pop Stack')),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(onPressed: _enqueue, child: Text('Enqueue')),
//                 ElevatedButton(onPressed: _dequeue, child: Text('Dequeue')),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text('Stack:', style: TextStyle(fontWeight: FontWeight.bold)),
//             Wrap(
//               children: stack.map((e) => Chip(label: Text(e))).toList(),
//             ),
//             SizedBox(height: 10),
//             Text('Queue:', style: TextStyle(fontWeight: FontWeight.bold)),
//             Wrap(
//               children: queue.map((e) => Chip(label: Text(e))).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _pushStack() {
//     if (controller.text.isNotEmpty) {
//       setState(() {
//         stack.add(controller.text);
//         controller.clear();
//       });
//     }
//   }

//   void _popStack() {
//     if (stack.isNotEmpty) {
//       setState(() {
//         stack.removeLast();
//       });
//     }
//   }

//   void _enqueue() {
//     if (controller.text.isNotEmpty) {
//       setState(() {
//         queue.add(controller.text);
//         controller.clear();
//       });
//     }
//   }

//   void _dequeue() {
//     if (queue.isNotEmpty) {
//       setState(() {
//         queue.removeAt(0);
//       });
//     }
//   }
// }

// stack_queue_screen.dart
import 'package:flutter/material.dart';

class StackQueueScreen extends StatefulWidget {
  @override
  _StackQueueScreenState createState() => _StackQueueScreenState();
}

class _StackQueueScreenState extends State<StackQueueScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> stack = [];
  List<String> queue = [];
  String structure = 'Stack';
  String operation = 'Push';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack & Queue Simulator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter value',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: structure,
                    onChanged: (value) => setState(() => structure = value!),
                    items: ['Stack', 'Queue']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: operation,
                    onChanged: (value) => setState(() => operation = value!),
                    items: ['Push', 'Pop', 'Enqueue', 'Dequeue']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _performOperation,
              child: Text('Start Operation'),
            ),
            SizedBox(height: 20),
            Text('Stack:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              children: stack.map((e) => Chip(label: Text(e))).toList(),
            ),
            SizedBox(height: 10),
            Text('Queue:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              children: queue.map((e) => Chip(label: Text(e))).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _performOperation() {
    final value = _controller.text;
    if (value.isEmpty && (operation == 'Push' || operation == 'Enqueue'))
      return;

    setState(() {
      if (structure == 'Stack') {
        if (operation == 'Push') {
          stack.add(value);
        } else if (operation == 'Pop' && stack.isNotEmpty) {
          stack.removeLast();
        }
      } else {
        if (operation == 'Enqueue') {
          queue.add(value);
        } else if (operation == 'Dequeue' && queue.isNotEmpty) {
          queue.removeAt(0);
        }
      }
      _controller.clear();
    });
  }
}
