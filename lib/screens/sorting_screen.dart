// sorting_screen.dart
import 'package:flutter/material.dart';

class SortingScreen extends StatefulWidget {
  @override
  _SortingScreenState createState() => _SortingScreenState();
}

class _SortingScreenState extends State<SortingScreen> {
  final TextEditingController _controller = TextEditingController();
  List<int> numbers = [];
  String selectedAlgorithm = 'Bubble Sort';

  final Map<String, String> complexities = {
    'Bubble Sort': 'Time: O(n^2), Space: O(1)',
    'Selection Sort': 'Time: O(n^2), Space: O(1)',
    'Insertion Sort': 'Time: O(n^2), Space: O(1)',
    'Merge Sort': 'Time: O(n log n), Space: O(n)',
    'Heap Sort': 'Time: O(n log n), Space: O(1)',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sorting Visualizer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter numbers (comma-separated)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedAlgorithm,
              onChanged: (value) {
                setState(() => selectedAlgorithm = value!);
              },
              items: complexities.keys
                  .map((algo) =>
                      DropdownMenuItem(value: algo, child: Text(algo)))
                  .toList(),
            ),
            Text(complexities[selectedAlgorithm] ?? ''),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _startSorting,
              child: Text('Start Visualization'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: numbers.map((num) {
                  return Container(
                    width: 20,
                    height: num.toDouble() * 3,
                    color: Colors.indigo,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startSorting() async {
    List<int> input = _controller.text
        .split(',')
        .map((e) => int.tryParse(e.trim()) ?? 0)
        .toList();
    setState(() => numbers = input);
    switch (selectedAlgorithm) {
      case 'Bubble Sort':
        await _bubbleSort();
        break;
      case 'Selection Sort':
        await _selectionSort();
        break;
      case 'Insertion Sort':
        await _insertionSort();
        break;
      case 'Merge Sort':
        await _mergeSort(0, numbers.length - 1);
        break;
      case 'Heap Sort':
        await _heapSort();
        break;
    }
  }

  Future<void> _bubbleSort() async {
    for (int i = 0; i < numbers.length - 1; i++) {
      for (int j = 0; j < numbers.length - i - 1; j++) {
        if (numbers[j] > numbers[j + 1]) {
          int temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;
          setState(() {});
          await Future.delayed(Duration(milliseconds: 300));
        }
      }
    }
  }

  Future<void> _selectionSort() async {
    for (int i = 0; i < numbers.length; i++) {
      int minIdx = i;
      for (int j = i + 1; j < numbers.length; j++) {
        if (numbers[j] < numbers[minIdx]) minIdx = j;
      }
      int temp = numbers[i];
      numbers[i] = numbers[minIdx];
      numbers[minIdx] = temp;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 300));
    }
  }

  Future<void> _insertionSort() async {
    for (int i = 1; i < numbers.length; i++) {
      int key = numbers[i];
      int j = i - 1;
      while (j >= 0 && numbers[j] > key) {
        numbers[j + 1] = numbers[j];
        j--;
        setState(() {});
        await Future.delayed(Duration(milliseconds: 300));
      }
      numbers[j + 1] = key;
      setState(() {});
    }
  }

  Future<void> _mergeSort(int left, int right) async {
    if (left < right) {
      int mid = (left + right) ~/ 2;
      await _mergeSort(left, mid);
      await _mergeSort(mid + 1, right);
      await _merge(left, mid, right);
    }
  }

  Future<void> _merge(int left, int mid, int right) async {
    List<int> leftList = numbers.sublist(left, mid + 1);
    List<int> rightList = numbers.sublist(mid + 1, right + 1);

    int i = 0, j = 0, k = left;
    while (i < leftList.length && j < rightList.length) {
      if (leftList[i] <= rightList[j]) {
        numbers[k] = leftList[i];
        i++;
      } else {
        numbers[k] = rightList[j];
        j++;
      }
      k++;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 300));
    }
    while (i < leftList.length) {
      numbers[k++] = leftList[i++];
      setState(() {});
      await Future.delayed(Duration(milliseconds: 300));
    }
    while (j < rightList.length) {
      numbers[k++] = rightList[j++];
      setState(() {});
      await Future.delayed(Duration(milliseconds: 300));
    }
  }

  Future<void> _heapSort() async {
    int n = numbers.length;

    for (int i = n ~/ 2 - 1; i >= 0; i--) {
      await _heapify(n, i);
    }

    for (int i = n - 1; i > 0; i--) {
      int temp = numbers[0];
      numbers[0] = numbers[i];
      numbers[i] = temp;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 300));
      await _heapify(i, 0);
    }
  }

  Future<void> _heapify(int n, int i) async {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < n && numbers[left] > numbers[largest]) largest = left;
    if (right < n && numbers[right] > numbers[largest]) largest = right;

    if (largest != i) {
      int swap = numbers[i];
      numbers[i] = numbers[largest];
      numbers[largest] = swap;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 300));
      await _heapify(n, largest);
    }
  }
}
