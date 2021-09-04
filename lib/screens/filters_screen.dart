import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;

  @override
  initState() {
   
    _isGlutenFree = widget.currentFilters['gluten'];
    _isLactoseFree = widget.currentFilters['lactose'];
    _isVegan = widget.currentFilters['vegan'];
    _isVegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String desc, bool currentBoolValue, Function changeValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentBoolValue,
      subtitle: Text(
        desc,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      onChanged: changeValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final savedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegan': _isVegan,
                'vegetarian': _isVegetarian,
              };
              widget.saveFilters(savedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
        title: Text('Your filters'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 15),
          Container(
            alignment: Alignment.center,
            child: Text('Adjust your meal selection',
                style: Theme.of(context).textTheme.headline6),
          ),
          _buildSwitchListTile(
            'Gluten-Free',
            'Only includes gluten-free meals',
            _isGlutenFree,
            (newBoolValue) {
              
              setState(() {
                _isGlutenFree = newBoolValue;
              });
            },
          ),
          _buildSwitchListTile(
            'Lactose-Free',
            'Only includes lactose-free meals',
            _isLactoseFree,
            (newBoolValue) {
             
              setState(() {
                _isLactoseFree = newBoolValue;
              });
            },
          ),
          _buildSwitchListTile(
            'Vegetarian',
            'Only includes vegetarian meals',
            _isVegetarian,
            (newBoolValue) {
             
              setState(() {
                _isVegetarian = newBoolValue;
              });
            },
          ),
          _buildSwitchListTile(
            'Vegan',
            'Only includes vegan meals',
            _isVegan,
            (newBoolValue) {
             
              setState(() {
                _isVegan = newBoolValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
