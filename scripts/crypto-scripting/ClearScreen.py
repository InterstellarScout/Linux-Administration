import sys
#darkcoding.net/software/pretty-command-line-console-output-on-unix-in-python-and-go-lang/
def clear():
    """Clear screen, return cursor to top left"""
    sys.stdout.write('\033[2J')
    sys.stdout.write('\033[H')
    sys.stdout.flush()
print("Hey")
time.sleep(.5)
clear()