import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(5, 5),
                      blurRadius: 10),
                ],
              ),
              child: IconShadowWidget(
                Icon(
                  Icons.wb_sunny,
                  color: Theme.of(context).toggleableActiveColor,
                ),
                shadowColor: Colors.black26,
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: <Widget>[
              Text(
                'JBL Audio',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'E-SERIES Headphone',
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '\$50',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                  Flexible(
                    flex: 30,
                    child: Image.asset('assets/preview_image.png'),
                  ),
                  Flexible(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                ],
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconShadowWidget(
                      Icon(
                        Icons.star,
                        color: Theme.of(context).toggleableActiveColor,
                        size: 30,
                      ),
                      shadowColor: Colors.black26,
                    ),
                    IconShadowWidget(
                      Icon(
                        Icons.star,
                        color: Theme.of(context).toggleableActiveColor,
                        size: 30,
                      ),
                      shadowColor: Colors.black26,
                    ),
                    IconShadowWidget(
                      Icon(
                        Icons.star,
                        color: Theme.of(context).toggleableActiveColor,
                        size: 30,
                      ),
                      shadowColor: Colors.black26,
                    ),
                    IconShadowWidget(
                      Icon(
                        Icons.star,
                        color: Theme.of(context).cursorColor,
                        size: 30,
                      ),
                      shadowColor: Colors.black26,
                    ),
                    IconShadowWidget(
                      Icon(
                        Icons.star,
                        color: Theme.of(context).cursorColor,
                        size: 30,
                      ),
                      shadowColor: Colors.black26,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).buttonColor.withOpacity(0.2),
                        offset: Offset(0, -20),
                        blurRadius: 20),
                  ],
                ),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  color: Theme.of(context).hintColor,
                  elevation: 0,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Add to bag',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).toggleableActiveColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
