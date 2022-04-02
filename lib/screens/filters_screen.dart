import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(this.currentFilters, this.saveFilters, {Key? key})
      : super(key: key);
  static const String routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;

    super.initState();
  }

  Widget _buildSwitchListTile({
    required String title,
    required String description,
    required bool currentValue,
    required Function updateValue,
  }) {
    return SwitchListTile(
      activeColor: Colors.amber,
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectFilter = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectFilter);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Text('Adjust your meal selection',
                style: Theme.of(context).textTheme.caption),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                title: 'Gluten-Free',
                description: 'Only incude Gluten-Free meals',
                currentValue: _glutenFree,
                updateValue: () => (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                title: 'Vegetarian',
                description: 'Only incude Vegetarian meals',
                currentValue: _vegetarian,
                updateValue: () => (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                title: 'Vegan',
                description: 'Only incude Vegan meals',
                currentValue: _vegan,
                updateValue: () => (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                title: 'Lactose-Free',
                description: 'Only incude Lactose-Free meals',
                currentValue: _lactoseFree,
                updateValue: () => (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              )
            ],
          )),
        ],
      ),
    );
  }
}
