import 'package:flutter/material.dart';
import 'dart:math';

class TreeNode {
  String value;
  TreeNode? left;
  TreeNode? right;
  TreeNode(this.value);
}

class DataStructureDetailScreen extends StatefulWidget {
  @override
  _DataStructureDetailScreenState createState() =>
      _DataStructureDetailScreenState();
}

class _DataStructureDetailScreenState extends State<DataStructureDetailScreen> {
  final List<String> structures = [
    'Array',
    'Stack',
    'Queue',
    'Linked List',
    'Tree',
    'Graph',
    'Hash Table',
    'Heap',
  ];

  String selectedStructure = 'Array';

  // Data structures
  List<String> array = [];
  List<String> stack = [];
  List<String> queue = [];
  List<String> linkedList = [];
  TreeNode? root;
  Map<String, List<String>> graph = {};
  Map<String, String> hashTable = {};
  List<int> heap = [];
  bool isMinHeap = true;

  // Controllers
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _indexController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();

  // Result displays
  String result = '';
  String treeTraversalResult = '';

  void _clearControllers() {
    _valueController.clear();
    _indexController.clear();
    _keyController.clear();
  }

  void _clearAll() {
    setState(() {
      array.clear();
      stack.clear();
      queue.clear();
      linkedList.clear();
      root = null;
      graph.clear();
      hashTable.clear();
      heap.clear();
      result = '';
      treeTraversalResult = '';
    });
  }

  // Array Operations
  void _arrayAdd() {
    if (_valueController.text.trim().isEmpty) return;
    setState(() {
      array.add(_valueController.text.trim());
      result = 'Added "${_valueController.text.trim()}" to array';
    });
    _clearControllers();
  }

  void _arrayInsertAt() {
    int? index = int.tryParse(_indexController.text.trim());
    String value = _valueController.text.trim();
    if (index == null || index < 0 || index > array.length || value.isEmpty)
      return;
    setState(() {
      array.insert(index, value);
      result = 'Inserted "$value" at index $index';
    });
    _clearControllers();
  }

  void _arrayDeleteAt() {
    int? index = int.tryParse(_indexController.text.trim());
    if (index == null || index < 0 || index >= array.length) return;
    String deleted = array[index];
    setState(() {
      array.removeAt(index);
      result = 'Deleted "$deleted" from index $index';
    });
    _clearControllers();
  }

  // Stack Operations
  void _stackPush() {
    if (_valueController.text.trim().isEmpty) return;
    setState(() {
      stack.add(_valueController.text.trim());
      result = 'Pushed "${_valueController.text.trim()}" to stack';
    });
    _clearControllers();
  }

  void _stackPop() {
    if (stack.isNotEmpty) {
      String popped = stack.last;
      setState(() {
        stack.removeLast();
        result = 'Popped "$popped" from stack';
      });
    } else {
      setState(() => result = 'Stack is empty');
    }
  }

  // Queue Operations
  void _queueEnqueue() {
    if (_valueController.text.trim().isEmpty) return;
    setState(() {
      queue.add(_valueController.text.trim());
      result = 'Enqueued "${_valueController.text.trim()}" to queue';
    });
    _clearControllers();
  }

  void _queueDequeue() {
    if (queue.isNotEmpty) {
      String dequeued = queue.first;
      setState(() {
        queue.removeAt(0);
        result = 'Dequeued "$dequeued" from queue';
      });
    } else {
      setState(() => result = 'Queue is empty');
    }
  }

  // Linked List Operations
  void _linkedListAdd() {
    if (_valueController.text.trim().isEmpty) return;
    setState(() {
      linkedList.add(_valueController.text.trim());
      result = 'Added "${_valueController.text.trim()}" to linked list';
    });
    _clearControllers();
  }

  void _linkedListInsertAt() {
    int? index = int.tryParse(_indexController.text.trim());
    String value = _valueController.text.trim();
    if (index == null ||
        index < 0 ||
        index > linkedList.length ||
        value.isEmpty) return;
    setState(() {
      linkedList.insert(index, value);
      result = 'Inserted "$value" at index $index';
    });
    _clearControllers();
  }

  // Tree Operations
  void _treeInsert() {
    String value = _valueController.text.trim();
    if (value.isEmpty) return;
    setState(() {
      root = _insertTreeNode(root, value);
      result = 'Inserted "$value" into tree';
    });
    _clearControllers();
  }

  TreeNode _insertTreeNode(TreeNode? node, String value) {
    if (node == null) return TreeNode(value);
    if (value.compareTo(node.value) < 0) {
      node.left = _insertTreeNode(node.left, value);
    } else if (value.compareTo(node.value) > 0) {
      node.right = _insertTreeNode(node.right, value);
    }
    return node;
  }

