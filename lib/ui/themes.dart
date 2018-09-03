import 'package:flutter/material.dart';

class Themes {
  static final mainTitleLight = new TextStyle(
    fontSize: 25.0,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w300
  );

  static final mainTitleBold = new TextStyle(
    fontSize: 25.0,
    fontFamily: 'Lato',
    fontWeight: FontWeight.bold
  );

  static final pageHeader = new TextStyle(
    fontSize: 45.0,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300
  );

  static final pageHeader2 = new TextStyle(
    fontSize: 25.0,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300
  );

  static final pageHeaderHint = new TextStyle(
    fontSize: 12.0,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300
  );

  static final buttonCaption = new TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    letterSpacing: 1.2
  );

  static final tocText = new TextStyle(
    fontSize: 12.0
  );

  static final summaryCaption = new TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold
  );

  static final summaryData = new TextStyle(
    fontSize: 16.0
  );

  static final projectListTitle = new TextStyle(
    fontSize: 25.0,
    color: Color.fromRGBO(0, 150, 130, 1.0)
  );

  static final projectListSubtitle = new TextStyle(
    fontSize: 13.0,
    color: Colors.black54
  );

  static final drawerMenuHeader = new TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18.0,
    color: Color.fromRGBO(3, 218, 196, 1.0),
    letterSpacing: 1.2
  );

  static final drawerMenuItem = new TextStyle(
    fontFamily: 'Roboto',
    fontSize: 15.0,
    color: Colors.white,
    letterSpacing: 1.2
  );

  static final popupDialogAction = new TextStyle(
    fontSize: 17.0,
    color: Colors.teal,
    fontStyle: FontStyle.italic
  );

  static final projectSectionTitle = new TextStyle(
    fontSize: 16.0,
    color: Colors.black54,
    letterSpacing: 1.2
  );

  static final projectSectionNum = new TextStyle(
    fontSize: 16.0,
    color: Colors.teal,
    letterSpacing: 1.2
  );

  static final boqCategoryTitle = new TextStyle(
    fontSize: 16.0
  );

  static final boqCategoryTitleHeader = new TextStyle(
    fontSize: 16.0,
    color: Colors.teal
  );

  static final boqItemTitle = new TextStyle(
    fontSize: 23.0,
    color: Colors.teal
  );

  static final sectionItemTitle = new TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.bold
  );
  
  static final scopeSectionItemName = new TextStyle(
    fontSize: 18.0,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w800
  );

  static final scopeItemSmallMeasure = new TextStyle(
    fontSize: 13.0,
    color: Colors.grey
  );

  static final scopeItemPrice = new TextStyle(
    fontSize: 15.0,
    color: Colors.grey
  );

  static final scopeItemPriceTotalCaption = new TextStyle(
    fontSize: 8.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold
  );

  static final dialogText = new TextStyle(
    fontSize: 18.0,
    color: Colors.black26
  );

  static final scopeSectionBackgroundColor = Color.fromRGBO(224, 224, 224, 1.0);

  static final statusStyling = {
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
      'mark': 'Completion cert issued',
      'color': Colors.blue
    },
    'payment_claim_submitted': {
      'mark': 'Payment claim submitted',
      'color': Colors.brown
    },
    'payment_recommendation_issued': {
      'mark': 'Payment recommendation issued',
      'color': Colors.brown
    },
    'payment_certification_issued': {
      'mark': 'Payment certification issued',
      'color': Colors.brown
    },
    'invoice_received': {
      'mark': 'Invoice received',
      'color': Colors.brown
    },
    'paid': {
      'mark': 'Paid',
      'color': Colors.green
    },
  };
}
