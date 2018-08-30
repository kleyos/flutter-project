import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/services/project-permissions-resolver.dart';
import 'package:add_just/ui/projects/scope-bottom-amo.dart';
import 'package:add_just/ui/projects/scope-bottom-ctr.dart';
import 'package:add_just/ui/projects/scope-section.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/themes.dart';

class _ScopeShowState extends State<ScopeShow> {
  final projectPool = new ProjectPool();
  VoidCallback _showBottomSheetCallBack;

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


  Widget _listSections(List<ScopeSection> sections) {
    return new ListView.builder(
      reverse: false,
      itemBuilder: (_, int idx) => sections[idx],
      itemCount: sections.length,
    );
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

  void _showBottomSheet() {
    widget.scaffoldKey.currentState.showBottomSheet((context) {
      return new Container(
        height: 200.0,
        color: Colors.teal,
        child: new Center(
          child: widget.userRole == 'ctr'
            ? ScopeBottomCtr()
            : ScopeBottomAmo()
        )
      );
    });
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
                new Text('ISSUE COMPLETION CERTIFICATE', style: Themes.buttonCaption),
              ],
            )
          )
        )
      ]
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
    return _buildMainContent();
  }
}

class ScopeShow extends StatefulWidget {
  ScopeShow({
    Key key,
    @required this.userRole,
    @required this.scaffoldKey,
    @required this.projectId
  }) : super(key: key);

  final String userRole;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int projectId;

  @override
  State<StatefulWidget> createState() => new _ScopeShowState();
}
