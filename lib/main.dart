import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = TextEditingController();
  List<bool> _selection = [true, false, false];
  String tip;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Tip Calculator')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(tip != null)
                Text(tip, style: TextStyle(fontSize:30, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
              Text(
                'Total Amount', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              SizedBox(
                  width: 70,
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,  
                    decoration: InputDecoration(hintText: '\$100'),
                    keyboardType: TextInputType.numberWithOptions(decimal: true)
                )
              ),
              SizedBox(height: 20),
              ToggleButtons(
                children: [Text('10%'), Text('15%'), Text('20%')], 
                isSelected: _selection,
                onPressed: updateSelection
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: (){
                  calculateTip();
                }, 
                child: Text("Calculate Tip"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.teal,
                  onSurface: Colors.grey,
                )
              )  
            ]
          ),
        )  
      )
    );
  }

  void calculateTip(){
    final totalAmount = double.parse(_controller.text);
    final selectedIndex = _selection.indexWhere((element) => element);
    final tipPercentage = [0.1, 0.15, 0.2][selectedIndex];
    final tipTotal = (totalAmount * tipPercentage).toStringAsFixed(2);
    setState(() {
      tip = '\$$tipTotal';
    });
  }
  
  void updateSelection(int selectedIndex){
    setState(() {
      for(int i=0; i < _selection.length; i++){
        _selection[i] = selectedIndex == i;
      }
    });
  }

}