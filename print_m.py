
from utime import sleep

from project import motor
from project import variables

# My Blocks
from lower_pen import lower_pen
from lift_pen import lift_pen


def print_m(size):
    seg2 = variables['Seg2']
    seg4 = variables['Seg4']
    motor['B'].on_for_degrees(-25, seg4)
    lower_pen()
    motor['B'].on_for_degrees(25, seg4)
    motor['A+B'].on_for_degrees(10, -10, seg2)
    sleep(0.05)
    motor['A+B'].on_for_degrees(10, 10, seg2)
    motor['B'].on_for_degrees(-25, seg4)
    lift_pen()
    motor['B'].on_for_degrees(25, seg4)
