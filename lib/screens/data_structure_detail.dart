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

class _DataStructureDetailScreenState extends State<DataStructureDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _valueController.dispose();
    _indexController.dispose();
    _keyController.dispose();
    super.dispose();
  }

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

    // Show feedback with animation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.cleaning_services, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('All data cleared successfully!'),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 2),
      ),
    );
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
    result.add(node.value);
    _preOrderTraversal(node.left, result);
    _preOrderTraversal(node.right, result);
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
    _postOrderTraversal(node.left, result);
    _postOrderTraversal(node.right, result);
    result.add(node.value);
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
    List<TreeNode> queue = [root!];
    while (queue.isNotEmpty) {
      TreeNode currentNode = queue.removeAt(0);
      result.add(currentNode.value);
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

  // Enhanced Icon for each data structure
  IconData _getStructureIcon(String structure) {
    switch (structure) {
      case 'Array':
        return Icons.view_list_outlined;
      case 'Stack':
        return Icons.layers_outlined;
      case 'Queue':
        return Icons.queue_outlined;
      case 'Linked List':
        return Icons.link_outlined;
      case 'Tree':
        return Icons.account_tree_outlined;
      case 'Graph':
        return Icons.hub_outlined;
      case 'Hash Table':
        return Icons.table_chart_outlined;
      case 'Heap':
        return Icons.trending_up_outlined;
      default:
        return Icons.data_usage_outlined;
    }
  }

  // Enhanced Visualizer Widgets
  Widget _buildVisualizer() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                // Header with icon and title
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getStructureIcon(selectedStructure),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          '$selectedStructure Visualizer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (result.isNotEmpty)
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Updated',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Visualization content
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: _buildVisualizationContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisualizationContent() {
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
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getStructureIcon(type),
                size: 48,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '$type is empty',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
            ),
            SizedBox(height: 8),
            Text(
              'Add some elements to see the visualization',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
            ),
          ],
        ),
      );
    }

    return horizontal
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildItemBoxes(items, arrow),
            ),
          )
        : ListView(
            reverse: reverse,
            children: _buildItemBoxes(items, arrow),
          );
  }

  List<Widget> _buildItemBoxes(List<String> items, bool arrow) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.all(6),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                items[i],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '[$i]',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      if (arrow && i != items.length - 1) {
        widgets.add(
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.arrow_forward_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
        );
      }
    }
    return widgets;
  }

  Widget _buildTreeVisualizer() {
    return Column(
      children: [
        if (treeTraversalResult.isNotEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              ),
            ),
            child: Text(
              treeTraversalResult,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        Expanded(
          child: root == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.account_tree_outlined,
                          size: 48,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.6),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Tree is empty',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.6),
                                ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(child: _buildTreeNode(root)),
        ),
      ],
    );
  }

  Widget _buildTreeNode(TreeNode? node) {
    if (node == null) return SizedBox.shrink();
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              node.value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
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
    if (graph.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.hub_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Graph is empty',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView(
      children: graph.entries
          .map((e) => Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .shadow
                          .withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        e.key,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '[${e.value.join(', ')}]',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildHashVisualizer() {
    if (hashTable.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.table_chart_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Hash Table is empty',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView(
      children: hashTable.entries
          .map((e) => Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .shadow
                          .withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Key',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                    .withOpacity(0.7),
                              ),
                            ),
                            Text(
                              e.key,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Value',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer
                                    .withOpacity(0.7),
                              ),
                            ),
                            Text(
                              e.value,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildHeapVisualizer() {
    if (heap.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.trending_up_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Heap is empty',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: heap.length,
      itemBuilder: (context, index) {
        bool isRoot = index == 0;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isRoot
                  ? [
                      Theme.of(context).colorScheme.error,
                      Theme.of(context).colorScheme.error.withOpacity(0.7),
                    ]
                  : [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.7),
                    ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isRoot
                  ? Theme.of(context).colorScheme.error.withOpacity(0.5)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isRoot
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary)
                    .withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${heap[index]}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isRoot
                      ? Colors.white
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: (isRoot
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary)
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '[i:$index]',
                  style: TextStyle(
                    fontSize: 10,
                    color: isRoot
                        ? Colors.white.withOpacity(0.8)
                        : Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildControls() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20),
          _buildControlsContent(),
        ],
      ),
    );
  }

  Widget _buildControlsContent() {
    switch (selectedStructure) {
      case 'Array':
        return _buildArrayControls();
      case 'Stack':
        return _buildStackControls();
      case 'Queue':
        return _buildQueueControls();
      case 'Linked List':
        return _buildLinkedListControls();
      case 'Tree':
        return _buildTreeControls();
      case 'Graph':
        return _buildGraphControls();
      case 'Hash Table':
        return _buildHashControls();
      case 'Heap':
        return _buildHeapControls();
      default:
        return SizedBox();
    }
  }

  Widget _buildArrayControls() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStyledTextField(
                controller: _valueController,
                label: 'Value',
                icon: Icons.text_fields,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildStyledTextField(
                controller: _indexController,
                label: 'Index',
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildActionButtons([
          _ActionButton('Add', Icons.add, _arrayAdd,
              Theme.of(context).colorScheme.primary),
          _ActionButton('Insert At', Icons.insert_drive_file, _arrayInsertAt,
              Theme.of(context).colorScheme.secondary),
          _ActionButton('Delete At', Icons.delete, _arrayDeleteAt,
              Theme.of(context).colorScheme.error),
          _ActionButton('Clear', Icons.clear_all, _clearAll,
              Theme.of(context).colorScheme.outline),
        ]),
      ],
    );
  }

  Widget _buildStackControls() {
    return Column(
      children: [
        _buildStyledTextField(
          controller: _valueController,
          label: 'Value',
          icon: Icons.layers,
        ),
        SizedBox(height: 16),
        _buildActionButtons([
          _ActionButton('Push', Icons.arrow_upward, _stackPush,
              Theme.of(context).colorScheme.primary),
          _ActionButton('Pop', Icons.arrow_downward, _stackPop,
              Theme.of(context).colorScheme.secondary),
          _ActionButton('Clear', Icons.clear_all, _clearAll,
              Theme.of(context).colorScheme.outline),
        ]),
      ],
    );
  }

  Widget _buildQueueControls() {
    return Column(
      children: [
        _buildStyledTextField(
          controller: _valueController,
          label: 'Value',
          icon: Icons.queue,
        ),
        SizedBox(height: 16),
        _buildActionButtons([
          _ActionButton('Enqueue', Icons.arrow_forward, _queueEnqueue,
              Theme.of(context).colorScheme.primary),
          _ActionButton('Dequeue', Icons.arrow_back, _queueDequeue,
              Theme.of(context).colorScheme.secondary),
          _ActionButton('Clear', Icons.clear_all, _clearAll,
              Theme.of(context).colorScheme.outline),
        ]),
      ],
    );
  }

  Widget _buildLinkedListControls() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStyledTextField(
                controller: _valueController,
                label: 'Value',
                icon: Icons.link,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildStyledTextField(
                controller: _indexController,
                label: 'Index',
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildActionButtons([
          _ActionButton('Add', Icons.add, _linkedListAdd,
              Theme.of(context).colorScheme.primary),
          _ActionButton('Insert At', Icons.insert_drive_file,
              _linkedListInsertAt, Theme.of(context).colorScheme.secondary),
          _ActionButton('Clear', Icons.clear_all, _clearAll,
              Theme.of(context).colorScheme.outline),
        ]),
      ],
    );
  }

  Widget _buildTreeControls() {
    return Column(
      children: [
        _buildStyledTextField(
          controller: _valueController,
          label: 'Tree Value',
          icon: Icons.account_tree,
        ),
        SizedBox(height: 16),
        _buildActionButtons([
          _ActionButton('Insert', Icons.add, _treeInsert,
              Theme.of(context).colorScheme.primary),
          _ActionButton('Clear', Icons.clear_all, _clearAll,
              Theme.of(context).colorScheme.outline),
        ]),
        SizedBox(height: 16),
        Text(
          'Traversals',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        SizedBox(height: 12),
        _buildActionButtons([
          _ActionButton('In-Order', Icons.sort, _treeInOrder,
              Theme.of(context).colorScheme.tertiary),
          _ActionButton('Pre-Order', Icons.first_page, _treePreOrder,
              Theme.of(context).colorScheme.tertiary),
          _ActionButton('Post-Order', Icons.last_page, _treePostOrder,
              Theme.of(context).colorScheme.tertiary),
          _ActionButton('Level-Order', Icons.layers, _treeLevelOrder,
              Theme.of(context).colorScheme.tertiary),
        ]),
      ],
    );
  }

  Widget _buildGraphControls() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStyledTextField(
                controller: _valueController,
                label: 'From Node',
                icon: Icons.hub,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildStyledTextField(
                controller: _indexController,
                label: 'To Node',
                icon: Icons.place,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildActionButtons([
          _ActionButton('Add Node', Icons.add_circle, _graphAddNode,
              Theme.of(context).colorScheme.primary),
          _ActionButton('Add Edge', Icons.add_link, _graphAddEdge,
              Theme.of(context).colorScheme.secondary),
          _ActionButton('Clear', Icons.clear_all, _clearAll,
              Theme.of(context).colorScheme.outline),
        ]),
      ],
    );
  }

  Widget _buildHashControls() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStyledTextField(
                controller: _valueController,
                label: 'Key',
                icon: Icons.vpn_key,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildStyledTextField(
                controller: _indexController,
                label: 'Value',
                icon: Icons.data_object,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildActionButtons([
          _ActionButton('Insert', Icons.add, _hashInsert,
              Theme.of(context).colorScheme.primary),
          _ActionButton('Delete', Icons.delete, _hashDelete,
              Theme.of(context).colorScheme.error),
          _ActionButton('Clear', Icons.clear_all, _clearAll,
              Theme.of(context).colorScheme.outline),
        ]),
      ],
    );
  }

  Widget _buildHeapControls() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SwitchListTile(
            value: isMinHeap,
            onChanged: (v) => setState(() => isMinHeap = v),
            title: Text(
              'Min Heap',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              isMinHeap ? 'Currently: Min Heap' : 'Currently: Max Heap',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: 16),
        _buildStyledTextField(
          controller: _valueController,
          label: 'Value (numbers only)',
          icon: Icons.trending_up,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16),
        _buildActionButtons([
          _ActionButton('Insert', Icons.add, _heapInsert,
              Theme.of(context).colorScheme.primary),
          _ActionButton('Delete Root', Icons.remove_circle, _heapDeleteRoot,
              Theme.of(context).colorScheme.error),
          _ActionButton('Clear', Icons.clear_all, _clearAll,
              Theme.of(context).colorScheme.outline),
        ]),
      ],
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  Widget _buildActionButtons(List<_ActionButton> buttons) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: buttons
          .map((button) => ElevatedButton.icon(
                onPressed: button.onPressed,
                icon: Icon(button.icon, size: 18),
                label: Text(button.label),
                style: ElevatedButton.styleFrom(
                  backgroundColor: button.color,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Data Structure Visualizer',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Enhanced Dropdown Selection
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: selectedStructure,
                decoration: InputDecoration(
                  labelText: 'Select Data Structure',
                  prefixIcon: Icon(_getStructureIcon(selectedStructure)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
                items: structures
                    .map((str) => DropdownMenuItem(
                          value: str,
                          child: Row(
                            children: [
                              Icon(_getStructureIcon(str), size: 20),
                              SizedBox(width: 12),
                              Text(str, style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ))
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
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondaryContainer,
                      Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        result,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Enhanced Visualizer
            Expanded(child: _buildVisualizer()),

            // Enhanced Controls
            _buildControls(),
          ],
        ),
      ),
    );
  }
}

class _ActionButton {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  _ActionButton(this.label, this.icon, this.onPressed, this.color);
}
