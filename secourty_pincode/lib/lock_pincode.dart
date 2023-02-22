import 'package:flutter/material.dart';
import 'package:secourty_pincode/utils/custom_toast.dart';
import 'package:secourty_pincode/utils/helper.dart';

class MyLockPinCode extends StatefulWidget {
  final int length;
  final Function onChange;
  MyLockPinCode({Key? key, required this.length, required this.onChange}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyLockPinCodeState();
  }
}

class MyLockPinCodeState extends State<MyLockPinCode>{
  String number = '';
  String numberConfirm = '';

  bool createPss=true;
  bool createConfPss=false;

  bool enterPss=false;
  var MQWidth,MqHight;



  setValue(String val){
    if(number.length < widget.length) {
      setState(() {
        if(createPss==true && createConfPss==false) {
          number += val;
          widget.onChange(number);
          numberConfirm=number;
          if(number.length==4){
            createConfPss=true;
            number='';
          }

        }else if(createConfPss==true){
          number += val;
          widget.onChange(numberConfirm);
          if(number.length==4 &&number.toString().trim()==numberConfirm.toString().trim()){
            numberConfirm=number;
            if(number.length==4){
              createPss=false;
              createConfPss=false;
              number='';
            }
           // showToast.Message(context:context,MSG: "Your pin has been successfully setup!");
            showDialogMessage(MSG: "Your pin has been successfully setup!");

          }else if(number.length==4 &&number.toString().trim()!=numberConfirm.toString().trim()){
            createPss=true;
            number='';

            //  showToast.Message(context:context,MSG: "incorrect your pin");
            showToastMessage(MSG: "Wrong confirm pin code!");

          }
        }else if(numberConfirm.length==4&&createPss==false){
          number += val;
          widget.onChange(number);
          if(number.length==4 &&numberConfirm.toString().trim()==number.toString().trim()){
            enterPss=true;
            createPss=false;
           // showToast.Message(context:context,MSG: "incorrect your pin");
            showToastMessage(MSG: "Authentication success!");

          }else  if(number.length==4 &&numberConfirm.toString().trim()!=number.toString().trim()){
            enterPss=true;
            createPss=false;
            number='';

            // showToast.Message(context:context,MSG: "not valid pass");
            showToastMessage(MSG: "Wrong pin code!");
          }

        }
        print("number=$number");
      });
    }
  }
  void showDialogMessage({required String MSG})async{
    showDialog(context: context,
        builder: (BuildContext context){
      return Container(
         margin: EdgeInsets.symmetric(horizontal: 10),
        height: 150,
        child: AlertDialog(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10)
             ),
          title: Container(
            padding: EdgeInsets.all(5),
            child: Text('$MSG',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
          ),
          actions: [
             Container(
               color: Colors.grey,
               height: 0.5,
             ),
             Container(
               alignment: Alignment.center,
               child: TextButton(onPressed: (){
                 Navigator.of(context).pop(1);
               }, child: Text('Ok',
                 textAlign: TextAlign.center,
                 style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 18),)),
             )

          ],
        ),
      );
        });
  }

  void showToastMessage({required String MSG})async{
    showDialog(context: context,
        builder: (BuildContext context){
          return WillPopScope(
            onWillPop:()async{
              return Future.value(true);
            },
            child: Container(
            //  margin: EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                title: Container(
                  padding: EdgeInsets.all(5),
                  child: Text('$MSG',
                        textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                ),
              ),
            ),
          );
        });
     Future.delayed(Duration(seconds: 1),(){
       Navigator.pop(context,1);
     });
  }



  backspace(String text){
    if(text.length > 0){
      setState(() {
        number = text.split('').sublist(0,text.length-1).join('');
        widget.onChange(number);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MQWidth=MediaQuery.of(context).size.width;
    MqHight=MediaQuery.of(context).size.height;

    return Container(
      //alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child:false? Column(
        children: <Widget>[
          Preview(text: number, length: widget.length),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '1',
                onPressed: ()=>setValue('1'),
              ),
              NumpadButton(
                text: '2',
                onPressed: ()=>setValue('2'),
              ),
              NumpadButton(
                text: '3',
                onPressed: ()=>setValue('2'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '4',
                onPressed: ()=>setValue('4'),
              ),
              NumpadButton(
                text: '5',
                onPressed: ()=>setValue('5'),
              ),
              NumpadButton(
                text: '6',
                onPressed: ()=>setValue('6'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '7',
                onPressed: ()=>setValue('7'),
              ),
              NumpadButton(
                text: '8',
                onPressed: ()=>setValue('8'),
              ),
              NumpadButton(
                text: '9',
                onPressed: ()=>setValue('9'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             /* NumpadButton(
                  haveBorder: false
              ),*/
              NumpadButton(
                text: '0',
                onPressed: ()=>setValue('0'),
              ),
              NumpadButton(
                haveBorder: false,
                icon: Icons.backspace,
                onPressed: ()=>backspace(number),
              ),
            ],
          )
        ],
      ):
      _widgetCustomNumber(),
    );
  }

   Widget _widgetCustomNumber(){
      var icon;
      bool haveBorder=false;
    return Column(
      children: [
        SizedBox(height: MqHight*0.07,),
        createPss?const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            'Setup Pin',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
        ):Container(),
        createPss?SizedBox(height: MqHight*0.09,):SizedBox(height: MqHight*0.15,),
        createPss?Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child:!createConfPss?Text(
            'Create Pin',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400,color: Colors.grey.shade500,letterSpacing: 0.5),
          ): Text(
         'Re-enter your Pin',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400,color: Colors.grey.shade500,letterSpacing: 0.5),
     ),
        ):Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            'Enter your Pin',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
        ),
        Preview(text: number, length: widget.length),

        SizedBox(height: MqHight*0.12,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: icon!=null ? Colors.transparent :
                  Color(Helper.buttonNumberColor).withOpacity(0.1),
                  //Theme.of(context).primaryColor.withOpacity(0.1),
                  primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  setValue('1');
                },
                child: Text('1',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: icon!=null ? Colors.transparent :
                  Color(Helper.buttonNumberColor).withOpacity(0.1),
                 // Theme.of(context).primaryColor.withOpacity(0.1),
                  primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  setValue('2');
                },
                child: Text('2',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: icon!=null ? Colors.transparent :
                  Color(Helper.buttonNumberColor).withOpacity(0.1),
                  //Theme.of(context).primaryColor.withOpacity(0.1),
                  primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  setValue('3');
                },
                child: Text('3',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: icon!=null ? Colors.transparent :
                  Color(Helper.buttonNumberColor).withOpacity(0.1),
                  //Theme.of(context).primaryColor.withOpacity(0.1),
                  primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  setValue('4');
                },
                child: Text('4',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: icon!=null ? Colors.transparent :
                  Color(Helper.buttonNumberColor).withOpacity(0.1),

                 // Theme.of(context).primaryColor.withOpacity(0.1),
                  primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  setValue('5');
                },
                child: Text('5',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: icon!=null ? Colors.transparent :
                  Color(Helper.buttonNumberColor).withOpacity(0.1),

                 // Theme.of(context).primaryColor.withOpacity(0.1),
                  primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  setValue('6');
                },
                child: Text('6',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: icon!=null ? Colors.transparent :
                  Color(Helper.buttonNumberColor).withOpacity(0.1),
                 // Theme.of(context).primaryColor.withOpacity(0.1),
                  primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  setValue('7');
                },
                child: Text('7',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: icon!=null ? Colors.transparent :
                  Color(Helper.buttonNumberColor).withOpacity(0.1),

                  //Theme.of(context).primaryColor.withOpacity(0.1),
                  primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  setValue('8');
                },
                child: Text('8',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: icon!=null ? Colors.transparent :
                  Color(Helper.buttonNumberColor).withOpacity(0.1),
                  //Theme.of(context).primaryColor.withOpacity(0.1),
                  primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  setValue('9');
                },
                child: Text('9',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(

                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  //setValue('0');
                },
                child: Text('',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: icon!=null ?
                  Colors.transparent :
                  //Theme.of(context).primaryColor.withOpacity(0.1),
                  Color(Helper.buttonNumberColor).withOpacity(0.1),

                  primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  setValue('0');
                },
                child: Text('0',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                 // backgroundColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.3),
                 // primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                  side: haveBorder ? BorderSide(
                      color: Colors.grey.shade400
                  ) : BorderSide.none,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20.0),
                ),

                onPressed:(){
                  backspace(number);
                },
                child: Icon(Icons.backspace_outlined,color: Colors.black54,size: 30,),
              ),
            ),
          ],
        ),
      ],
    );
   }
}

