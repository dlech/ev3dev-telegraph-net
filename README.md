Telegraph Machine and Printer
=============================

This is a program for connecting JKBrickworks Telegraph Machine and Printer
to the Internet so you can communicate with other telegraphs.

Model building instructions and more info on the model at:
<http://jkbrickworks.com/telegraph-machine-and-printer>

You will need to be running the latest **ev3dev-stretch** [snapshot][snapshots]
on the EV3.

To download and run the program on an EV3, get [Visual Studio Code][vscode]
and the [ev3dev extension][ev3dev-browser].

First, run the calibration (`calibrate.py`) and test page (`print_test_page.py`)
programs to make sure the printer is working. Then find someone to talk to. Edit
`telegraph.py` and enter your names for `ME` and `YOU`. Then run the telegraph
program. (You can run the printer program (`printer.py`) if you need to practice
your Morse code while offline.)

[snapshots]: https://oss.jfrog.org/artifactory/list/oss-snapshot-local/org/ev3dev/brickstrap/
[vscode]: https://code.visualstudio.com/
[ev3dev-browser]: https://marketplace.visualstudio.com/items?itemName=dlech.ev3dev-browser
