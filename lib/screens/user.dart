import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../providers/dart_theme_provider.dart';
import '../widgets/text_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                    text: 'Hi,  ',
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'My Name',
                          style: TextStyle(
                            fontSize: 25,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('my address here');
                            }),
                    ]),
              ),
              SizedBox(
                height: 2,
              ),
              TextWidget(text: 'Email@email.com', color: color, textSize: 16),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
              ),
              // ListTile(
              //   title: Text('Address', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
              //     ,),
              //   subtitle: Text('subtitle here..'),
              //   leading: Icon(IconlyLight.profile),
              //   trailing: Icon(IconlyLight.arrowRight2),
              // ),
              SizedBox(
                height: 20,
              ),
              //User Details
              _ListTiles(
                title: 'Address 2',
                subtitle: 'subtitle here..',
                icon: IconlyLight.profile,
                onPressed: () async {
                 await _showAddressDailog();
                },
                color: color,
              ),
              _ListTiles(
                title: 'Orders',
                icon: IconlyLight.bag,
                onPressed: () {},
                color: color,
              ),
              _ListTiles(
                title: 'Wishlist',
                icon: IconlyLight.heart,
                onPressed: () {},
                color: color,
              ),
              _ListTiles(
                title: 'Viewed',
                icon: IconlyLight.show,
                onPressed: () {},
                color: color,
              ),
              _ListTiles(
                title: 'Forget Password',
                icon: IconlyLight.unlock,
                onPressed: () {},
                color: color,
              ),
              // Dark and Light mode function
              SwitchListTile(
                title: TextWidget(
                  text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                  color: color,
                  textSize: 18,
                  // isTitle: true,
                ),
                secondary: Icon(themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                onChanged: (bool value) {
                  setState(() {
                    themeState.setDarkTheme = value;
                  });
                },
                value: themeState.getDarkTheme,
              ),
              _ListTiles(
                title: 'Logout',
                icon: IconlyLight.logout,
                onPressed: () {
                  _showLogoutDailog();
                },
                color: color,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _showLogoutDailog() async {
    await showDialog(
        context: context,
        builder: (context){
      return AlertDialog(
        title: Row(children: [
          Image.asset('assets/images/warning-sign.png',
          height: 20,
          width: 20,
          fit: BoxFit.fill,
          ),
          SizedBox(width: 8,),
          Text('Sign out')
        ]),
        content: Text('Do you wanna sign out?'),
        actions: [
          TextButton(onPressed: (){
            if(Navigator.canPop(context)){
              Navigator.canPop(context);
            }
          },
              child: TextWidget(
                color: Colors.cyan,
                text: 'Cancel',
                textSize: 18,
              )
          ),
          TextButton(onPressed: (){},
              child: TextWidget(
                color: Colors.red,
                text: 'Ok',
                textSize: 18,
              )
          )
        ],
      );
    });
  }
  Future<void> _showAddressDailog() async{
    await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Update'),
        content: TextField(
          // onChanged: (value) {
          //   print('_addressTextController.text ${_addressTextController.text}');
          // },
          controller: _addressTextController,
          maxLines: 5,
          decoration:
          InputDecoration(hintText: 'Your Address'),
        ),
        actions: [
          TextButton(onPressed: () {}, child: Text('Update'))
        ],
      );
    });
  }
  Widget _ListTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        // isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle == null ? "" : subtitle,
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