class Preview extends StatelessWidget {
  final int length;
  final String text;
  const Preview({Key ?key, required this.length,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> previewLength = [];
    for (var i = 0; i < length; i++) {
      previewLength.add(Dot(isActive: text.length >= i+1));
    }
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Wrap(
            children: previewLength
        )
    );
  }
}

class Dot extends StatelessWidget {
  final bool isActive;
  const Dot({Key ?key, this.isActive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: 15.0,
        height: 15.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.deepPurple : Colors.transparent,
          border: Border.all(
              width: 1.0,
              color:Colors.deepPurple //Theme.of(context).primaryColor
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

class NumpadButton extends StatelessWidget {
  final String ?text;
  final IconData ?icon;
  final bool haveBorder;
  final Function onPressed;
  const NumpadButton({Key ?key, this.text, this.icon, this.haveBorder=true,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle = TextStyle(fontSize: 22.0, color: Theme.of(context).primaryColor);
    Widget label = icon != null ? Icon(icon, color: Theme.of(context).primaryColor.withOpacity(0.8), size: 35.0,)
        : Text(this.text ?? '', style: buttonStyle);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.3),
          primary: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
          side: haveBorder ? BorderSide(
              color: Colors.grey.shade400
          ) : BorderSide.none,
          shape: CircleBorder(),
          padding: EdgeInsets.all(20.0),

           // highlightedBorderColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.3),
          //  splashColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1)
//<-- SEE HERE
        ),
       /* borderSide: haveBorder ? BorderSide(
            color: Colors.grey[400]
        ) : BorderSide.none ,
        highlightedBorderColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.3),
        splashColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
        padding: EdgeInsets.all(20.0),
        shape: CircleBorder(),*/
        onPressed:onPressed(),
        child: label,
      ),
    );
  }
}