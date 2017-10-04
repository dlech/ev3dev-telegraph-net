#!/usr/bin/env micropython

from errno import EINTR

from umqtt.simple import MQTTClient

from uev3dev.util import debug_print
from uev3dev.util import fork
from uev3dev.util import write_at_index

from project import messaging
from project import motor
from project import variables

from carriage_move import carriage_move
from feed_in import feed_in
from feed_out import feed_out
from initialize import initialize
from process_queue import process_queue
from read_code import read_code

ME = 'robot1'  # change to your name/handle
YOU = 'robot2'  # change to the person you want to talk to
SERVER = 'test.mosquitto.org'


def handle_message(topic, msg):
    for letter in msg:
        # TODO: special character for unknown letters?
        queue = variables['Queue']
        variables['Queue'] = write_at_index(queue, len(queue), letter)


def main(server=SERVER, me=ME, you=YOU):
    # init MQTT
    c = MQTTClient(me, server)
    c.set_callback(handle_message)
    c.connect()
    c.subscribe(('ev3dev-telegraph-net/' + you).encode())
    topic = ('ev3dev-telegraph-net/' + me).encode()

    # init printer
    initialize()
    feed_in()

    def thread1():
        """Continuously process the queue of letters."""
        motor['C'].on_for_rotations(50, -2.5)
        carriage_move(0)
        process_queue()
        carriage_move(525)

        def thread1_1():
            motor['C'].on_for_rotations(50, 2.5)

        def thread1_2():
            feed_out()

        fork(thread1_1, thread1_2)

    def thread2():
        """Continuously monitor the touch sensor and convert the Morse code
        sequence into a letter index which gets published.
        """
        read_code(lambda l: c.publish(topic, bytes((l,))))

    def thread3():
        """This will wait for any MQTT messages, and add them to the letter
        queue via handle_message().
        """
        while True:
            try:
                c.wait_msg()
            except OSError as err:
                if err.args[0] == EINTR:
                    continue
                raise

    fork(thread1, thread2, thread3)

if __name__ == "__main__":
    main()
