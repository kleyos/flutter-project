import 'package:flutter/material.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/services/project-permissions-resolver.dart';
import 'package:add_just/ui/projects/scope-section.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/completed-screen.dart';
import 'package:add_just/ui/themes.dart';

class _ScopeShowState extends State<ScopeShow> {
  bool _isCompleted = false;
  VoidCallback _showBottomSheetCallBack;
  final projectPool = new ProjectPool();

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallBack = _showBottomSheet;
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

  Widget _buildStatusHeader(Project p) {
    final styling = Themes.statusStyling[p.status ?? 'error'];
    return styling.isNotEmpty
      ? new Row(
        children: <Widget>[
          _buildLid(styling['color']),
          new Text(styling['mark'], style: TextStyle(color: styling['color']))
        ]
      )
      : new SizedBox();
  }

  Widget _buildScopeView(BuildContext ctx, AsyncSnapshot<Project> s) {
    if (s.connectionState != ConnectionState.done) {
      return new Center(child: CircularProgressIndicator());
    }

    List<Widget> items = [];
    final permissionsResolver = new ProjectPermissionsResolver(project: s.data);

    if (Account.current.isAMO) {
      items.add(new Container(
        color: Themes.scopeSectionBackgroundColor,
        padding: EdgeInsets.fromLTRB(30.0, 12.0, 12.0, 12.0),
        child: _buildStatusHeader(s.data)
      ));
    } else {
      items.add(new SizedBox(height: 24.0));
    }

    var sections = s.data.sections;

    if (s.data.additions != null) {
      sections.add(s.data.additions);
    }

    items.add(new Expanded(
      child: _listSections(sections.map((item) => ScopeSection(
        projectId: widget.projectId,
        scopeSection: item,
        permissionsResolver: new ProjectPermissionsResolver(project: s.data),
        scaffoldKey: widget.scaffoldKey
      )).toList())
    ));

    if (permissionsResolver.canIssueCompletionCertificate) {
      items.add(new InkWell(
        onTap: _showBottomSheetCallBack,
        child: new Container(
          color: Colors.teal,
          padding: const EdgeInsets.all(16.0),
          child: new Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _issueCompletionCertificateText(
                'ISSUE COMPLETION CERTIFICATE', Themes.buttonCaption)
            ]
          )
        )
      ));
    }

    return new Column(children: items);
  }

  Widget _buildMainContent() {
    return new Stack(
      children: <Widget>[
        BackgroundImage(),
        new Container(
          child: new FutureBuilder(
            builder: _buildScopeView,
            future: projectPool.getById(widget.projectId)
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

class ScopeShow extends StatefulWidget {
  ScopeShow({
    Key key,
    @required this.scaffoldKey,
    @required this.projectId
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final int projectId;

  @override
  State<StatefulWidget> createState() => new _ScopeShowState();
}
