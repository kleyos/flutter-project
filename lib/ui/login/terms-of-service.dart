import 'package:flutter/material.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';

typedef void OnAgreePressed();

class TermsOfService extends StatelessWidget {
  TermsOfService({
    Key key,
    this.onAgreePressed
  }) : super(key: key);

  final OnAgreePressed onAgreePressed;
  final String _toc = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam fermentum euismod neque, 
at efficitur ante ullamcorper non. Nulla ut nisl faucibus, faucibus eros a, pharetra nisl.

Morbi ipsum nisi, pharetra at sollicitudin sed, cursus nec elit. Ut volutpat elementum orci, 
sed efficitur neque euismod sit amet. Nulla vel nisl non nisl rutrum dapibus sed quis lorem. 
Mauris rutrum posuere semper. Duis egestas neque finibus ante blandit, et auctor ipsum venenatis. 
Quisque suscipit risus nec augue sollicitudin laoreet.

Nulla non ligula vel dolor aliquam ornare nec vel libero. Donec lobortis luctus tincidunt. 
Mauris quis ligula et tellus fringilla pulvinar. Nullam eu erat urna. Lorem ipsum dolor sit amet, 
consectetur adipiscing elit. Aenean in risus mi. Donec accumsan sapien a sem fermentum blandit.

Nullam molestie ac ante vel feugiat. Mauris vulputate pretium ullamcorper. Proin at euismod odio. 
Lorem ipsum dolor sit amet, consectetur adipiscing elit.

Donec lobortis luctus tincidunt. Mauris quis ligula et tellus fringilla pulvinar. 
Nullam eu erat urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in risus mi. 
Donec accumsan sapien lorem ipsum.""";

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
            padding: const EdgeInsets.only(left: 52.0, right: 52.0),
            child: new Column(
              children: <Widget>[
                const SizedBox(height: 42.0),
                new Text('Terms of Service.',
                  style: Themes.pageHeader2
                ),
                const SizedBox(height: 24.0),
                new Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: new Text(_toc, style: Themes.tocText)
                  ),
                ),
                SingleActionButton(caption: 'I AGREE', onPressed: () { onAgreePressed(); }),
                const SizedBox(height: 40.0),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max
            )
          )
        ]
      )
    );
  }
}
