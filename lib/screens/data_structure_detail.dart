// 📁 data_structure_detail.dart

import 'package:flutter/material.dart';

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
  final _inputController = TextEditingController();
  final _indexController = TextEditingController();

  List<String> array = [], stack = [], queue = [], linkedList = [], tree = [];
  Map<String, List<String>> graph = {};
  Map<String, String> hashTable = {};
  List<int> heap = [];
  bool isMinHeap = true;

  void _clearControllers() {
    _inputController.clear();
    _indexController.clear();
  }

  // ------------------ ARRAY ------------------
  void _arrayPushBack() {
    if (_inputController.text.trim().isEmpty) return;
    setState(() => array.add(_inputController.text.trim()));
    _clearControllers();
  }

  void _arrayInsertAt() {
    int? index = int.tryParse(_indexController.text.trim());
    String value = _inputController.text.trim();
    if (index == null || index < 0 || index > array.length || value.isEmpty)
      return;
    setState(() => array.insert(index, value));
    _clearControllers();
  }

  void _arrayDeleteAt() {
    int? index = int.tryParse(_indexController.text.trim());
    if (index == null || index < 0 || index >= array.length) return;
    setState(() => array.removeAt(index));
    _clearControllers();
  }

  void _arrayUpdateAt() {
    int? index = int.tryParse(_indexController.text.trim());
    String value = _inputController.text.trim();
    if (index == null || index < 0 || index >= array.length || value.isEmpty)
      return;
    setState(() => array[index] = value);
    _clearControllers();
  }

  // ------------------ STACK ------------------
  void _stackPush() {
    if (_inputController.text.trim().isEmpty) return;
    setState(() => stack.add(_inputController.text.trim()));
    _clearControllers();
  }

  void _stackPop() {
    if (stack.isNotEmpty) setState(() => stack.removeLast());
  }

  // ------------------ QUEUE ------------------
  void _queueEnqueue() {
    if (_inputController.text.trim().isEmpty) return;
    setState(() => queue.add(_inputController.text.trim()));
    _clearControllers();
  }

  void _queueDequeue() {
    if (queue.isNotEmpty) setState(() => queue.removeAt(0));
  }

  // ------------------ LINKED LIST ------------------
  void _linkedListAdd() {
    if (_inputController.text.trim().isEmpty) return;
    setState(() => linkedList.add(_inputController.text.trim()));
    _clearControllers();
  }

  void _linkedListDelete() {
    if (linkedList.isNotEmpty) setState(() => linkedList.removeLast());
  }

  // ------------------ TREE ------------------
  void _treeAdd() {
    if (_inputController.text.trim().isEmpty) return;
    setState(() => tree.add(_inputController.text.trim()));
    _clearControllers();
  }

  // ------------------ GRAPH ------------------
  void _addGraphNode(String node) {
    if (node.isEmpty || graph.containsKey(node)) return;
    setState(() => graph[node] = []);
    _clearControllers();
  }

  void _addGraphEdge(String from, String to) {
    if (!graph.containsKey(from) || !graph.containsKey(to)) return;
    setState(() => graph[from]!.add(to));
    _clearControllers();
  }

  // ------------------ HASH TABLE ------------------
  void _insertHash() {
    final key = _inputController.text.trim();
    final val = _indexController.text.trim();
    if (key.isEmpty || val.isEmpty) return;
    setState(() => hashTable[key] = val);
    _clearControllers();
  }

  void _deleteHash() {
    final key = _inputController.text.trim();
    if (hashTable.containsKey(key)) {
      setState(() => hashTable.remove(key));
    }
    _clearControllers();
  }

  // ------------------ HEAP ------------------
  void _insertHeap() {
    final val = int.tryParse(_inputController.text.trim());
    if (val == null) return;
    setState(() {
      heap.add(val);
      _heapifyUp();
    });
    _inputController.clear();
  }

  void _deleteHeap() {
    if (heap.isEmpty) return;
    setState(() {
      heap[0] = heap.removeLast();
      _heapifyDown();
    });
  }

  void _heapifyUp() {
    int index = heap.length - 1;
    while (index > 0) {
      int parent = (index - 1) ~/ 2;
      bool condition =
          isMinHeap ? heap[index] < heap[parent] : heap[index] > heap[parent];
      if (!condition) break;
      heap[index] = heap[parent];
      heap[parent] = heap[index] + heap[parent] - heap[index]; // swap
      index = parent;
    }
  }

  void _heapifyDown() {
    int index = 0;
    while (index * 2 + 1 < heap.length) {
      int child = index * 2 + 1;
      if (child + 1 < heap.length) {
        if ((isMinHeap && heap[child + 1] < heap[child]) ||
            (!isMinHeap && heap[child + 1] > heap[child])) {
          child++;
        }
      }
      bool condition =
          isMinHeap ? heap[child] < heap[index] : heap[child] > heap[index];
      if (!condition) break;
      heap[index] = heap[child] + heap[index] - (heap[child] = heap[index]);
      index = child;
    }
  }

  // ------------------ Visualizers ------------------
  Widget _buildBoxedList(List<String> items,
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

  List<Widget> _buildBoxes(List<String> items, bool arrow) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(Container(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[100], borderRadius: BorderRadius.circular(8)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(items[i], style: TextStyle(fontSize: 16)),
          Text('[$i]', style: TextStyle(color: Colors.grey[700])),
        ]),
      ));
      if (arrow && i != items.length - 1)
        widgets.add(Icon(Icons.arrow_forward));
    }
    return widgets;
  }

  Widget _buildVisualizer() {
    switch (selectedStructure) {
      case 'Array':
        return _buildBoxedList(array, horizontal: true);
      case 'Stack':
        return _buildBoxedList(stack, reverse: true);
      case 'Queue':
        return _buildBoxedList(queue);
      case 'Linked List':
        return _buildBoxedList(linkedList, horizontal: true, arrow: true);
      case 'Tree':
        return _buildBoxedList(tree, horizontal: true);
      case 'Graph':
        return Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8)),
            child: graph.isEmpty
                ? Center(child: Text('Graph is empty'))
                : ListView(
                    children: graph.entries
                        .map((e) => Text('${e.key} → ${e.value.join(', ')}'))
                        .toList(),
                  ),
          ),
        );
      case 'Hash Table':
        return Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8)),
            child: hashTable.isEmpty
                ? Center(child: Text('Hash Table is empty'))
                : ListView(
                    children: hashTable.entries
                        .map((e) => ListTile(
                              title: Text('Key: ${e.key}'),
                              subtitle: Text('Value: ${e.value}'),
                            ))
                        .toList(),
                  ),
          ),
        );
      case 'Heap':
        return Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8)),
            child: heap.isEmpty
                ? Center(child: Text('Heap is empty'))
                : Wrap(
                    spacing: 10,
                    children: heap
                        .asMap()
                        .entries
                        .map(
                            (e) => Chip(label: Text('${e.value} (i:${e.key})')))
                        .toList(),
                  ),
          ),
        );
      default:
        return Expanded(child: Center(child: Text('No visualizer')));
    }
  }

  Widget _buildControls() {
    switch (selectedStructure) {
      case 'Array':
        return _arrayControls();
      case 'Stack':
        return _wrapButtons(['Push', 'Pop'], [_stackPush, _stackPop]);
      case 'Queue':
        return _wrapButtons(
            ['Enqueue', 'Dequeue'], [_queueEnqueue, _queueDequeue]);
      case 'Linked List':
        return _wrapButtons(
            ['Add Node', 'Delete Last'], [_linkedListAdd, _linkedListDelete]);
      case 'Tree':
        return _wrapButtons(['Add Node'], [_treeAdd]);
      case 'Graph':
        return Column(children: [
          _doubleInput('Node / From', 'To'),
          _wrapButtons([
            'Add Node',
            'Add Edge'
          ], [
            () => _addGraphNode(_inputController.text.trim()),
            () => _addGraphEdge(
                _inputController.text.trim(), _indexController.text.trim())
          ])
        ]);
      case 'Hash Table':
        return Column(children: [
          _doubleInput('Key', 'Value'),
          _wrapButtons(['Insert', 'Delete'], [_insertHash, _deleteHash])
        ]);
      case 'Heap':
        return Column(children: [
          SwitchListTile(
              value: isMinHeap,
              onChanged: (v) => setState(() => isMinHeap = v),
              title: Text('Min Heap')),
          _inputField('Value'),
          _wrapButtons(['Insert', 'Delete Root'], [_insertHeap, _deleteHeap])
        ]);
      default:
        return SizedBox();
    }
  }

  Widget _inputField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: _inputController,
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
      ),
    );
  }

  Widget _doubleInput(String label1, String label2) {
    return Row(
      children: [
        Expanded(child: _inputField(label1)),
        SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _indexController,
            decoration: InputDecoration(
                labelText: label2, border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }

  Widget _arrayControls() {
    return Column(
      children: [
        _doubleInput('Value', 'Index'),
        _wrapButtons(['Push Back', 'Insert At', 'Delete At', 'Update At'],
            [_arrayPushBack, _arrayInsertAt, _arrayDeleteAt, _arrayUpdateAt]),
      ],
    );
  }

  Widget _wrapButtons(List<String> labels, List<VoidCallback> actions) {
    return Wrap(
      spacing: 10,
      children: List.generate(
        labels.length,
        (i) => ElevatedButton(onPressed: actions[i], child: Text(labels[i])),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Structure Visualizer')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButton<String>(
                value: selectedStructure,
                isExpanded: true,
                items: structures
                    .map(
                        (str) => DropdownMenuItem(value: str, child: Text(str)))
                    .toList(),
                onChanged: (val) => setState(() {
                  selectedStructure = val!;
                  _clearControllers();
                }),
              ),
            ),
            Expanded(
              child: Card(
                margin: EdgeInsets.all(16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$selectedStructure Visualizer',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      _buildVisualizer(),
                      SizedBox(height: 12),
                      _buildControls(),
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
}
