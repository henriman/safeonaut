import 'package:flutter/material.dart';
import 'package:safeonaut/src/drug-testing/models/reagents/reagents.dart';
import 'package:safeonaut/src/drug-testing/models/test_group.dart';
import 'package:safeonaut/src/drug-testing/widgets/reagent_test_tile.dart';
import 'package:safeonaut/src/drug-testing/widgets/test-view/test_view.dart';
import 'package:safeonaut/src/models/substances.dart';
import 'package:safeonaut/src/settings/settings_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class TestGroupDetailedView extends StatefulWidget {
  static const routeName = "/detail";

  final SettingsController settingsController;
  final TestGroup testGroup;

  const TestGroupDetailedView({
    Key? key,
    required this.settingsController,
    required this.testGroup,
  }) : super(key: key);

  @override
  createState() => _TestGroupDetailedViewState();
}

class _TestGroupDetailedViewState extends State<TestGroupDetailedView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Reagent? _dropdownValue;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController
        .addListener(() => setState(() {})); // Rebuild when switching tabs.
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.testGroup.name),
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Theme.of(context).colorScheme.background,
            boxShadow: kElevationToShadow[1],
          ),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.insert_chart_outlined_outlined),
                  SizedBox(width: 5),
                  Text("Results")
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.water_drop_outlined),
                  SizedBox(width: 5),
                  Text("Tests")
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            itemCount: widget.testGroup.getResults().length + 1,
            itemBuilder: (context, i) {
              if (widget.testGroup.getResults().isEmpty) {
                return const Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 15),
                  child: Text(
                    "The results of your tests don't match any substance. Please redo the tests and make sure to follow the instructions.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                );
              }

              if (i == 0) {
                return const Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 15),
                  child: Text(
                    "Given the results of the tests you have conducted, your substance is likely one of the following:",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                );
              }
              // Sort alphabetically.
              List<Substance> subs = widget.testGroup.getResults().toList()
                ..sort((s1, s2) => s1.name.compareTo(s2.name));
              Substance substance = subs.elementAt(i - 1);
              return Card(
                child: ListTile(
                  title: Text(
                    substance.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: (substance.wikiLink == null)
                      ? null
                      : IconButton(
                          onPressed: () => launchUrl(substance.wikiLink!),
                          icon: const Icon(Icons.launch),
                        ),
                ),
              );
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            itemCount: widget.testGroup.tests.length + 1,
            itemBuilder: (context, i) {
              // TODO: kinda hacky
              if (i == 0) {
                return const Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 15),
                  child: Text(
                    "These are the tests you have conducted.",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
              return ReagentTestTile(
                settingsController: widget.settingsController,
                test: widget.testGroup.tests[i - 1],
              );
            },
          ),
        ],
      ),
      floatingActionButton: (_tabController.index == 1)
          ? FloatingActionButton.extended(
              label: const Text("Conduct new test"),
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    // TODO: give hint when no more tests are left to do
                    return StatefulBuilder(builder: (context, dialogState) {
                      // Is _dropdownValue valid?
                      if (widget.testGroup.tests
                          .any((t) => t.reagent == _dropdownValue)) {
                        _dropdownValue = null;
                      }
                      return AlertDialog(
                        title: const Text("Conduct a new test."),
                        content: DropdownButton(
                          isExpanded: true,
                          icon: const Icon(Icons.water_drop),
                          hint: const Text("Reagent"),
                          value: _dropdownValue,
                          items: reagents.values
                              .where((r) => !widget.testGroup.tests
                                  .any((t) => t.reagent == r))
                              .map((r) {
                            return DropdownMenuItem(
                              value: r,
                              child: Text(r.name),
                            );
                          }).toList(),
                          onChanged: (Reagent? value) {
                            dialogState(() {
                              _dropdownValue = value;
                            });
                          },
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton.icon(
                            icon: const Text("Start testing"),
                            label: const Icon(Icons.arrow_forward),
                            onPressed: (_dropdownValue == null)
                                ? null
                                : () {
                                    if (_dropdownValue != null) {
                                      Navigator.pushNamed(
                                        context,
                                        TestView.routeName,
                                        arguments: TestViewArgument(
                                          testGroup: widget.testGroup,
                                          reagent: _dropdownValue!,
                                        ),
                                      ).then((_) {
                                        _tabController.animateTo(0);
                                      }); // Show results page.
                                    }
                                  },
                          )
                        ],
                      );
                    });
                  },
                );
              },
            )
          : null,
    );
  }
}
