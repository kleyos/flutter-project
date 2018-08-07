import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:flutter/material.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';

class NewProjectStart extends StatelessWidget {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _addressController = new TextEditingController();

  Widget _buildForm() {
    return new Form(
      child: new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: new Column(
              children: <Widget>[
                new Text('New project',
                  style: Themes.pageHeader2,
                ),
                new Text('Please enter project details to get started.',
                  style: Themes.pageHeaderHint
                ),
                const SizedBox(height: 58.0),
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
//          new Row(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              SingleActionButton(caption: 'NEXT', onPressed: null)
//            ]
//          )
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
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: _buildForm()
          )
        ]
      )
    );
  }
}
