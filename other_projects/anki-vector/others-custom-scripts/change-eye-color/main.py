import time
import anki_vector
import random
from anki_vector.util import degrees

# Switch eye color super duper fast
def eye(numb, sleep_time, robot):
    print("Func 'eye' started...\n")
    i = 0
    while i < numb:
        hue_ = random.uniform(0, 1)
        print(f"Hue is {hue_}")
        sat_ = random.uniform(0, 1)
        print(f"Sat is {sat_}\n")
        robot.behavior.set_eye_color(hue=hue_, saturation=sat_)
        time.sleep(sleep_time)
        i += 1
    print("While loop complete, finishing eye func")

# Switch screen color super duper fast
def screen(numb, sleep_time, robot):
    print("Func 'screen' started...\n")
    i = 0
    while i < numb:
        r = random.randint(1, 255)
        print(f"r val = {r}")
        g = random.randint(1, 255)
        print(f"g val = {g}")
        b = random.randint(1, 255)
        print(f"b val = {b}\n")
        time.sleep(sleep_time)
        robot.screen.set_screen_to_color(anki_vector.color.Color(rgb=[r, g, b]), duration_sec=sleep_time)

        i += 1
    print("While loop complete, finishing eye func")

# Switch both super duper fast
def both(numb, sleep_time, robot):
    print("Func 'screen' started...\n")
    i = 0
    while i < numb:
        r = random.randint(1, 255)
        print(f"r val = {r}")
        g = random.randint(1, 255)
        print(f"g val = {g}")
        b = random.randint(1, 255)
        print(f"b val = {b}")
        hue_ = random.uniform(0, 1)
        print(f"Hue is {hue_}")
        sat_ = random.uniform(0, 1)
        print(f"Sat is {sat_}\n")

        time.sleep(sleep_time)
        robot.screen.set_screen_to_color(anki_vector.color.Color(rgb=[r, g, b]), duration_sec=sleep_time)
        robot.behavior.set_eye_color(hue=hue_, saturation=sat_)
        i += 1
    print("While loop complete, finishing eye func")

def main():
    args = anki_vector.util.parse_command_args()

    with anki_vector.Robot(args.serial) as robot:
        print("\n\n------------------------------\n\nStarting program...\n")
        robot.behavior.set_head_angle(degrees(45.0))
        robot.behavior.set_lift_height(0.0)
        mode = input("Enter mode:\n 1: Eye color\n 2: Screen color\n 3: Screen and eyes\n")
        robot.say_text(f"Mode {mode} selected")
        if mode == "1":
            loop = int(input("\nHow many times would you like to repeat?  "))
            robot.say_text(f"Repeating {loop} times")
            speed = int(float(input("How long should it wait?  ")))
            robot.say_text(f"Sleeping for {speed} seconds")
            print("\n\n------------------------------\n\n")
            eye(loop, speed, robot)
        elif mode == "2":
            loop = int(input("How many times would you like to repeat?  "))
            robot.say_text(f"Repeating {loop} times")
            speed = int(float(input("How long should it wait?  ")))
            robot.say_text(f"Sleeping for {speed} seconds")
            print("\n\n------------------------------\n\n")
            screen(loop, speed, robot)
        elif mode == "3":
            loop = int(input("How many times would you like to repeat?  "))
            robot.say_text(f"Repeating {loop} times")
            speed = int(float(input("How long should it wait?  ")))
            robot.say_text(f"Sleeping for {speed} seconds")
            print("\n\n------------------------------\n\n")
            both(loop, speed, robot)
        else:
            print(f"Invalid command '{mode}'")
            main()


if __name__ == '__main__':
    main()