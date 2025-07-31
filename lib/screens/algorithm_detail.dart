import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class AlgorithmDetailScreen extends StatefulWidget {
  @override
  _AlgorithmDetailScreenState createState() => _AlgorithmDetailScreenState();
}

class _AlgorithmDetailScreenState extends State<AlgorithmDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _sortingAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<AlgorithmInfo> algorithms = [
    AlgorithmInfo(
      name: 'Bubble Sort',
      timeComplexity: 'O(n²)',
      spaceComplexity: 'O(1)',
      description:
          'Compares adjacent elements and swaps them if they are in wrong order',
      icon: Icons.bubble_chart,
      color: Colors.blue,
    ),
    AlgorithmInfo(
      name: 'Selection Sort',
      timeComplexity: 'O(n²)',
      spaceComplexity: 'O(1)',
      description: 'Finds minimum element and places it at the beginning',
      icon: Icons.select_all,
      color: Colors.green,
    ),
    AlgorithmInfo(
      name: 'Insertion Sort',
      timeComplexity: 'O(n²)',
      spaceComplexity: 'O(1)',
      description: 'Builds sorted array one element at a time',
      icon: Icons.insert_drive_file,
      color: Colors.orange,
    ),
    AlgorithmInfo(
      name: 'Merge Sort',
      timeComplexity: 'O(n log n)',
      spaceComplexity: 'O(n)',
      description: 'Divides array and merges sorted halves',
      icon: Icons.call_merge,
      color: Colors.purple,
    ),
    AlgorithmInfo(
      name: 'Quick Sort',
      timeComplexity: 'O(n log n)',
      spaceComplexity: 'O(log n)',
      description: 'Picks pivot and partitions array around it',
      icon: Icons.flash_on,
      color: Colors.red,
    ),
  ];

  AlgorithmInfo get selectedAlgorithmInfo => algorithms.firstWhere(
        (algo) => algo.name == selectedAlgorithm.name,
        orElse: () => algorithms[0],
      );

  AlgorithmInfo selectedAlgorithm = AlgorithmInfo(
    name: 'Bubble Sort',
    timeComplexity: 'O(n²)',
    spaceComplexity: 'O(1)',
    description:
        'Compares adjacent elements and swaps them if they are in wrong order',
    icon: Icons.bubble_chart,
    color: Colors.blue,
  );

  List<BarData> numbers = [];
  int sampleSize = 10;
  bool isSorting = false;
  double sortingSpeed = 150.0;
  int comparisons = 0;
  int swaps = 0;
  int currentStep = 0;
  String currentOperation = '';

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _customInputController = TextEditingController();

  Set<int> highlightedIndices = {};
  Set<int> sortedIndices = {};

  @override
  void initState() {
    super.initState();
    _initAnimations();
    generateRandomData();
    selectedAlgorithm = algorithms[0];
  }

  void _initAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _sortingAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
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
    _sortingAnimationController.dispose();
    _inputController.dispose();
    _customInputController.dispose();
    super.dispose();
  }

  void generateRandomData() {
    final rng = Random();
    setState(() {
      numbers = List.generate(
          sampleSize,
          (index) => BarData(
                value: rng.nextInt(150) + 30,
                index: index,
                isHighlighted: false,
                isSorted: false,
              ));
      _resetStats();
    });
  }

  void generateFromCustomInput() {
    final input = _customInputController.text.trim();
    if (input.isEmpty) return;
    final parts = input.split(',');
    final parsed =
        parts.map((e) => int.tryParse(e.trim())).whereType<int>().toList();
    if (parsed.isNotEmpty && parsed.length <= 20) {
      setState(() {
        numbers = parsed
            .asMap()
            .entries
            .map((entry) => BarData(
                  value: entry.value.clamp(10, 200),
                  index: entry.key,
                  isHighlighted: false,
                  isSorted: false,
                ))
            .toList();
        sampleSize = numbers.length;
        _resetStats();
      });
    }
    _customInputController.clear();
  }

  void _resetStats() {
    comparisons = 0;
    swaps = 0;
    currentStep = 0;
    currentOperation = '';
    highlightedIndices.clear();
    sortedIndices.clear();
  }

  void _highlightComparison(int i, int j) {
    setState(() {
      highlightedIndices = {i, j};
      comparisons++;
    });
  }

  void _clearHighlight() {
    setState(() {
      highlightedIndices.clear();
    });
  }

  void _markSorted(int index) {
    setState(() {
      sortedIndices.add(index);
    });
  }

  Future<void> _delay() async {
    await Future.delayed(Duration(milliseconds: sortingSpeed.round()));
  }

  // All Sorting Algorithms Implementation
  Future<void> bubbleSort() async {
    setState(() {
      isSorting = true;
      currentOperation = 'Starting Bubble Sort...';
    });

    for (int i = 0; i < numbers.length - 1; i++) {
      for (int j = 0; j < numbers.length - i - 1; j++) {
        if (!isSorting) return; // Allow stopping

        setState(() {
          currentStep++;
          currentOperation = 'Comparing positions $j and ${j + 1}';
        });

        _highlightComparison(j, j + 1);
        await _delay();

        if (numbers[j].value > numbers[j + 1].value) {
          final temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;

          setState(() {
            swaps++;
            currentOperation =
                'Swapped ${numbers[j + 1].value} ↔ ${numbers[j].value}';
          });
          await _delay();
        }
      }
      _markSorted(numbers.length - 1 - i);
      await _delay();
    }
    _markSorted(0);
    _clearHighlight();
    setState(() {
      isSorting = false;
      currentOperation = 'Bubble Sort completed! ✅';
    });
  }

  Future<void> selectionSort() async {
    setState(() {
      isSorting = true;
      currentOperation = 'Starting Selection Sort...';
    });

    for (int i = 0; i < numbers.length; i++) {
      if (!isSorting) return;

      int minIndex = i;
      setState(() {
        currentOperation = 'Finding minimum from position $i';
      });

      for (int j = i + 1; j < numbers.length; j++) {
        if (!isSorting) return;

        setState(() {
          currentStep++;
        });
        _highlightComparison(minIndex, j);
        await _delay();

        if (numbers[j].value < numbers[minIndex].value) {
          minIndex = j;
          setState(() {
            currentOperation = 'New minimum: ${numbers[minIndex].value}';
          });
        }
      }

      if (minIndex != i) {
        final temp = numbers[i];
        numbers[i] = numbers[minIndex];
        numbers[minIndex] = temp;
        setState(() {
          swaps++;
          currentOperation =
              'Swapped ${numbers[i].value} ↔ ${numbers[minIndex].value}';
        });
      }

      _markSorted(i);
      await _delay();
    }

    _clearHighlight();
    setState(() {
      isSorting = false;
      currentOperation = 'Selection Sort completed! ✅';
    });
  }

  Future<void> insertionSort() async {
    setState(() {
      isSorting = true;
      currentOperation = 'Starting Insertion Sort...';
    });

    _markSorted(0); // First element is considered sorted

    for (int i = 1; i < numbers.length; i++) {
      if (!isSorting) return;

      int key = numbers[i].value;
      int j = i - 1;

      setState(() {
        currentOperation = 'Inserting ${numbers[i].value} into sorted portion';
      });

      while (j >= 0 && numbers[j].value > key && isSorting) {
        setState(() {
          currentStep++;
        });
        _highlightComparison(j, j + 1);
        await _delay();

        numbers[j + 1].value = numbers[j].value;
        j = j - 1;
        setState(() {
          swaps++;
        });
        await _delay();
      }

      numbers[j + 1].value = key;
      _markSorted(i);
      await _delay();
    }

    _clearHighlight();
    setState(() {
      isSorting = false;
      currentOperation = 'Insertion Sort completed! ✅';
    });
  }

  Future<void> mergeSort(int left, int right) async {
    if (!isSorting) return;

    if (left < right) {
      int mid = (left + right) ~/ 2;

      setState(() {
        currentOperation =
            'Dividing array: [$left-$mid] and [${mid + 1}-$right]';
      });
      await _delay();

      await mergeSort(left, mid);
      await mergeSort(mid + 1, right);
      await merge(left, mid, right);
    }
  }

  Future<void> merge(int left, int mid, int right) async {
    if (!isSorting) return;

    List<int> leftArray =
        numbers.sublist(left, mid + 1).map((e) => e.value).toList();
    List<int> rightArray =
        numbers.sublist(mid + 1, right + 1).map((e) => e.value).toList();
    int i = 0, j = 0, k = left;

    setState(() {
      currentOperation = 'Merging subarrays...';
    });

    while (i < leftArray.length && j < rightArray.length && isSorting) {
      setState(() {
        currentStep++;
        comparisons++;
      });

      if (leftArray[i] <= rightArray[j]) {
        numbers[k].value = leftArray[i++];
      } else {
        numbers[k].value = rightArray[j++];
      }

      _highlightComparison(k, k);
      k++;
      await _delay();
    }

    while (i < leftArray.length && isSorting) {
      numbers[k].value = leftArray[i++];
      k++;
      await _delay();
    }

    while (j < rightArray.length && isSorting) {
      numbers[k].value = rightArray[j++];
      k++;
      await _delay();
    }

    // Mark merged section as sorted
    for (int idx = left; idx <= right && isSorting; idx++) {
      _markSorted(idx);
    }
  }

  Future<void> quickSort(int low, int high) async {
    if (!isSorting) return;

    if (low < high) {
      setState(() {
        currentOperation = 'Partitioning array around pivot';
      });

      int pi = await partition(low, high);
      await quickSort(low, pi - 1);
      await quickSort(pi + 1, high);
    }
  }

  Future<int> partition(int low, int high) async {
    if (!isSorting) return low;

    int pivot = numbers[high].value;
    int i = low - 1;

    setState(() {
      currentOperation = 'Pivot selected: $pivot';
    });

    for (int j = low; j < high && isSorting; j++) {
      setState(() {
        currentStep++;
      });
      _highlightComparison(j, high);
      await _delay();

      if (numbers[j].value <= pivot) {
        i++;
        if (i != j) {
          final temp = numbers[i].value;
          numbers[i].value = numbers[j].value;
          numbers[j].value = temp;
          setState(() {
            swaps++;
          });
        }
        await _delay();
      }
    }

    final temp = numbers[i + 1].value;
    numbers[i + 1].value = numbers[high].value;
    numbers[high].value = temp;
    setState(() {
      swaps++;
    });

    _markSorted(i + 1);
    await _delay();
    return i + 1;
  }

  // Fixed runAlgorithm method with all algorithms
  void runAlgorithm() {
    if (isSorting) return;

    setState(() {
      for (var bar in numbers) {
        bar.isSorted = false;
      }
      sortedIndices.clear();
    });

    _resetStats();

    switch (selectedAlgorithm.name) {
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
        mergeSort(0, numbers.length - 1).then((_) {
          if (mounted) {
            setState(() {
              isSorting = false;
              currentOperation = 'Merge Sort completed! ✅';
            });
          }
        });
        break;
      case 'Quick Sort':
        setState(() => isSorting = true);
        quickSort(0, numbers.length - 1).then((_) {
          if (mounted) {
            setState(() {
              isSorting = false;
              currentOperation = 'Quick Sort completed! ✅';
            });
          }
        });
        break;
      default:
        setState(() {
          currentOperation = 'Algorithm not implemented yet';
        });
    }
  }

  void stopSorting() {
    setState(() {
      isSorting = false;
      currentOperation = 'Sorting stopped ⏹️';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                _buildCustomAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        _buildAlgorithmInfo(),
                        SizedBox(height: 20),
                        _buildVisualizationCard(),
                        SizedBox(height: 16),
                        _buildStatsCard(),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
                _buildBottomControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_rounded),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Algorithm Visualizer',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  'Interactive Sorting Algorithms',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: selectedAlgorithmInfo.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selectedAlgorithmInfo.color.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  selectedAlgorithmInfo.icon,
                  size: 16,
                  color: selectedAlgorithmInfo.color,
                ),
                SizedBox(width: 4),
                Text(
                  selectedAlgorithm.name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selectedAlgorithmInfo.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlgorithmInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            selectedAlgorithmInfo.color.withOpacity(0.1),
            selectedAlgorithmInfo.color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selectedAlgorithmInfo.color.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: selectedAlgorithmInfo.color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: selectedAlgorithmInfo.color.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  selectedAlgorithmInfo.icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedAlgorithm.name,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      selectedAlgorithmInfo.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildComplexityCard(
                  'Time Complexity',
                  selectedAlgorithmInfo.timeComplexity,
                  Icons.schedule,
                  Colors.orange,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildComplexityCard(
                  'Space Complexity',
                  selectedAlgorithmInfo.spaceComplexity,
                  Icons.memory,
                  Colors.teal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplexityCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisualizationCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 400,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  selectedAlgorithmInfo.color,
                  selectedAlgorithmInfo.color.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Live Visualization',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isSorting)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Sorting...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: numbers.isEmpty
                ? _buildEmptyState()
                : Container(
                    padding: EdgeInsets.all(20),
                    child: CustomPaint(
                      painter: PerfectBarChartPainter(
                        numbers,
                        highlightedIndices,
                        sortedIndices,
                        Theme.of(context).colorScheme,
                        selectedAlgorithmInfo.color,
                      ),
                      child: Container(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bar_chart_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'No Data to Visualize',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          SizedBox(height: 8),
          Text(
            'Generate random data or enter custom values\nto start the visualization',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    if (!isSorting && currentStep == 0) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          if (currentOperation.isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                currentOperation,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                  'Steps', currentStep.toString(), Icons.stairs, Colors.blue),
              _buildStatItem('Comparisons', comparisons.toString(),
                  Icons.compare_arrows, Colors.orange),
              _buildStatItem(
                  'Swaps', swaps.toString(), Icons.swap_horiz, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomControls() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                // Algorithm Selection
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<AlgorithmInfo>(
                      value: selectedAlgorithm,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      items: algorithms
                          .map((algo) => DropdownMenuItem(
                                value: algo,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: algo.color.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(algo.icon,
                                          color: algo.color, size: 20),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            algo.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            algo.timeComplexity,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: isSorting
                          ? null
                          : (value) =>
                              setState(() => selectedAlgorithm = value!),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Data Controls
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _inputController,
                        keyboardType: TextInputType.number,
                        enabled: !isSorting,
                        decoration: InputDecoration(
                          labelText: 'Sample Size (5-20)',
                          prefixIcon: Icon(Icons.numbers),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: isSorting
                          ? null
                          : () {
                              final input =
                                  int.tryParse(_inputController.text.trim());
                              if (input != null && input >= 5 && input <= 20) {
                                setState(() {
                                  sampleSize = input;
                                  generateRandomData();
                                });
                                _inputController.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Please enter a number between 5 and 20')),
                                );
                              }
                            },
                      icon: Icon(Icons.auto_awesome),
                      label: Text('Generate'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedAlgorithmInfo.color,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Custom Values
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _customInputController,
                        enabled: !isSorting,
                        decoration: InputDecoration(
                          labelText: 'Custom Values (e.g. 45,23,67,12)',
                          prefixIcon: Icon(Icons.edit_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: isSorting ? null : generateFromCustomInput,
                      icon: Icon(Icons.input_rounded),
                      label: Text('Use'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Speed Control
                Row(
                  children: [
                    Icon(Icons.speed,
                        color: Theme.of(context).colorScheme.primary),
                    SizedBox(width: 12),
                    Text(
                      'Speed',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Slider(
                        value: sortingSpeed,
                        min: 50.0,
                        max: 500.0,
                        divisions: 18,
                        label: '${sortingSpeed.round()}ms',
                        onChanged: isSorting
                            ? null
                            : (value) {
                                setState(() => sortingSpeed = value);
                              },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Action Buttons - FIXED SHUFFLE BUTTON
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: isSorting
                            ? stopSorting
                            : (numbers.isEmpty ? null : runAlgorithm),
                        icon: Icon(isSorting
                            ? Icons.stop_rounded
                            : Icons.play_arrow_rounded),
                        label:
                            Text(isSorting ? 'Stop Sorting' : 'Start Sorting'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSorting
                              ? Theme.of(context).colorScheme.error
                              : selectedAlgorithmInfo.color,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: isSorting
                          ? null
                          : () {
                              generateRandomData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(Icons.shuffle_rounded,
                                          color: Colors.white),
                                      SizedBox(width: 8),
                                      Text('Generated new random data!'),
                                    ],
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            },
                      icon: Icon(Icons.shuffle_rounded),
                      label: Text('Shuffle'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Data Models
class BarData {
  int value;
  int index;
  bool isHighlighted;
  bool isSorted;

  BarData({
    required this.value,
    required this.index,
    this.isHighlighted = false,
    this.isSorted = false,
  });
}

class AlgorithmInfo {
  final String name;
  final String timeComplexity;
  final String spaceComplexity;
  final String description;
  final IconData icon;
  final Color color;

  AlgorithmInfo({
    required this.name,
    required this.timeComplexity,
    required this.spaceComplexity,
    required this.description,
    required this.icon,
    required this.color,
  });
}

// Perfect Custom Painter with Proper Alignment
class PerfectBarChartPainter extends CustomPainter {
  final List<BarData> values;
  final Set<int> highlightedIndices;
  final Set<int> sortedIndices;
  final ColorScheme colorScheme;
  final Color algorithmColor;

  PerfectBarChartPainter(
    this.values,
    this.highlightedIndices,
    this.sortedIndices,
    this.colorScheme,
    this.algorithmColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final maxValue = values.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final barWidth = size.width / values.length;
    final heightScale = (size.height - 80) / maxValue;
    final barSpacing = barWidth * 0.1;
    final actualBarWidth = barWidth * 0.8;

    for (int i = 0; i < values.length; i++) {
      final barHeight = values[i].value * heightScale;
      final x = i * barWidth + barSpacing / 2;
      final y = size.height - barHeight - 50;

      Paint barPaint = Paint();
      List<Color> gradientColors;

      if (sortedIndices.contains(i)) {
        gradientColors = [Colors.green.shade400, Colors.green.shade600];
      } else if (highlightedIndices.contains(i)) {
        gradientColors = [Colors.red.shade400, Colors.red.shade600];
      } else {
        gradientColors = [algorithmColor.withOpacity(0.8), algorithmColor];
      }

      barPaint.shader = LinearGradient(
        colors: gradientColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(x, y, actualBarWidth, barHeight));

      final RRect barRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, actualBarWidth, barHeight),
        Radius.circular(8),
      );
      canvas.drawRRect(barRect, barPaint);

      // Value text inside bar
      final valueTextPainter = TextPainter(
        text: TextSpan(
          text: values[i].value.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: min(16.0, actualBarWidth * 0.4),
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      valueTextPainter.layout(minWidth: actualBarWidth);
      final valueTextX = x + (actualBarWidth - valueTextPainter.width) / 2;
      final valueTextY = y + 12;

      if (barHeight > 30) {
        valueTextPainter.paint(canvas, Offset(valueTextX, valueTextY));
      }

      // Index at bottom
      final indexTextPainter = TextPainter(
        text: TextSpan(
          text: i.toString(),
          style: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.7),
            fontSize: min(14.0, actualBarWidth * 0.35),
            fontWeight: FontWeight.w600,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      indexTextPainter.layout(minWidth: actualBarWidth);
      final indexTextX = x + (actualBarWidth - indexTextPainter.width) / 2;
      final indexTextY = size.height - 35;

      final indexBgPaint = Paint()
        ..color = colorScheme.surface
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(
            x + actualBarWidth / 2, indexTextY + indexTextPainter.height / 2),
        max(indexTextPainter.width, indexTextPainter.height) / 2 + 4,
        indexBgPaint,
      );

      indexTextPainter.paint(canvas, Offset(indexTextX, indexTextY));

      // Status indicator
      Paint dotPaint = Paint();
      if (sortedIndices.contains(i)) {
        dotPaint.color = Colors.green;
      } else if (highlightedIndices.contains(i)) {
        dotPaint.color = Colors.red;
      } else {
        dotPaint.color = algorithmColor.withOpacity(0.6);
      }

      canvas.drawCircle(
        Offset(x + actualBarWidth / 2, y - 8),
        4,
        dotPaint,
      );
    }

    _drawLegend(canvas, size);
  }

  void _drawLegend(Canvas canvas, Size size) {
    final legendItems = [
      {'color': algorithmColor, 'text': 'Unsorted'},
      {'color': Colors.red, 'text': 'Comparing'},
      {'color': Colors.green, 'text': 'Sorted'},
    ];

    double legendY = 10;
    double legendX = 10;

    for (var item in legendItems) {
      final colorPaint = Paint()..color = item['color'] as Color;
      canvas.drawCircle(Offset(legendX + 6, legendY + 6), 6, colorPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: item['text'] as String,
          style: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(legendX + 18, legendY));

      legendX += textPainter.width + 35;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
