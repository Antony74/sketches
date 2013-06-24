#
# This Jython script builds the Processing sketch 'star' and runs it with an interactive prompt
#
# usage: jython -i run.py
#
# Just a single configuration setting is required:

buildTool = 'D:/processing-2.0b9/processing-java.exe'

# End of configuation settings


import shutil
import subprocess
from os import getcwd
import os
import sys
import java.lang.Thread

# If there's already an output directory, remove it
shutil.rmtree('output', True)

# Wait until the directory has really gone
for n in range(30):
	if os.path.isfile('output'):
		sleep(0.1)

# Build the sketch
subprocess.call([buildTool, '--sketch=' + getcwd(), '--output=' + getcwd() + '/output', '--export', '--platform=linux', '--bits=32'])

# Load the sketch
sys.path.append(getcwd() + '/output/lib/core.jar')
sys.path.append(getcwd() + '/output/lib/star.jar')

import star

sketch = star()

# Workaround:  Stop the sketch from using the wrong classloader
java.lang.Thread.currentThread().setContextClassLoader(sketch.getClass().getClassLoader())

# Run the sketch
star.runSketch(['', 'star'], sketch)


