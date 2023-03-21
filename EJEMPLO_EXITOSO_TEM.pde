import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;

import processing.serial.*;
MySQL msql;

Serial myPort;
float temperature = 0;

void setup() {
  size(400, 400);
  myPort = new Serial(this, "COM5", 9600);
  
}

void draw() {
  background(255);

  if (myPort.available() > 0) {
    String temperatureString = myPort.readStringUntil('\n');
    if (temperatureString != null) {
      temperatureString = temperatureString.trim();
      temperature = float(temperatureString);
    }
  }

  // Configuración del gráfico
  float barHeight = map(temperature, 0, 50, 0, height);
  float barWidth = width/2;
  float barX = width/4;
  float barY = height - barHeight;

  // Dibujar el gráfico
  noStroke();
  fill(255, 0, 0);
  rect(barX, barY, barWidth, barHeight);

  // Mostrar la temperatura actual
  textAlign(CENTER);
  fill(0);
  textSize(20);
  text("Temperatura: " + temperature + " C", width/2, height/2);
  
  String user = "root";
  String pass = "System22";
  String database = "arduino";
  
  msql = new MySQL (this, "localhost", database, user, pass);
  if (msql.connect()) {
    msql.query("INSERT INTO datostem (Temperatura) VALUES (" + temperature + ");");
    while(msql.next()){
      println(msql.getFloat(2)+ msql.getFloat(""));
    }
  }
}
