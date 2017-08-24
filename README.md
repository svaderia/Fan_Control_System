# Problem statement
Description: This system senses the speed at which the fan is rotating and adjusts the speed, based on the user input. The user can select three different speeds of the fan. The current speed should be sensed and the control mechanism should gradually increase the speed to the desired speed.

User Interface:
  1. Fan starts when user presses ‘Start’ button.
  2. User can then set the required speed by using a keypad interface. This speed value should be displayed on the display.
  3. After setting speed initially, user should be able to change the fan speed setting by an up and down switch. Each press on this arrow button increases/ decreases the speed by 1 unit. Min speed value is 1, whereas maximum speed value is 5 Units. Pressing ‘UP’ button after reaching to value.
  5. should not change the display value or setting of fan speed. Same is true for lower bound.
  4. Fan can be stopped by pressing ‘Stop’ button.
  5. User can also set the mode of fan as ‘Auto’ mode besides a ‘Regular mode’ setting. In Auto mode, user should be able to enter the value of time in terms of hours after which the Fan has to be switched off automatically. (For example, if value entered is 2, then the Fan should switch off after 2 hours from the time this setting is applied

# List of Hardware Used
|Items|Number|
|---|---|
| 8086 Micro-Processor | 1 |
| 74LS373 Octal Latches | 3 |
| 74LS138 3:8 Decoder | 1 |
| 8255A Programmable Peripheral Interfacing Device | 1 |
| 7SEG-COM-CAT-BLUE Display | 1 |
| DAC_8 Digital to Analog Converter | 1 |
| DC Fan | 1 |
| Push Button Switches | 16 |
| 74LS245 Bi-Directional Buffer | 2 |
| 2732 SROM Chips (2KB each) | 2 |
| 6116 RAM Chips (2KB each) | 2 |
| OR Gates | 6 |
| NOT Gates | 3 |
| SPDT Switch | 1 |
| Ground Terminal | as required |

# Implementation Procedure: 
 
1. A   hex   keypad   has   been   created   to   control   the   buttons   of   the   fan   speed 
and   the   increase   and   decrease   functions   of   the   regulator. 
 
2. All   the   buttons,   the   buttons   which   assign   the   value   of   speed,   as   well   as 
those   which   control   the   increment   and   decrement   of   speed,   are   integrated 
within   this   hex   keypad. 
 
3. The   operation   can   be   divided   in   these   parts: 
 
    1.  By   pressing   the   START   and   STOP,   the   user   can   control   the   switching   ON 
and   OFF   the   fan. 
 
    2. User   can   directly   input   the   values   of   the   speed   which   he   wants   and   this 
speed   is   displayed   onto   the   7‐segment   display. 
 
    3. The   user   can   also   control   this   operation   by   using   the   up   and   down 
buttons.   It   can   operate   in   the   range   of   0‐5. 
 
    4. FAN   can   also   be   controlled   by   using   the   AUTO   mode. 
  
# Flowcharts
* Flow chart 1  
![Flowchart - 1](https://github.com/svaderia/Fan_Control_System/tree/master/images/image2.jpg)
* Flow chart 2
![Flowchart - 2](https://github.com/svaderia/Fan_Control_System/tree/master/images/image3.jpg)

# ASSUMPTIONS : 
 
1. Auto   mode   runs   at   speed   3. 
2. Auto   mode   allows   user   to   enter   number   between   0   to   10. 
3. At   a   time   user   presses   only   one   of   the   given   keys. 
4. Hours   in   auto   mode   is   scaled   down   to   seconds. 
5. User   can   start   fan   only   by   pressing   start   button.  
6. Fan   starts   at   speed   1   on   pressing   start   button. 
7. VCC   and   MIN/MAX   are   connected   to   +5V. 

# Running the Design model

* The `FCS.dsn` file has to be opened in Proteus 7 professional (ISIS 7)
* Compile the assembly code in DOSBOX using `ml main.asm`.
* The compilation will result in a new machine level code with the name `main.com`
* Double click on the 8086 processor in the design, browse from the code text box to the `main.com` and select it.
* Run the simulation using the play button provided in ISIS 7.
