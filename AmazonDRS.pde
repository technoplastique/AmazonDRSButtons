int waittime = 60; //the number of minutes you'd like a spot to be empty before repelenishment kicks in
int i1 = 0;
int i2 = 0;
int i3 = 0;
int i4 = 0;
//Add additional slot numbers here.

//AMAZON DRS important numbers
char[] device_model = "bb945feb-73fd-4399-aacd-14237b747d39"; //Device Model ID
char[] device_identifier = "myserial001"; //Internal reference number for you
char[] client_id = "amzn1.application-oa2-client.664187d33e8e459cab987dc4b066f8c7"; //Amazon LWA client ID
char[] client_secret = "b35effdc4f28a1606bc9ed860d08799910e88153f90e93a0d3181508c1bc3064"; //Amazon LWA client secret
char[] slot_01 = "144a8817-45f8-4498-a1d1-4d93689ca23e"; //Slot 1
char[] slot_02 = "cd7e955e-dca3-4848-830c-402ad3609d6b"; //Slot 2
char[] slot_03 = "4a06bfb9-f346-4eb7-8d3d-d093bf068073"; //Slot 3
char[] slot_04 = "7e3b1f7a-7468-44dd-b6d2-0b8e6f0d4603"; //Slot 4
char[] redirect_uri = "http://localhost/register"; //Encoded Return URL



#include <Bridge.h>
#include <BridgeHttpClient.h>

BridgeHttpClient client;



void setup() {
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);
  Bridge.begin(); // Initialize Bridge
  digitalWrite(13, HIGH);

  pinMode(1, INPUT_PULLUP);
  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  //Add as many pins/buttons here as you need

  Serial.begin(9600);
  while (!Serial);



  int delaytime = (waittime * 60 * 1000) / 3;
}

void loop() {
  if (digitalRead(1) == LOW) {
    //The button is pressed!
    Serial.println("Button 1 is pressed.");

  } else {
    Serial.println("Button 1 is not pressed.");
    i1++;

    if (i1 >= 3 && i1 < 5) {
      client.addHeader("X-Api-Key: 12345");
      client.addHeader("Accept: application/json");
      client.addHeader("Content-Type: application/json");

      client.enableInsecure(); // Using HTTPS and peer cert. will not be able to auth.

      client.postAsync("https://httpbin.org/post", "{\"key\":\"value\"}");
      SerialUSB.print("Sending request");

      if (client.finished()) {
        SerialUSB.println(client.getResponseCode());
        if (client.getResponseCode() == 200) {
          i1 = i1 + 3;

          while (1) {} // stop

        } else {
          i1 = 3;
        }
      }
    }


  }
}

if (digitalRead(2) == LOW) {
  //The button is pressed!
  Serial.println("Button 2 is pressed.");

} else {
  Serial.println("Button 2 is not pressed.");
}

delay(delaytime);

}
