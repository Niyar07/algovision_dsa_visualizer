class TreeNode {
  String value;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.value);
}

class GraphNode {
  String value;
  List<String> connections;

  GraphNode(this.value) : connections = [];
}
