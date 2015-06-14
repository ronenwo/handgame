import processing.serial.*; //import the Serial library

Serial myPort;  //the Serial port object
String val = "none";
// since we're doing serial handshaking, 
// we need to check if we've heard from the microcontroller
boolean firstContact = false;
int counter = 0;

void setup() 
{
  size(200,200); //make our canvas 200 x 200 pixels big
  String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
//  myPort = new Serial(this, Serial.list()[4], 9600);
  myPort.bufferUntil('\n');
  println("end setup"); 
}


void draw(){
  String txt = "sensor=" + val;
  text(val, 100,100);
}

//void establishContact() {
//  while (myPort.available() <= 0) {
//    myPort.println("A");   // send a capital A
//    delay(300);
//  }
//}


void serialEvent( Serial myPort) {
  counter++;
  println("got serial. counter="+counter);
//put the incoming data into a String - 
//the '\n' is our end delimiter indicating the end of a complete packet
val = myPort.readStringUntil('\n');
//make sure our data isn't empty before continuing
if (val != null) {
  //trim whitespace and formatting characters (like carriage return)
  val = trim(val);
  println(val);

  if (val.equals("A")) {
     println("good AAAAA!!!"); 
  }
  
  println("firstContact = " + firstContact);

  //look for our 'A' string to start the handshake
  //if it's there, clear the buffer, and send a request for data
  if (!firstContact) {
    if (val.equals("A")) {
      myPort.clear();
      firstContact = true;
      myPort.write("A");
      println("got A. send A.");
    }
  }
  else { //if we've already established contact, keep getting and parsing data
    println(val);

//    if (mousePressed == true) 
//    {                           //if we clicked in the window
//      myPort.write('1');        //send a 1
//      println("1");
//    }
//
//    // when you've parsed the data you have, ask for more:
//    myPort.write("A");
    }
  }
}





