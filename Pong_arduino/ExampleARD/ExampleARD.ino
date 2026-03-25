#include "comm.h"
#include <DHT.h>

#define DHTPIN 2
#define DHTTYPE DHT11

const int lightSensorPin = A1;
const int potentiometerPin = A0;

DHT dht(DHTPIN, DHTTYPE);

int loopCounter = 0;

void setup() {
  dht.begin();
  commSetup();    

}

void loop() {
  loopCounter++;
  // Manage communications
  int rawLight = analogRead(lightSensorPin);
  int rawPotent = analogRead(potentiometerPin);

  int light = map(rawLight, 0, 1023, 1000, 0);
  int potent = map(rawPotent, 0, 1023, 0, 1000);

  // ***** Example
  // In this example, data received through CHANNEL_2 is re-sent through CHANNEL_1
  if ( portIsConnected() ) {
    sendData (1, light);
    sendData (2, potent);
    if (loopCounter % 10 == 0) {
      float temp = dht.readTemperature();
      if (!isnan(temp) && portIsConnected()) {
        int tempInt = (int)(temp * 100);
        sendData(3, tempInt);
      }
    }
  }
  commManager();
}
