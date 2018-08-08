import 'package:flutter/material.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';

class NewProjectStart extends StatelessWidget {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _addressController = new TextEditingController();

  Widget _buildForm() {
    return new Form(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new ListView(
              children:  <Widget>[
                new Column(
                  children: <Widget>[
                    new Text('New project', style: Themes.pageHeader2),
                    new Text('Please enter project details to get started.',
                      style: Themes.pageHeaderHint
                    ),
                  ]
                ),
                const SizedBox(height: 16.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Project name',
                    filled: true,
                    fillColor: Colors.white
                  ),
                  controller: _nameController,
                ),
                const SizedBox(height: 16.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Address',
                    filled: true,
                    fillColor: Colors.white
                  ),
                controller: _addressController,
                ),
              ]
            ),
          ),
          new SingleActionButton(caption: 'NEXT', onPressed: null)
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: AddJustTitle(),
        centerTitle: true
      ),
      body: new Stack(
        children: <Widget>[
          new BackgroundImage(),
          new Container(
            padding: const EdgeInsets.all(42.0),
            child: _buildForm()
          )
        ]
      )
    );
  }
}