  void _treeInOrder() {
    List<String> result = [];
    _inOrderTraversal(root, result);
    setState(() {
      treeTraversalResult =
          'In-Order: ${result.isEmpty ? "Tree is empty" : result.join(' → ')}';
    });
  }

  void _inOrderTraversal(TreeNode? node, List<String> result) {
    if (node == null) return;
    _inOrderTraversal(node.left, result);
    result.add(node.value);
    _inOrderTraversal(node.right, result);
  }

  void _treePreOrder() {
    List<String> result = [];
    _preOrderTraversal(root, result);
    setState(() {
      treeTraversalResult =
          'Pre-Order: ${result.isEmpty ? "Tree is empty" : result.join(' → ')}';
    });
  }

  void _preOrderTraversal(TreeNode? node, List<String> result) {
    if (node == null) return;
    result.add(node.value); // Visit root first
    _preOrderTraversal(node.left, result); // Then left subtree
    _preOrderTraversal(node.right, result); // Then right subtree
  }

  void _treePostOrder() {
    List<String> result = [];
    _postOrderTraversal(root, result);
    setState(() {
      treeTraversalResult =
          'Post-Order: ${result.isEmpty ? "Tree is empty" : result.join(' → ')}';
    });
  }

  void _postOrderTraversal(TreeNode? node, List<String> result) {
    if (node == null) return;
    _postOrderTraversal(node.left, result); // Visit left subtree first
    _postOrderTraversal(node.right, result); // Then right subtree
    result.add(node.value); // Finally visit root
  }

  void _treeLevelOrder() {
    List<String> result = [];
    _levelOrderTraversal(result);
    setState(() {
      treeTraversalResult =
          'Level-Order: ${result.isEmpty ? "Tree is empty" : result.join(' → ')}';
    });
  }

  void _levelOrderTraversal(List<String> result) {
    if (root == null) return;

    List<TreeNode> queue = [root!]; // Use a queue for level-order traversal

    while (queue.isNotEmpty) {
      TreeNode currentNode = queue.removeAt(0); // Dequeue
      result.add(currentNode.value); // Visit current node

      // Add children to queue
      if (currentNode.left != null) queue.add(currentNode.left!);
      if (currentNode.right != null) queue.add(currentNode.right!);
    }
  }

  // Graph Operations
  void _graphAddNode() {
    String node = _valueController.text.trim();
    if (node.isEmpty || graph.containsKey(node)) return;
    setState(() {
      graph[node] = [];
      result = 'Added node "$node" to graph';
    });
    _clearControllers();
  }

  void _graphAddEdge() {
    String from = _valueController.text.trim();
    String to = _indexController.text.trim();
    if (!graph.containsKey(from) || !graph.containsKey(to)) return;
    setState(() {
      graph[from]!.add(to);
      result = 'Added edge from "$from" to "$to"';
    });
    _clearControllers();
  }

  // Hash Table Operations
  void _hashInsert() {
    final key = _valueController.text.trim();
    final val = _indexController.text.trim();
    if (key.isEmpty || val.isEmpty) return;
    setState(() {
      hashTable[key] = val;
      result = 'Inserted "$key" → "$val"';
    });
    _clearControllers();
  }

  void _hashDelete() {
    final key = _valueController.text.trim();
    if (hashTable.containsKey(key)) {
      setState(() {
        hashTable.remove(key);
        result = 'Deleted key "$key"';
      });
    } else {
      setState(() => result = 'Key "$key" not found');
    }
    _clearControllers();
  }

  // Heap Operations
  void _heapInsert() {
    final val = int.tryParse(_valueController.text.trim());
    if (val == null) return;
    setState(() {
      heap.add(val);
      _heapifyUp(heap.length - 1);
      result = 'Inserted $val into ${isMinHeap ? "min" : "max"} heap';
    });
    _clearControllers();
  }

  void _heapDeleteRoot() {
    if (heap.isEmpty) return;
    int deletedValue = heap[0];
    setState(() {
      if (heap.length == 1) {
        heap.clear();
      } else {
        heap[0] = heap.removeLast();
        _heapifyDown(0);
      }
      result = 'Deleted root element: $deletedValue';
    });
  }

  void _heapifyUp(int index) {
    while (index > 0) {
      int parent = (index - 1) ~/ 2;
      bool condition =
          isMinHeap ? heap[index] < heap[parent] : heap[index] > heap[parent];
      if (!condition) break;
      _swap(heap, index, parent);
      index = parent;
    }
  }

  void _heapifyDown(int index) {
    int length = heap.length;
    while (index < length) {
      int left = 2 * index + 1;
      int right = 2 * index + 2;
      int swapIndex = index;

      if (left < length &&
          (isMinHeap
              ? heap[left] < heap[swapIndex]
              : heap[left] > heap[swapIndex])) {
        swapIndex = left;
      }

      if (right < length &&
          (isMinHeap
              ? heap[right] < heap[swapIndex]
              : heap[right] > heap[swapIndex])) {
        swapIndex = right;
      }

      if (swapIndex == index) break;

      _swap(heap, index, swapIndex);
      index = swapIndex;
    }
  }

