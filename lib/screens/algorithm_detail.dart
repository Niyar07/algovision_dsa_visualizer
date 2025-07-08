import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class AlgorithmDetailScreen extends StatefulWidget {
  @override
  _AlgorithmDetailScreenState createState() => _AlgorithmDetailScreenState();
}

class _AlgorithmDetailScreenState extends State<AlgorithmDetailScreen> {
  final List<String> algorithms = [
    'Bubble Sort',
    'Selection Sort',
    'Insertion Sort',
    'Merge Sort',
    'Quick Sort'
  ];

  String selectedAlgorithm = 'Bubble Sort';
  List<int> numbers = [];
  int sampleSize = 20;
  bool isSorting = false;
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _customInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateRandomData();
  }

  void generateRandomData() {
    final rng = Random();
    setState(() {
      numbers = List.generate(sampleSize, (_) => rng.nextInt(200) + 50);
    });
  }

  void generateFromCustomInput() {
    final input = _customInputController.text.trim();
    if (input.isEmpty) return;
    final parts = input.split(',');
    final parsed =
        parts.map((e) => int.tryParse(e.trim())).whereType<int>().toList();
    if (parsed.isNotEmpty) {
      setState(() {
        numbers = parsed;
        sampleSize = numbers.length;
      });
    }
  }

  Future<void> bubbleSort() async {
    setState(() => isSorting = true);
    for (int i = 0; i < numbers.length - 1; i++) {
      for (int j = 0; j < numbers.length - i - 1; j++) {
        if (numbers[j] > numbers[j + 1]) {
          final temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;
          setState(() {});
          await Future.delayed(Duration(milliseconds: 100));
        }
      }
    }
    setState(() => isSorting = false);
  }

  Future<void> selectionSort() async {
    setState(() => isSorting = true);
    for (int i = 0; i < numbers.length; i++) {
      int minIndex = i;
      for (int j = i + 1; j < numbers.length; j++) {
        if (numbers[j] < numbers[minIndex]) {
          minIndex = j;
        }
      }
      final temp = numbers[i];
      numbers[i] = numbers[minIndex];
      numbers[minIndex] = temp;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 100));
    }
    setState(() => isSorting = false);
  }

  Future<void> insertionSort() async {
    setState(() => isSorting = true);
    for (int i = 1; i < numbers.length; i++) {
      int key = numbers[i];
      int j = i - 1;
      while (j >= 0 && numbers[j] > key) {
        numbers[j + 1] = numbers[j];
        j = j - 1;
        setState(() {});
        await Future.delayed(Duration(milliseconds: 100));
      }
      numbers[j + 1] = key;
      setState(() {});
    }
    setState(() => isSorting = false);
  }

  Future<void> mergeSort(int left, int right) async {
    if (left < right) {
      int mid = (left + right) ~/ 2;
      await mergeSort(left, mid);
      await mergeSort(mid + 1, right);
      await merge(left, mid, right);
      setState(() {});
    }
  }

  Future<void> merge(int left, int mid, int right) async {
    List<int> leftArray = numbers.sublist(left, mid + 1);
    List<int> rightArray = numbers.sublist(mid + 1, right + 1);
    int i = 0, j = 0, k = left;

    while (i < leftArray.length && j < rightArray.length) {
      if (leftArray[i] <= rightArray[j]) {
        numbers[k++] = leftArray[i++];
      } else {
        numbers[k++] = rightArray[j++];
      }
      setState(() {});
      await Future.delayed(Duration(milliseconds: 100));
    }
    while (i < leftArray.length) {
      numbers[k++] = leftArray[i++];
      setState(() {});
      await Future.delayed(Duration(milliseconds: 100));
    }
    while (j < rightArray.length) {
      numbers[k++] = rightArray[j++];
      setState(() {});
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  Future<void> quickSort(int low, int high) async {
    if (low < high) {
      int pi = await partition(low, high);
      await quickSort(low, pi - 1);
      await quickSort(pi + 1, high);
    }
  }

  Future<int> partition(int low, int high) async {
    int pivot = numbers[high];
    int i = low - 1;
    for (int j = low; j < high; j++) {
      if (numbers[j] <= pivot) {
        i++;
        final temp = numbers[i];
        numbers[i] = numbers[j];
        numbers[j] = temp;
        setState(() {});
        await Future.delayed(Duration(milliseconds: 100));
      }
    }
    final temp = numbers[i + 1];
    numbers[i + 1] = numbers[high];
    numbers[high] = temp;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 100));
    return i + 1;
  }

  void runAlgorithm() {
    if (isSorting) return;
    switch (selectedAlgorithm) {
      case 'Bubble Sort':
        bubbleSort();
        break;
      case 'Selection Sort':
        selectionSort();
        break;
      case 'Insertion Sort':
        insertionSort();
        break;
      case 'Merge Sort':
        setState(() => isSorting = true);
        mergeSort(0, numbers.length - 1)
            .then((_) => setState(() => isSorting = false));
        break;
      case 'Quick Sort':
        setState(() => isSorting = true);
        quickSort(0, numbers.length - 1)
            .then((_) => setState(() => isSorting = false));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Algorithms')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton<String>(
              value: selectedAlgorithm,
              onChanged: (value) => setState(() => selectedAlgorithm = value!),
              items: algorithms
                  .map((algo) =>
                      DropdownMenuItem(value: algo, child: Text(algo)))
                  .toList(),
              isExpanded: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Sample Size',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final input = int.tryParse(_inputController.text.trim());
                    if (input != null && input > 0) {
                      setState(() {
                        sampleSize = input;
                        generateRandomData();
                      });
                    }
                  },
                  child: Text('Generate'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _customInputController,
                    decoration: InputDecoration(
                      labelText: 'Custom Values (e.g. 20,40,60)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: generateFromCustomInput,
                  child: Text('Use Input'),
                ),
              ],
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
                    Text('$selectedAlgorithm Visualizer',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        child: CustomPaint(
                          painter: BarChartPainter(numbers),
                          child: Container(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: isSorting ? null : runAlgorithm,
                      child: Text('Run Algorithm'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<int> values;
  BarChartPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;

    final barWidth = size.width / values.length;
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < values.length; i++) {
      final barHeight = values[i].toDouble();
      final x = i * barWidth;
      final y = size.height - barHeight;
      canvas.drawRect(Rect.fromLTWH(x, y, barWidth * 0.8, barHeight), paint);

      final textSpan = TextSpan(
        text: values[i].toString(),
        style: TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.text = textSpan;
      textPainter.layout(minWidth: barWidth * 0.8);
      textPainter.paint(canvas, Offset(x, y - 16));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
