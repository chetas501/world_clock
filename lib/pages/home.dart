import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String bgImage = data['isDayTime'] ? 'assets/day.png' : 'assets/night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo.shade700;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(bgImage), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDayTime': result['isDayTime'],
                      'flag': result['flag'],
                    };
                  });
                },
                icon: Icon(Icons.edit_location,
                    color: data['isDayTime']
                        ? Colors.black
                        : Colors.grey.shade300),
                label: Text(
                  'Edit Location',
                  style: TextStyle(
                      color: data['isDayTime']
                          ? Colors.black
                          : Colors.grey.shade300),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2.0,
                        color: data['isDayTime'] ? Colors.black : Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: TextStyle(
                    fontSize: 66,
                    color: data['isDayTime'] ? Colors.black : Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
