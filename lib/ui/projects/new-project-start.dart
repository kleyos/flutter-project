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
            child: new Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: new Column(
                children: <Widget>[
                  new Text('New project',
                  style: Themes.pageHeader2,
                ),
                  new Text('Please enter project details to get started.',
                  style: Themes.pageHeaderHint
                ),
                  new TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Project name',
                    filled: true,
                    fillColor: Colors.white
                  ),
                  controller: _nameController,
                ),
                  const SizedBox(height: 15.0),
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
              )
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new RaisedButton(
                onPressed: null,
                child: new Text('NEXT', style: Themes.buttonCaption),
                color: Colors.teal
              )
            ]
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: AddJustTitle(),
        centerTitle: true
      ),
      body: new Stack(
        children: <Widget>[
          new BackgroundImage(),
          new Container(
            padding: const EdgeInsets.only(top: 42.0, left: 24.0, right: 24.0),
            child: _buildForm()
          )
        ]
      )
    );
  }
}
