import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff2fa4e0), title: Text(
        'عن المطور',
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'GE-Dinar_One_Medium'),
      ),),
      body: Container(
        /*decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.fill)),
       */
        child: Stack(
          children: <Widget>[
            Container(
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 25),
                        height: 100,
                        child: Image.asset('assets/sit.png'),
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.teal[50]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'فرع القاهرة',
                                style: TextStyle(
                                  color: Color(0xff003d7f),
                                  fontSize: 18,
                                  fontFamily: 'GE-Dinar_One_Medium',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'جمهورية مصر العربية - القاهرة \n 40 ش عبد العزيز فهمي - مصر الجديدة',
                                style: TextStyle(
                                    fontFamily: 'GE_Dinar_One_Light',
                                    color: Color(0xff003d7f),
                                    fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'الهاتف',
                                style: TextStyle(
                                  color: Color(0xff003d7f),
                                  fontSize: 18,
                                  fontFamily: 'GE-Dinar_One_Medium',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 40,
                                child: ListTile(
                                  onTap: () {
                                    launch("tel://+201099792707");
                                  },
                                  title: Text(
                                    '201099792707+',
                                    style: TextStyle(
                                      color: Color(0xff003d7f).withOpacity(.7),
                                      fontSize: 15,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.call,
                                    size: 18,
                                    color: Color(0xff003d7f),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: ListTile(
                                  onTap: () {
                                    launch("tel://+966148674444");
                                  },
                                  title: Text(
                                    '966148674444+',
                                    style: TextStyle(
                                      color: Color(0xff003d7f).withOpacity(.7),
                                      fontSize: 15,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.call,
                                    size: 18,
                                    color: Color(0xff003d7f),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: ListTile(
                                  onTap: () {
                                    launch("tel://+966148673444");
                                  },
                                  title: Text(
                                    '966148673444+',
                                    style: TextStyle(
                                      color: Color(0xff003d7f).withOpacity(.7),
                                      fontSize: 15,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.call,
                                    size: 18,
                                    color: Color(0xff003d7f),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: ListTile(
                                  onTap: () {
                                    launch("tel://+202226350113");
                                  },
                                  title: Text(
                                    '202226350113+',
                                    style: TextStyle(
                                      color: Color(0xff003d7f).withOpacity(.7),
                                      fontSize: 15,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.call,
                                    size: 18,
                                    color: Color(0xff003d7f),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.teal[50]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'فرع السعودية',
                                style: TextStyle(
                                  color: Color(0xff003d7f),
                                  fontSize: 18,
                                  fontFamily: 'GE-Dinar_One_Medium',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'المملكة العربية السعودية - المدينة المنورة - قربان',
                                style: TextStyle(
                                    fontFamily: 'GE_Dinar_One_Light',
                                    color: Color(0xff003d7f),
                                    fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'الهاتف',
                                style: TextStyle(
                                  color: Color(0xff003d7f),
                                  fontSize: 18,
                                  fontFamily: 'GE-Dinar_One_Medium',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 40,
                                child: ListTile(
                                  onTap: () {
                                    launch("tel://+966148260999");
                                  },
                                  title: Text(
                                    '966148260999+',
                                    style: TextStyle(
                                      color: Color(0xff003d7f).withOpacity(.7),
                                      fontSize: 15,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.call,
                                    size: 18,
                                    color: Color(0xff003d7f),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: ListTile(
                                  onTap: () {
                                    launch("tel://+966148250999");
                                  },
                                  title: Text(
                                    '966148250999+',
                                    style: TextStyle(
                                      color: Color(0xff003d7f).withOpacity(.7),
                                      fontSize: 15,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.call,
                                    size: 18,
                                    color: Color(0xff003d7f),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

cards({
  String title,
  String desc,
}) {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    child: Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(title,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(desc,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 15,
                )),
          ],
        ),
      ),
    ),
  );
}
