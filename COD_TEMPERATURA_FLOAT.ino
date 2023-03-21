#include <dht.h>
dht DHT;
#define DHT11_PIN 2

void setup(){
  Serial.begin(9600);
}

void loop() {
  DHT.read11(DHT11_PIN);
  float temperature = DHT.temperature;
  Serial.print(temperature);
  Serial.println();
  delay(1000);
}