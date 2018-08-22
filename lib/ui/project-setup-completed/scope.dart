import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/project-setup-completed/scope-section.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/completed-screen.dart';
import 'package:add_just/ui/themes.dart';

class _ScopeState extends State<Scope> {
  bool _isCompleted = false;
  VoidCallback _showBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallBack = _showBottomSheet;
  }

  final List<Map> marks = [
    {
      'status': 'marked_completed',
      'mark': 'Work Marked Completed',
      'color': Colors.cyan
    },
    {
      'status': 'work_comenced',
      'mark': 'Work Comenced',
      'color': Colors.orange
    },
    {
      'status': 'completion_issued',
      'mark': 'Work Marked Completed',
      'color': Colors.blue
    },
    {
      'status': 'created',
      'mark': 'Work Marked Created',
      'color': Colors.blue
    },
  ];

  Map _defineMark(status) {
    return marks.firstWhere((item) => item['status'] == status, orElse: () =>
    {
      'status': ' ',
      'mark': ' ',
      'color': Colors.black12
    });
  }

  Widget _buildLid(color) {
    return new Container(
      margin: EdgeInsets.only(right: 10.0),
      width: 10.0,
      height: 10.0,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  List<ScopeSection> _loadSections() {
    return widget.currentProject.sections.map((item) => ScopeSection(scopeSection: item)).toList();
  }

  Widget _listSections(List<ScopeSection> sections) {
    return new ListView.builder(
      reverse: false,
      itemBuilder: (_, int idx) => sections[idx],
      itemCount: sections.length,
    );
  }

  Widget _issueCompletionCertificateButton() {
    return new RaisedButton(
      child: new Text('ISSUE COMPLETION CERTIFICATE', style: Themes.buttonCaption),
      color: Color.fromRGBO(2, 218, 196, 1.0),
      padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0,),
      onPressed: () {
        setState(() { _isCompleted = true; });
        Navigator.pop(context);
        },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(5.0)
      )
    );
  }

  Widget _issueCompletionCertificateText(text, _style) {
    return new Text(text, style: _style);
  }

  void _showBottomSheet() {
    setState(() {
      _showBottomSheetCallBack = null;
    });

    widget.scaffoldKey.currentState.showBottomSheet((context) {
      return new Container(
        height: 200.0,
        color: Colors.teal,
        child: new Center(
          child: _issueCompletionCertificateButton()
        )
      );
    });
  }

  Widget _buildMainContent() {
    return new Stack(
      children: <Widget>[
        BackgroundImage(),
        new Container(
          child: new Column (
            children: <Widget>[
              new Container(
                color: Color.fromRGBO(224, 224, 224, 1.0),
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(top: 16.0),
                child: new Row(
                  children: <Widget>[
                    _buildLid(_defineMark(widget.currentProject.status)['color']),
                    new Text(_defineMark(widget.currentProject.status)['mark'],
                      style: TextStyle(
                        color: _defineMark(widget.currentProject.status)['color'])
                    )
                  ]
                )
              ),
              new Expanded(
                child: _listSections(_loadSections())
              ),
              new InkWell(
                onTap: _showBottomSheetCallBack,
                child: new Container(
                  color: Colors.teal,
                    padding: const EdgeInsets.all(16.0),
                    child: new Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _issueCompletionCertificateText('ISSUE COMPLETION CERTIFICATE', Themes.buttonCaption),
                      ],
                    )
                )
              )
            ],
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isCompleted
      ? CompletedScreen(screenText: "Completion Cetificate Issued")
      : _buildMainContent();
  }
}

class Scope extends StatefulWidget {
  Scope({
    Key key,
    @required this.scaffoldKey,
    @required this.currentProject
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Project currentProject;

  @override
  State<StatefulWidget> createState() => new _ScopeState();
}
