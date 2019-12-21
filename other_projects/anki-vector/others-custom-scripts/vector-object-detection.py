#!/usr/bin/env python3
# Source https://gist.github.com/acidzebra/ecbc3ab7bf449790aab3671f8fe17781
# Copyright (c) 2019 acidzebra
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# for use with Anki's awesome Vector robot: https://www.anki.com/en-us/vector
#
import anki_vector
import time
import datetime
from PIL import Image
import numpy as np
import cv2
import os
from anki_vector.util import degrees, distance_mm, speed_mmps
from imageai.Detection import ObjectDetection

execution_path = os.getcwd()

while True:
	print('starting loop and connecting to robot')
	image = None
	detections = None
	with anki_vector.Robot(enable_camera_feed=True, requires_behavior_control=False) as robot:
		print('preparing to take a picture')
		try:
			battery_state = robot.get_battery_state()
			if battery_state.battery_level != 1:
				#robot.behavior.set_eye_color(hue=0.83, saturation=0.76)
				while not robot.camera.latest_image:
					time.sleep(0.5)
				#robot.say_text('hmmm what do I see?')
				image = robot.camera.latest_image
				image_data = np.asarray(image)
				#image_data = cv2.resize(image_data, None, fx=1.5, fy=1.5, interpolation=cv2.INTER_CUBIC)
				#filename = "{}.jpg".format(os.getpid())
				#cv2.imwrite(filename, image_data)
				print('image captured, releasing robot and starting detection')
			else:
				print('robot battery low, skipping')
		except:
			print('image capture failed!')
	if image:
		try:
			detector = ObjectDetection()
			#detector.setModelTypeAsTinyYOLOv3()
			#detector.setModelPath( os.path.join(execution_path , "yolo-tiny.h5"))
			#detector.setModelTypeAsYOLOv3()
			#detector.setModelPath( os.path.join(execution_path , "yolo.h5"))
			detector.setModelTypeAsRetinaNet()
			detector.setModelPath( os.path.join(execution_path , "resnet50_coco_best_v2.0.1.h5"))
			#
			#detector.loadModel()
			detector.loadModel(detection_speed="fast")
			detections = detector.detectObjectsFromImage(input_type="array", input_image=image_data, output_image_path=os.path.join(execution_path , "image.jpg"))
		except:
			print('problem running detection')
	else:
		print('no image to process')
	if detections:
		try:
			with anki_vector.Robot() as robot:
				for eachObject in detections:
					print("Vector sees: " , eachObject["name"] , " : " , eachObject["percentage_probability"] )
					if eachObject["percentage_probability"] > 50:
						if eachObject["name"] == "person":
							robot.say_text('I saw someone!')
						else:
							robot.say_text('I saw a  ' + eachObject["name"] + "!")
		except:
			print('failed to connect to robot')
	else:
		#robot.say_text("I didn't see anything in particular")
		print('No objects were recognised')
	try:
		#os.remove(filename)
		os.remove('image.jpg')
		print('temporary files removed')
	except:
		print('no temporary files to remove')
	print('sleeping for 15 secs')
	time.sleep(15)