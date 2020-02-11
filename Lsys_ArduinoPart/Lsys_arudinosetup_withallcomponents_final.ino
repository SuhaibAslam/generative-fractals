// SerialMouse sketch
#define potAPin 0
#define potBPin 1
#define potCPin 2
#define potDPin 3
#define potEPin 4
#define potFPin 5

void setup()
{
  //  pinMode(buttonPin, INPUT);
  Serial.begin(9600);
}

void loop()
{
  int a = analogRead(potAPin);
  int b = analogRead(potBPin);
  int c = analogRead(potCPin);
  int d = analogRead(potDPin);
  int e = analogRead(potEPin);
  
  a = map(a, 0, 1023, 0, 100);
  b = map(b, 0, 1023, 100, 0);
  c = map(c, 0, 1023, 0, 100);
  d = map(d, 0, 1023, 0, 100);
  e = map(e, 0, 1023, 100, 0);
  
  Serial.print(a, DEC);
  Serial.print(",");
  Serial.print(b, DEC);
  Serial.print(",");
  Serial.print(c, DEC);
  Serial.print(",");
  Serial.print(d, DEC);
  Serial.print(",");
  Serial.print(e, DEC);
  Serial.println();  // send a cr/lf
  
  delay(1000); // send positions once a second
}