  void _swap(List<int> list, int i, int j) {
    int temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }

  // Visualizer Widgets
  Widget _buildVisualizer() {
    switch (selectedStructure) {
      case 'Array':
        return _buildListVisualizer(array, 'Array', horizontal: true);
      case 'Stack':
        return _buildListVisualizer(stack, 'Stack', reverse: true);
      case 'Queue':
        return _buildListVisualizer(queue, 'Queue', horizontal: true);
      case 'Linked List':
        return _buildListVisualizer(linkedList, 'Linked List',
            horizontal: true, arrow: true);
      case 'Tree':
        return _buildTreeVisualizer();
      case 'Graph':
        return _buildGraphVisualizer();
      case 'Hash Table':
        return _buildHashVisualizer();
      case 'Heap':
        return _buildHeapVisualizer();
      default:
        return Container();
    }
  }

  Widget _buildListVisualizer(List<String> items, String type,
      {bool reverse = false, bool horizontal = false, bool arrow = false}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: items.isEmpty
            ? Center(
                child: Text('$type is empty',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])))
            : horizontal
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _buildItemBoxes(items, arrow),
                    ),
                  )
                : ListView(
                    reverse: reverse,
                    children: _buildItemBoxes(items, arrow),
                  ),
      ),
    );
  }

  List<Widget> _buildItemBoxes(List<String> items, bool arrow) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue[300]!),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(items[i],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            Text('[$i]',
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ));
      if (arrow && i != items.length - 1) {
        widgets.add(Icon(Icons.arrow_forward, color: Colors.blue[600]));
      }
    }
    return widgets;
  }

  Widget _buildTreeVisualizer() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (treeTraversalResult.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(treeTraversalResult, textAlign: TextAlign.center),
              ),
            Expanded(
              child: root == null
                  ? Center(
                      child: Text('Tree is empty',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600])))
                  : SingleChildScrollView(child: _buildTreeNode(root)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeNode(TreeNode? node) {
    if (node == null) return SizedBox.shrink();
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue[700]!, width: 2),
            ),
            child: Text(
              node.value,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          if (node.left != null || node.right != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (node.left != null)
                  Expanded(child: _buildTreeNode(node.left))
                else
                  Expanded(child: SizedBox()),
                if (node.right != null)
                  Expanded(child: _buildTreeNode(node.right))
                else
                  Expanded(child: SizedBox()),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildGraphVisualizer() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: graph.isEmpty
            ? Center(
                child: Text('Graph is empty',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])))
            : ListView(
                children: graph.entries
                    .map((e) => Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Text('${e.key} → [${e.value.join(', ')}]'),
                        ))
                    .toList(),
              ),
      ),
    );
  }

  Widget _buildHashVisualizer() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: hashTable.isEmpty
            ? Center(
                child: Text('Hash Table is empty',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])))
            : ListView(
                children: hashTable.entries
                    .map((e) => Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text('Key: ${e.key}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600))),
                              Expanded(child: Text('Value: ${e.value}')),
                            ],
                          ),
                        ))
                    .toList(),
              ),
      ),
    );
  }

  Widget _buildHeapVisualizer() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: heap.isEmpty
            ? Center(
                child: Text('Heap is empty',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.2,
                ),
                itemCount: heap.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: index == 0 ? Colors.red[200] : Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            index == 0 ? Colors.red[400]! : Colors.blue[300]!,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${heap[index]}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('[i:$index]',
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[600])),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildControls() {
    switch (selectedStructure) {
      case 'Array':
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                        controller: _valueController,
                        decoration: InputDecoration(
                            labelText: 'Value', border: OutlineInputBorder()))),
                SizedBox(width: 8),
                Expanded(
                    child: TextField(
                        controller: _indexController,
                        decoration: InputDecoration(
                            labelText: 'Index', border: OutlineInputBorder()),
                        keyboardType: TextInputType.number)),
              ],
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(onPressed: _arrayAdd, child: Text('Add')),
                ElevatedButton(
                    onPressed: _arrayInsertAt, child: Text('Insert At')),
                ElevatedButton(
                    onPressed: _arrayDeleteAt, child: Text('Delete At')),
                ElevatedButton(onPressed: _clearAll, child: Text('Clear')),
              ],
            ),
          ],
        );
      case 'Stack':
        return Column(
          children: [
            TextField(
                controller: _valueController,
                decoration: InputDecoration(
                    labelText: 'Value', border: OutlineInputBorder())),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(onPressed: _stackPush, child: Text('Push')),
                ElevatedButton(onPressed: _stackPop, child: Text('Pop')),
                ElevatedButton(onPressed: _clearAll, child: Text('Clear')),
              ],
            ),
          ],
        );
      case 'Queue':
        return Column(
          children: [
            TextField(
                controller: _valueController,
                decoration: InputDecoration(
                    labelText: 'Value', border: OutlineInputBorder())),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                    onPressed: _queueEnqueue, child: Text('Enqueue')),
                ElevatedButton(
                    onPressed: _queueDequeue, child: Text('Dequeue')),
                ElevatedButton(onPressed: _clearAll, child: Text('Clear')),
              ],
            ),
          ],
        );
      case 'Linked List':
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                        controller: _valueController,
                        decoration: InputDecoration(
                            labelText: 'Value', border: OutlineInputBorder()))),
                SizedBox(width: 8),
                Expanded(
                    child: TextField(
                        controller: _indexController,
                        decoration: InputDecoration(
                            labelText: 'Index', border: OutlineInputBorder()),
                        keyboardType: TextInputType.number)),
              ],
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(onPressed: _linkedListAdd, child: Text('Add')),
                ElevatedButton(
                    onPressed: _linkedListInsertAt, child: Text('Insert At')),
                ElevatedButton(onPressed: _clearAll, child: Text('Clear')),
              ],
            ),
          ],
        );
      case 'Tree':
        return Column(
          children: [
            TextField(
                controller: _valueController,
                decoration: InputDecoration(
                    labelText: 'Value', border: OutlineInputBorder())),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                    onPressed: _treeInOrder, child: Text('In-Order')),
                ElevatedButton(
                    onPressed: _treePreOrder, child: Text('Pre-Order')),
                ElevatedButton(
                    onPressed: _treePostOrder, child: Text('Post-Order')),
                ElevatedButton(
                    onPressed: _treeLevelOrder, child: Text('Level-Order')),
                ElevatedButton(onPressed: _clearAll, child: Text('Clear')),
              ],
            ),
          ],
        );
      case 'Graph':
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                        controller: _valueController,
                        decoration: InputDecoration(
                            labelText: 'From Node',
                            border: OutlineInputBorder()))),
                SizedBox(width: 8),
                Expanded(
                    child: TextField(
                        controller: _indexController,
                        decoration: InputDecoration(
                            labelText: 'To Node',
                            border: OutlineInputBorder()))),
              ],
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                    onPressed: _graphAddNode, child: Text('Add Node')),
                ElevatedButton(
                    onPressed: _graphAddEdge, child: Text('Add Edge')),
                ElevatedButton(onPressed: _clearAll, child: Text('Clear')),
              ],
            ),
          ],
        );
      case 'Hash Table':
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                        controller: _valueController,
                        decoration: InputDecoration(
                            labelText: 'Key', border: OutlineInputBorder()))),
                SizedBox(width: 8),
                Expanded(
                    child: TextField(
                        controller: _indexController,
                        decoration: InputDecoration(
                            labelText: 'Value', border: OutlineInputBorder()))),
              ],
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(onPressed: _hashInsert, child: Text('Insert')),
                ElevatedButton(onPressed: _hashDelete, child: Text('Delete')),
                ElevatedButton(onPressed: _clearAll, child: Text('Clear')),
              ],
            ),
          ],
        );
      case 'Heap':
        return Column(
          children: [
            SwitchListTile(
              value: isMinHeap,
              onChanged: (v) => setState(() => isMinHeap = v),
              title: Text('Min Heap (unchecked = Max Heap)'),
            ),
            TextField(
                controller: _valueController,
                decoration: InputDecoration(
                    labelText: 'Value (numbers only)',
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(onPressed: _heapInsert, child: Text('Insert')),
                ElevatedButton(
                    onPressed: _heapDeleteRoot, child: Text('Delete Root')),
                ElevatedButton(onPressed: _clearAll, child: Text('Clear')),
              ],
            ),
          ],
        );
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Structure Visualizer'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Dropdown Selection
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
              ),
              child: DropdownButton<String>(
                value: selectedStructure,
                isExpanded: true,
                items: structures
                    .map((str) => DropdownMenuItem(
                        value: str,
                        child: Text(str, style: TextStyle(fontSize: 16))))
                    .toList(),
                onChanged: (val) => setState(() {
                  selectedStructure = val!;
                  _clearControllers();
                  result = '';
                  treeTraversalResult = '';
                }),
              ),
            ),

            // Result Display
            if (result.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Text(result,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center),
              ),

            // Visualizer
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: _buildVisualizer(),
              ),
            ),

            // Controls
            Container(
              padding: EdgeInsets.all(16),
              child: _buildControls(),
            ),
          ],
        ),
      ),
    );
  }
}
