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

def actions():
    # Use a "for loop" to repeat the indented code 4 times
    # Note: the _ variable name can be used when you don't need the value
    args = anki_vector.util.parse_command_args()
    with anki_vector.Robot(args.serial) as robot:
        for _ in range(1):
            print("Loop start.")
            print("Nod head and Raise lift")

            print("Raise Head")
            robot.motors.set_head_motor(5.0)
            time.sleep(.25)

            print("Talking")
            robot.behavior.say_text("Go truck yourself.")

            print("Lowering Head")
            robot.motors.set_head_motor(-5.0)
            time.sleep(.25)

            print("Turning around")
            robot.behavior.turn_in_place(degrees(180))
            time.sleep(.5)

            print("Driving away.")
            robot.behavior.drive_straight(distance_mm(200), speed_mmps(200))  # original 50
            robot.behavior.say_text("Well this is awkward. Can you find Dean to drive me home?")

def main():
    args = anki_vector.util.parse_command_args()
    with anki_vector.Robot(args.serial) as robot:
        robot.behavior.drive_off_charger()
        # Vector's routine
        Thread(target=actions).start()


if __name__ == "__main__":
    main()
