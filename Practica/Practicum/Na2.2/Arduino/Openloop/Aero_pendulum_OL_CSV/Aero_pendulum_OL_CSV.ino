// Arduino Uno R4 Minima. Serial Monitor: 115200 baud.
// S = starten (30 s), C = sensorcontrole (10 s), X = stoppen.
#include <Wire.h>
#include <AS5600.h>

// Instellingen: controleer bereik en draairichting met de begeleider.
const int MAX_PWM = 120;
const double ANGLE_OFFSET_DEG = 90, MIN_ANGLE_DEG = -10, MAX_ANGLE_DEG = 80;
const unsigned long MEASUREMENT_MS = 30000;
const int OPEN_LOOP_PWM = 60;

AS5600 sensor;
double angle = 0, output = 0;
char mode = 'X';
unsigned long startTime = 0, lastSample = 0;

void stopMotor() {
  analogWrite(9, 0);
  output = 0;
  mode = 'X';
}

bool readAngle() {
  sensor.lastError(); // Wis oude I2C-fouten.
  if (!sensor.isConnected()) return false;
  byte status = sensor.readStatus();
  if (sensor.lastError() != AS5600_OK) return false;
  // Magneet aanwezig, niet te sterk en niet te zwak.
  if ((status & 0x38) != 0x20) return false;
  angle = ANGLE_OFFSET_DEG - sensor.readAngle() * (360.0 / 4096.0);
  return sensor.lastError() == AS5600_OK &&
         angle >= MIN_ANGLE_DEG && angle <= MAX_ANGLE_DEG;
}

void setup() {
  pinMode(9, OUTPUT);  // ENA: PWM
  pinMode(10, OUTPUT); // IN1
  pinMode(11, OUTPUT); // IN2
  digitalWrite(10, LOW);
  digitalWrite(11, HIGH);
  stopMotor();
  Wire.begin();
  sensor.begin();
  Serial.begin(115200);
}

void loop() {
  unsigned long now = millis();
  if (Serial.available()) {
    char command = Serial.read();
    if (command == 'X') stopMotor();
    if ((command == 'S' || command == 'C') && mode == 'X') {
      if (!readAngle()) {
        Serial.println("# Controleer de sensor en de ingestelde hoekgrenzen.");
        return;
      }
      startTime = now;
      mode = command;
      Serial.println("t_ms,setpoint_deg,angle_deg,pwm,running,sensor_ok");
    }
  }
  if (mode == 'X') return;
  if (now - startTime >= (mode == 'C' ? 10000UL : MEASUREMENT_MS)) {
    stopMotor();
    return;
  }
  if (now - lastSample < 20) return; // Meten en regelen op nominaal 50 Hz.
  lastSample = now;
  bool sensorOk = readAngle();
  if (!sensorOk) stopMotor();
  if (mode == 'S') {
    output = constrain(OPEN_LOOP_PWM, 0, MAX_PWM);
    analogWrite(9, (int)output);
  }

  Serial.print(now - startTime); Serial.print(',');
  Serial.print(',');
  if (sensorOk) Serial.print(angle);
  Serial.print(','); Serial.print((int)output);
  Serial.print(','); Serial.print(mode == 'S' ? 1 : 0);
  Serial.print(','); Serial.println(sensorOk ? 1 : 0);
}

