# Parking system with ultrasonic sensor and 7-segment display VHDL

## Description
This project presents a smart parking monitoring system designed to optimise the performance of parking spaces. The ultrasonic sensor is able to detect the presence of a car in front of it, and therefore provide information on the 7-segment display about free spaces in the car park and its overall occupancy. Our project implements two such sensors located at the entrance and exit of the car park.

![parking system overview](https://github.com/markizdw/DE1_project_VUT/assets/114153808/a8e24295-fadc-4517-ba8d-616ab9735eb6)

### Project team
Cristóvão Cristóvão (BPC-TLI)

Dominik Eis (BPC-EKT)

Filip Dráb (BPC-TLI)

Maxim Sudakov (BPC-AUD)

# Hardware

## Nexys A7-50T

The Nexys A7 board is a complete, ready-to-use digital circuit development platform based on the latest Artix-7™ Field Programmable Gate Array (FPGA) from Xilinx®. With its large, high-capacity FPGA, generous external memories, and collection of USB, Ethernet, and other ports, the Nexys A7 can host designs ranging from introductory combinational circuits to powerful embedded processors. Several built-in peripherals, including an accelerometer, temperature sensor, MEMs digital microphone, a speaker amplifier, and several I/O devices allow the Nexys A7 to be used for a wide range of designs without needing any other components.

![nexys-a7](https://github.com/markizdw/Smart-parking-system-project/assets/114153808/ecbc7230-61e2-44fa-8fe9-191917c8a817)

Source: https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual

## Ultrasonic sensor HC-SR04

Simple ultrasonic sensor. The basic principle of operation is to receive a reflected signal from an object, so that we can determine its presence and distance to it.  This sensor provides 2 cm to 400 cm of non-contact measurement functionality with a ranging accuracy that can reach up to 3mm. Each HC-SR04 module includes an ultrasonic transmitter, a receiver and a control circuit.

![HC-SR04](https://github.com/markizdw/DE1_project_VUT/assets/114153808/3fb5c647-f808-4843-8759-223d665550f8)

User guide (PDF): [HC-SR04 User Guide.pdf](https://github.com/markizdw/DE1_project_VUT/files/15001950/HC-SR04.User.Guide.pdf)

# Testbench

![image](https://github.com/markizdw/Smart-parking-system-project/assets/114153808/5b5e9fc8-f6fa-4c4f-90a1-a392d3355042)
