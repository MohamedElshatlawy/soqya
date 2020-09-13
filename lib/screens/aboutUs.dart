import 'package:flutter/material.dart';

class AboutUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff2fa4e0), title: Text(
        'من نحن',
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'GE-Dinar_One_Medium'),
      ),),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Container(
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width - 50,
                  child: ListView(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Image.asset(
                            'assets/logo2.jpg',
                            height: 150,
                          )),
                      Container(
                          padding: EdgeInsets.all(15),
                          //height: MediaQuery.of(context).size.height / 2.25,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.teal[50],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.topRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'نبذة عن الوزارة',
                                style: TextStyle(
                                    fontFamily: 'GE-Dinar_One_Medium',
                                    color: Color(0xff003d7f), fontSize: 20),
                              ),
                              Text(
                                'تأسست السيف العربية للمشاريع بالمملكة العربية السعودية منذ أكثر من عشرة أعوام من سنة 2006 كإحدى الشركات الرائدة فى مجال لحاسب الآلي في المدينة المنورة قد وضعت عنصر الجودة من أهم عناصر الإنتاج فى مشاريعها مما ساعدها على أكتساب ثقة العملاء وتحقيق المزيد من النجاح وترتب على ذلك أفتتاح فرعها الجديد بجمهورية مصر العربية منذ عام 2016 وذلك لمساعدة المزيد من العملاء حول العالم فى إيجاد حلول رقمية بديلة وأفكار مبتكرة جديدة',
                                style: TextStyle(
                                    fontFamily: 'Mj_Dinar_Two_Light',
                                    color: Color(0xff003d7f).withOpacity(.6),
                                    fontSize: 15),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                        //  height: MediaQuery.of(context).size.height / 5,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.teal[50],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.topRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'رؤيتنا',
                                style: TextStyle(
                                    fontFamily: 'GE-Dinar_One_Medium',
                                    color: Color(0xff003d7f), fontSize: 20),
                              ),
                              Text(
                                'الوصول لأعـلى مستوى مـن حـيث الخـبرة و التخصـص في جـميع مجالات الحاسب الآلي والشبكات',
                                style: TextStyle(
                                    fontFamily: 'Mj_Dinar_Two_Light',
                                    color: Color(0xff003d7f).withOpacity(.6),
                                    fontSize: 18),
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
