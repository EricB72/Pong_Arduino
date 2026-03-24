#include <DHT.h>

#define DHTPIN 2
#define DHTTYPE DHT11

const int lightSensorPin = A1;
const int potentiometerPin = A0;

DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(9600);
  dht.begin();
}

void loop() {

  
  int rawLight = analogRead(lightSensorPin);
  int rawPotent = analogRead(potentiometerPin);

  // Podria tener que ser alreves, cambiar el 1000 por el 0 del map
  float light = map(rawLight, 0, 1023, 1000, 0) / 1000.0;
  float potent = map(rawPotent, 0, 1023, 0, 1000) / 1000.0;

  light = constrain(light, 0.0, 1.0);
  potent = constrain(potent, 0.0, 1.0);

  float temp = dht.readTemperature();

  if (!isnan(temp)) {
    Serial.print(luz, 3);
    Serial.print(",");
    Serial.print(pot, 3);
    Serial.print(",");
    Serial.println(temp, 1);
  }

  delay(100);
} 