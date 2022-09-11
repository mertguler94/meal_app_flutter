import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FilterScreen(this.currentFilters, this.saveFilters, {Key? key})
      : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose']!;
  }

  Widget _buildSwitchTile(String title, String description, bool currentValue,
      void Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
      activeColor: Theme.of(context).colorScheme.secondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: (() {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian
                };

                widget.saveFilters(selectedFilters);

                Timer? timer = Timer(const Duration(milliseconds: 1000), () {
                  Navigator.of(context).pushReplacementNamed('/');
                  // Navigator.of(context, rootNavigator: true).pop();
                });

                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(content: Text('Filters saved.'));
                    }).then((value) {
                  Navigator.of(context).pushReplacementNamed('/');
                  // dispose the timer in case something else has triggered the dismiss.
                  timer?.cancel();
                  timer = null;
                });
              }),
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchTile(
                  'Gluten-free', 'Only include gluten-free meals', _glutenFree,
                  ((value) {
                setState(() {
                  _glutenFree = value;
                });
              })),
              _buildSwitchTile('Lactose-free',
                  'Only include lactose-free meals', _lactoseFree, ((value) {
                setState(() {
                  _lactoseFree = value;
                });
              })),
              _buildSwitchTile(
                  'Vegetarian', 'Only include vegetarian meals', _vegetarian,
                  ((value) {
                setState(() {
                  _vegetarian = value;
                });
              })),
              _buildSwitchTile('Vegan', 'Only include vegan meals', _vegan,
                  ((value) {
                setState(() {
                  _vegan = value;
                });
              })),
            ],
          ))
        ],
      ),
    );
  }
}
