# Task 3 - Power Management System
Okay first things first, what do we have to build?\
It's basically just a robotic arm that can move around.

## What do we have?
Let's see what we're working with.

| Components               | Quantity |
| ------------------------ | -------- |
| Brushed DC Geared Motors | 4        |
| BLDC Motors              | 2        |
| Servo Motors             | 3        |
| NEMA Stepper Motor       | 1        |
| Raspberry Pi 5           | 1        |
| RPI Camera Module 3      | 1        |
| Ldrobot D500 LiDAR Kit   | 1        |
| ESP32                    | 1        |

## Our objective
- Schematic - Basically what goes where
- Appropriate Battery Selection
- Safety Features (including a kill switch of course)
- Power Distribution Analysis 

## Schematic - What goes where
- ### Motors
    Focusing on Torque specifications
    | Components                    | Quantity | Rated Torque     |
    |-------------------------------|----------|------------------|
    | Brushed DC Motors             | 4        | 11 kg-cm         |
    | BLDC Motors                   | 2        | 0.573 kg-cm      |
    | Servo Motors                  | 3        | 28.8 to 35 kg-cm |
    | NEMA Stepper Motor (2 Phase)  | 1        | 2.9 kg-cm        |

    Calculating that rated torque for the BLDC Motor was not that straightforward.

### Power ig?

| Components                   | Quantity | Rated Voltage  | Stall Current   |
| ---------------------------- | -------- | -------------- | --------------- |
| Brushed DC Motors            | 4        | 12 V           | 15 A            |
| BLDC Motors                  | 2        | 11.1 to 22.2 V | 36 A            |
| Servo Motors                 | 3        | 4 to 8.4 V     | 3.8 A           |
| NEMA Stepper Motor (2 Phase) | 1        | 12 V           | 0.5 A x 2 = 1 A |
