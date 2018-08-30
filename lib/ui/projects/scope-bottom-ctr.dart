import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/services/project-permissions-resolver.dart';
import 'package:add_just/ui/projects/scope-section.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/completed-screen.dart';
import 'package:add_just/ui/themes.dart';

class _ScopeBottomCtrState extends State<ScopeBottomCtr> {
  bool _isCompleted = false;
  VoidCallback _showBottomSheetCallBack;
  final projectPool = new ProjectPool();

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallBack = _showBottomSheet;
  }

  final statusStyling = {
    'created': {
      'mark': 'Work Marked Created',
      'color': Colors.blue
    },
    'work_commenced': {
      'mark': 'Work Commenced',
      'color': Colors.orange
    },
    'marked_completed': {
      'mark': 'Work Marked Completed',
      'color': Colors.cyan
    },
    'completion_cert_issued': {
      'mark': 'Completion Certificate Issued',
      'color': Colors.blue
    },
    'payment_claim_submitted': {
      'mark': 'Paiment Claim Submitted',
      'color': Colors.blue
    },
    'payment_recommendation_issued': {
      'mark': 'Payment Recommendation Issued',
      'color': Colors.green
    },
    'payment_certification_issued': {
      'mark': 'Payment Certification Issued',
      'color': Colors.green
    },
    'invoice_received': {
      'mark': 'Invoice Received',
      'color': Colors.greenAccent
    },
    'paid': {
      'mark': 'Paid',
      'color': Colors.greenAccent
    },
  };

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

  Widget _issueCompletionCertificateButton(isAllChecked) {
    return new RaisedButton(
      child: new Text('ISSUE COMPLETION CERTIFICATE', style: Themes.buttonCaption),
      color: Color.fromRGBO(2, 218, 196, 1.0),
      padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0,),
      onPressed: isAllChecked ? () {
        setState(() { _isCompleted = true; });
        Navigator.pop(context);
      } : null,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(5.0)
      )
    );
  }

  Widget _bottomSheetBuilder(status, isAllChecked) {
    return new Container (
      child: status != 'completion_cert_issued'
        ? _bottomSheetIssueCompletionCertificate(status, isAllChecked)
        :
    )
  }

  Widget _issueCompletionCertificateText(text, _style, flag) {
    return new Text(flag ? text : null, style: _style);
  }
  widget _bottomSheetIssueCompletionCertificate(isAllChecked, status) {
    return new Container(
      child: new Center(
        child: status != 'marked_completed'
          ? _issueCompletionCertificateText(
          'Contractor must mark work completed before you can issue a'
            'completion certificate.',
          Themes.drawerMenuItem,
          true
        )
          : new Column(
          children: <Widget>[
            _issueCompletionCertificateText(
              'You mast check all items'
                'before you can issue a completion certificate.',
              Themes.drawerMenuItem,
              !isAllChecked
            ),
            _issueCompletionCertificateButton(!isAllChecked)
          ]
        )
      ),
    );
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
    final styling = statusStyling[p.status];
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
    return new Column (
      children: <Widget>[
        new Container(
          color: Themes.scopeSectionBackgroundColor,
          padding: EdgeInsets.fromLTRB(30.0, 12.0, 12.0, 12.0),
          child: _buildStatusHeader(s.data)
        ),
        new Expanded(
          child: _listSections(s.data.sections.map((item) => ScopeSection(
            projectId: widget.projectId,
            scopeSection: item,
            permissionsResolver: new ProjectPermissionsResolver(project: s.data),
          )).toList())
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
    );
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

class ScopeBottomCtr extends StatefulWidget {
  ScopeBottomCtr({
    Key key,
    @required this.scaffoldKey,
    @required this.projectId
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final int projectId;

  @override
  State<StatefulWidget> createState() => new _ScopeBottomCtrState();
}
