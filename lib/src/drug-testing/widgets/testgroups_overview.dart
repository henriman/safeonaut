import "package:flutter/material.dart";
import 'package:safeonaut/src/drug-testing/models/reagent_test.dart';
import 'package:safeonaut/src/drug-testing/models/reagents/reagents.dart';
import 'package:safeonaut/src/drug-testing/models/test_group.dart';
import 'package:safeonaut/src/drug-testing/widgets/test_group_tile.dart';
import 'package:safeonaut/src/settings/settings_controller.dart';
import 'package:safeonaut/src/settings/settings_view.dart';

class TestGroupsOverviewView extends StatefulWidget {
  final SettingsController settingsController;

  const TestGroupsOverviewView({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  static const routeName = "/overview";

  @override
  createState() => _TestGroupsOverviewViewState();
}

// TODO: order the test groups
// TODO: Make enter enter when creating a new test group.
class _TestGroupsOverviewViewState extends State<TestGroupsOverviewView> {
  // Test values.
  final List<TestGroup> groups = [
    TestGroup(name: "My LSD yo", tests: [
      ReagentTest(
          reagent: reagents[Reagents.marquis]!,
          result: {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}),
      ReagentTest(reagent: reagents[Reagents.ehrlichs]!, result: {0}),
    ]),
    TestGroup(name: "cocaina (hopefully)", tests: []),
  ];

  final TextEditingController _createTestGroupController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Propagate touches to children.
      behavior: HitTestBehavior.translucent,
      // On tap, unfocus the currently selected text field.
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Test groups overview"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SettingsView.routeName);
              },
              icon: const Icon(Icons.settings),
            )
          ],
        ),
        // Instantiate all test group tiles.
        body: ListView.builder(
          itemCount: groups.length,
          padding: const EdgeInsets.all(20.0),
          itemBuilder: (context, i) {
            return TestGroupTile(
              key: Key("$i"),
              settingsController: widget.settingsController,
              testGroup: groups[i],
              delete: () => setState(() => groups.removeAt(i)),
            );
          },
        ),
        // Floating button to create new test groups.
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Show text field to enter the name of the test group.
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Create new test group"),
                        TextField(
                          autofocus: true,
                          maxLines: 1,
                          controller: _createTestGroupController,
                          decoration: const InputDecoration(
                              hintText: "Test group name"),
                        )
                      ],
                    ),
                    actions: [
                      // Cancel.
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      // Create the test group.
                      ElevatedButton.icon(
                          onPressed: () {
                            // Create new test group
                            setState(() {
                              groups.add(TestGroup(
                                  name: _createTestGroupController.text));
                            });
                            _createTestGroupController.clear();
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Create")),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
