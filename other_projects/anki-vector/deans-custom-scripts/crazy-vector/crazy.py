#!/usr/bin/env python3

# Copyright (c) 2018 Anki, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License in the file LICENSE.txt or at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License isvi distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Play audio files through Vector's speaker.
"""

import anki_vector
from anki_vector.util import degrees, distance_mm, speed_mmps
# generate random integer values
from random import seed
from random import randint
from threading import Thread
import time

# seed random number generator
seed(1)

def sound():
    args = anki_vector.util.parse_command_args()
    with anki_vector.Robot(args.serial) as robot:
        #robot.behavior.drive_off_charger()
        robot.audio.stream_wav_file("r2d2-screams.wav", 100)

def actions():
    # Use a "for loop" to repeat the indented code 4 times
    # Note: the _ variable name can be used when you don't need the value
    args = anki_vector.util.parse_command_args()
    with anki_vector.Robot(args.serial) as robot:
        for _ in range(randint(0,10)):
            print("Raise Vector's lift...")
            robot.motors.set_lift_motor(5)

            print("Drive Vector straight...")
            robot.behavior.drive_straight(distance_mm(200), speed_mmps(200))  # original 50

            print("Move Vector's lift...")
            robot.motors.set_lift_motor(-5.0)
            time.sleep(.25)
            robot.motors.set_lift_motor(5.0)
            time.sleep(.25)
            robot.motors.set_lift_motor(-5.0)
            time.sleep(.25)

            print("Turn Vector in place...")
            # robot.behavior.turn_in_place(degrees(455))
            robot.behavior.turn_in_place(degrees(-90))
            time.sleep(.25)
            robot.behavior.turn_in_place(degrees(90))
            time.sleep(.25)
            robot.behavior.turn_in_place(degrees(450))
            time.sleep(.25)

            print("Move Vector's lift...")
            robot.motors.set_lift_motor(5.0)
            time.sleep(.25)
            robot.motors.set_lift_motor(-5.0)
            time.sleep(.25)
            robot.motors.set_lift_motor(5.0)
            time.sleep(.25)

def main():
    args = anki_vector.util.parse_command_args()
    with anki_vector.Robot(args.serial) as robot:
        robot.behavior.drive_off_charger()
        #Play the crazy sounds
        Thread(target=sound).start()
        #Do the crazy actions
        Thread(target=actions).start()

if __name__ == "__main__":
    main()
