import 'package:flutter/material.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/projects/new-project-area.dart';

class _NewProjectStartState extends State<NewProjectStart> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _addressController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool get canDoNext => _formKey.currentState != null && _formKey.currentState.validate();

  void _handleNext() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext c) => new NewProjectArea(user: widget.user))
    );
  }

  Function _nextPress() {
    return canDoNext ? () { _handleNext(); } : null;
  }

  Widget _buildForm() {
    return new Form(
      key: _formKey,
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      return;
                    }
                  },
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
              ]
            ),
          ),
          new SingleActionButton(caption: 'NEXT', onPressed: _nextPress())
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

class NewProjectStart extends StatefulWidget {
  NewProjectStart({Key key, this.user}) : super(key: key);
  final User user;

  @override
  State<StatefulWidget> createState() => new _NewProjectStartState();
}
