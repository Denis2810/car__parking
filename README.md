
# Car Parking System

In the entrance of the parking system, there is a sensor which is activated to detect a vehicle
coming. Once the sensor is triggered, a password is requested to open the gate. If the entered
password is correct, the gate would open to let the vehicle get in. Otherwise, the gate is still
locked. If the current car is getting in the car park being detected by the exit sensor and
another the car comes, the door will be locked and requires the coming car to enter passwords.



1. The car parking system is a FSM with 5 states: IDLE, WAIT PASS, RIGHT PASS,
WRONG PASS and STOP.    
2. The default/reset state is IDLE.     
3. It has 6 inputs: sensor_entrance, sensor_exit, password_1, password_2, clk and reset_n.    
4. Input sensor_entrance is valid if it has a duration longer than 5 clock periods.     
5. Input sensor_exit is valid if it has a duration longer than 7 clock periods.
6. The following transitions are possible:
• IDLE to WAIT PASSWORD: by triggering the sensor entrance input.
• WAIT PASSWORD to RIGHT PASS: by having the right passwords on inputs password_1 and password_2 in less than 30 clock cycles since we entered WAIT_PASSWORD state (correct password for password_1 is 1 and correct password for password_2 is 2).
• WAIT PASSWORD to WRONG PASS: by entering a wrong password on either password 1 or password 2; or by not entering any password in 30 clock cycles since entering the state.
• WRONG PASS to RIGHT PASS: by entering the correct password on password 1 and on password 2.
• RIGHT PASS to STOP: by asserting both sensor_entrance and sensor_exit pins.
• RIGHT PASS to IDLE: by asserting only sensor_exit pin(sensor_entrance pin is 0).
• TOP to RIGHT PASS: by introducing the right password for both password_1 and password_2.
7. If the user enters a wrong password while in STOP, the FSM will remain in STOP.
8. If the user enters a wrong password while in WRONG PASS, the FSM will remain in WRONG PASS.
9. The FSM will remain in RIGHT PASS as long as the sensor_exit pin is 0.
10. The module has four possible outputs:
GREEN LED and RED LED
• The GREEN LED should be 0 in IDLE, WAIT PASSWORD, WRONG PASS,
STOP.
• The GREEN LED should be 1 in RIGHT PASS
• The RED LED should be 0 in IDLE, WAIT PASSWORD, RIGHT PASS.
• The RED LED should be 1 in WRONG PASS and STOP.
HEX 1 and HEX 2 have the values according to the state the FSM is in as it follows:
• In IDLE: HEX 1 = 7’b1111111; HEX 2 = 7’b1111111;
• In WAIT PASSWORD: HEX 1 = 7’b0000110; HEX 2 = 7’b0101011;
• In WRONG PASS: HEX 1 = 7’b0000110; HEX 2 = 7’b0000110;
• In RIGHT PASS: HEX 1 = 7’b0000010; HEX 1 = 7’b1000000;
• In STOP: HEX 1 = 7’b0010010; HEX 2 = 7’b0001100;


