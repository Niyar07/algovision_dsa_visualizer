import 'package:flutter/material.dart';

class ControlWidgets {
  static Widget buildWrapButtons(
      List<String> labels, List<VoidCallback> actions) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: List.generate(
        labels.length,
        (i) => ElevatedButton(
          onPressed: actions[i],
          child: Text(labels[i], style: TextStyle(fontSize: 12)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ),
    );
  }

  static Widget buildTextField(TextEditingController controller, String label,
      {IconData? icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
    );
  }

  static Widget buildNumberField(
      TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  static Widget buildDoubleInput(TextEditingController controller1,
      TextEditingController controller2, String label1, String label2,
      {IconData? icon1, bool isSecondNumber = false}) {
    return Row(
      children: [
        Expanded(
          child: buildTextField(controller1, label1, icon: icon1),
        ),
        SizedBox(width: 8),
        Expanded(
          child: isSecondNumber
              ? buildNumberField(controller2, label2)
              : buildTextField(controller2, label2),
        ),
      ],
    );
  }
}
