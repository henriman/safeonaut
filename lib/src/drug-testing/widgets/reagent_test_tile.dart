import 'package:flutter/material.dart';
import 'package:safeonaut/src/drug-testing/models/reagent_test.dart';
import 'package:safeonaut/src/settings/settings_controller.dart';

class ReagentTestTile extends StatefulWidget {
  final SettingsController settingsController;
  final ReagentTest test;

  const ReagentTestTile({
    Key? key,
    required this.settingsController,
    required this.test,
  }) : super(key: key);

  @override
  createState() => _ReagentTestTileState();
}

class _ReagentTestTileState extends State<ReagentTestTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // Use an expansion tile; the expanded part shows the reactions which happened.
      child: ExpansionTile(
        title: Text(
          widget.test.reagent.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Container(
            color: (widget.settingsController.themeMode == ThemeMode.light)
                ? const Color(0xFFEEEEEE)
                : Colors.grey[700],
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: <Widget>[
                    // Show information regarding the results (start and end time).
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("0"),
                        const Text("Results"),
                        Text(widget.test.reagent.end.toString()),
                      ],
                    ),
                  ] +
                  // Show results.
                  List.generate(
                    widget.test.result.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: widget.test.reagent.createWidgetOf(
                          double.maxFinite,
                          widget.test.result.elementAt(index),
                        ),
                      );
                    },
                  ),
            ),
          )
        ],
      ),
    );
  }
}
