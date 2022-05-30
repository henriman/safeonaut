import 'package:flutter/material.dart';
import 'package:safeonaut/src/drug-testing/models/test_group.dart';
import 'package:safeonaut/src/drug-testing/widgets/testgroup_detailedview.dart';
import 'package:safeonaut/src/settings/settings_controller.dart';

// TODO: change to expansionpanel to collapse panel when other panel is clicked
// TODO: add error to textfield when left empty. also for the alertdialog textfield
// TODO: change "hitbox" of panel to open detailed view. right now above and below the textfield there is a little space where the tile will just expand
// TODO: unfocus correctly. right now, focus doesnt change when clicking on another expansion tile
class TestGroupTile extends StatefulWidget {
  final SettingsController settingsController;

  final TestGroup _testGroup;
  final Function delete;

  const TestGroupTile({
    Key? key,
    required this.settingsController,
    required testGroup,
    required this.delete,
  })  : _testGroup = testGroup,
        super(key: key);

  @override
  createState() => _TestGroupTileState();
}

/// A tile which shows an overview of a [_testGroup].
class _TestGroupTileState extends State<TestGroupTile> {
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final ScrollController _titleScroll = ScrollController();
  bool _enableTextField = false;

  @override
  void dispose() {
    _titleFocus.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _titleController.text = widget._testGroup.name;
  }

  // Open the detailed view of this test group.
  void _openDetailedView() => Navigator.pushNamed(
        context,
        TestGroupDetailedView.routeName,
        arguments: widget._testGroup,
      );

  @override
  Widget build(BuildContext context) {
    // Put the selection at the end of the title when renaming.
    _titleController.selection =
        TextSelection.collapsed(offset: _titleController.text.length);
    // If the title text field loses focus
    // 1. set the title to the test group name (reverting changes which have not been saved),
    // 2. disable the text field again to stop editing,
    // 3. scroll to the beginning of the string.
    _titleFocus.addListener(() {
      if (!_titleFocus.hasFocus) {
        setState(() {
          _titleController.text = widget._testGroup.name;
          _enableTextField = false;
          _titleScroll.jumpTo(0);
        });
      }
    });

    return Card(
      child: ExpansionTile(
        // TODO: stop it from changing color
        title: TextField(
          readOnly: !_enableTextField,
          // Update the name.
          onSubmitted: (value) => {
            if (value.isNotEmpty) {widget._testGroup.name = value}
          },
          // If not currently renaming, open the detailed view.
          onTap: () => {
            if (!_enableTextField) {_openDetailedView()}
          },
          maxLines: 1,
          controller: _titleController,
          scrollController: _titleScroll,
          focusNode: _titleFocus,
          enableInteractiveSelection: _enableTextField,
          style: const TextStyle(fontWeight: FontWeight.bold),
          // TODO: change to filled when editing
          decoration: const InputDecoration(
            hintText: "Test group name",
            border: InputBorder.none,
            // TODO: add clear button
            /*suffixIconConstraints: BoxConstraints(minWidth: 2, minHeight: 2),
            suffixIcon:
                (_titleController.text.isNotEmpty && _titleFocus.hasFocus)
                    ? IconButton(
                        onPressed: _titleController.clear,
                        icon: const Icon(Icons.clear, size: 20),
                      )
                    : null,*/
          ),
        ),
        children: [
          // Actions to perform on this test group.
          Container(
            color: (widget.settingsController.themeMode == ThemeMode.light)
                ? const Color(0xFFEEEEEE)
                : Colors.grey[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Open the detailed view of this test group.
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary:
                        (widget.settingsController.themeMode == ThemeMode.light)
                            ? const Color(0xFF666666)
                            : Colors.grey[850]
                  ),
                  onPressed: () => _openDetailedView(),
                  icon: const Text("Open"),
                  label: const Icon(Icons.open_in_browser, size: 20),
                ),
                // Start renaming the test group.
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary:
                        (widget.settingsController.themeMode == ThemeMode.light)
                            ? const Color(0xFF666666)
                            : Colors.grey[850]
                  ),
                  // Enable the test field and focus it.
                  onPressed: () {
                    setState(() {
                      _enableTextField = true;
                      _titleFocus.requestFocus();
                    });
                  },
                  icon: const Text("Rename"),
                  label: const Icon(Icons.edit, size: 20),
                ),
                // Delete the test group.
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary:
                        (widget.settingsController.themeMode == ThemeMode.light)
                            ? const Color(0xFF666666)
                            : Colors.grey[850]
                  ),
                  onPressed: () => widget.delete(),
                  icon: const Text("Delete"),
                  label: const Icon(Icons.delete, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
