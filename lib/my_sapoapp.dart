
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MySapoApp extends StatefulWidget {
  const MySapoApp({super.key});

  @override
  State<MySapoApp> createState() => _MySapoAppState();
}
Color colorMain = Color(0xFF434e75);

class _MySapoAppState extends State<MySapoApp> {

  List<MenuItemBottom> lsMenuItemBottom = [
    MenuItemBottom(iconData: Icons.note_alt_rounded, title: "Đơn", color: Colors.blue),
    MenuItemBottom(iconData: Icons.table_restaurant_rounded, title: "Bàn"),
    MenuItemBottom(iconData: FontAwesomeIcons.sackDollar, title: "Thanh toán"),
  ];

  List<cateItem> lsCate = [
    cateItem(icon: Icons.category, color: colorMain, name: "Quản lý danh mục"),
    cateItem(icon: FontAwesomeIcons.bowlFood, color: colorMain, name: "Quản lý món ăn"),
    cateItem(icon: Icons.account_circle, color: colorMain, name: "Quản lý tài khoản"),
    cateItem(icon: FontAwesomeIcons.moneyCheckDollar, color: colorMain, name: "Quản lý hóa đơn"),
    cateItem(icon: Icons.bar_chart, color: colorMain, name: "Thống kê báo cáo"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.fromLTRB(120, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assest/sapo.png'),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              Container(
                child: IconButton(
                    onPressed: (){

                    },
                    icon: Icon(FontAwesomeIcons.solidBell),
                    color: Colors.grey, iconSize: 20,
                ),
              )
            ],
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
      ),
      drawer: new Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        image: DecorationImage(
                            image: AssetImage('assest/cang.jpg'),fit: BoxFit.cover
                        ),
                      ),
                    ),
                    // Tạo thanh ngang
                    Container( // tạo thanh ngang
                      height: 1,
                      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, style: BorderStyle.solid),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        leading: FloatingActionButton(
                          onPressed: (){

                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: AssetImage('assest/cang.jpg'),fit: BoxFit.cover,
                                )
                            ),
                          ),
                        ),
                        title: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Text('Hùng',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: colorMain),
                                ),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              ),
                              Container(
                                child: Text('Quản lý',
                                  style: TextStyle(color: colorMain, fontSize: 13),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                color: Color(0xFFe0f2ff),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
              ),
              // Tạo thanh ngang
              Container( // tạo thanh ngang
                height: 1,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, style: BorderStyle.solid),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                child:
                    Row(
                      children: [
                        Text("Quản lý nhà hàng",
                          style: TextStyle(fontWeight: FontWeight.bold, color: colorMain),
                        ),
                    ],
                )
              ),
              Container(
                child: Column(
                  children: lsCate.map((e){
                    return ListTile(
                      onTap: (){

                      },
                      leading: IconButton(
                        onPressed: (){

                        },
                        icon: Icon(e.icon, color: e.color),
                      ),
                      title: Text(e.name,
                      style: TextStyle(
                        color: e.color,
                      ),
                      ),
                    );
                  }).toList(),
                ),
              ),

            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Row(
            children: [
             Container(
               child: Column(
                 children: [

                 ],
               ),
             ),
              Container(
                child: Column(
                  children: [

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: FloatingActionButton.extended(
          label: Text(
            "Tạo đơn",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF2ad38b),
          onPressed: () {

          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index){

        },
        items: lsMenuItemBottom.map((e){
          return BottomNavigationBarItem(
            icon: Icon(
              e.iconData,
              color: e.color,
            ),
            label: e.title,
            backgroundColor: Colors.white,
          );
        }).toList(),
      ),

    );
  }
}

class MenuItemBottom{
  late IconData iconData; // late khai báo biến chưa được khởi tạo
  late Color color; // Color là thuộc tính không bắc buộc
  late String title;
  MenuItemBottom(
      {
        required this.iconData,
        this.color = Colors.grey,
        required this.title,
      }
      );
}

class cateItem{
  late IconData icon;
  late Color color;
  late String name;
  cateItem(
        {
          required this.icon,
          required this.color,
          required this.name,
        }
      );
}
