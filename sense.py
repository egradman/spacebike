from Phidgets.PhidgetException import *
from Phidgets.Events.Events import *
from Phidgets.Devices.InterfaceKit import *
from Phidgets.Devices.Encoder import *
import time
import numpy

import liblo
try:
  target = liblo.Address(1234)
except liblo.AddressError, err:
  print str(err)
  sys.exit()

steer = 0
velocity = 0

try:
   interfaceKit = InterfaceKit()
   encoder = Encoder()

except RuntimeError as e:
  print("Runtime Error: %s" % e.message)

def interfaceKitSensorChanged(e):
  global steer
  DEAD_ZONE = 0
  if e.index == 0:
    steer = numpy.clip((e.value-263)/110.0, -1, 1)
    if abs(steer) < DEAD_ZONE:
      steer = 0
    print "steer", steer
  return 0

def interfaceKitInputChanged(e):
  if e.index == 0:
    if e.state == True:
      print "fire"
      liblo.send(target, "/fire")
  return 0

def encoderPositionChangeHandler(e):
  global velocity
  DEAD_ZONE = 1.0
  factor = 0.5
  velocity = factor*e.positionChange/e.time
  print "velocity", velocity
  if velocity < DEAD_ZONE:
    velocity = 0

  return 0

try:
  interfaceKit.openPhidget()
  interfaceKit.waitForAttach(10000)
  print ("interfaceKit %d attached!" % (interfaceKit.getSerialNum()))

  encoder.openPhidget()
  encoder.waitForAttach(10000)
  print ("encoder %d attached!" % (encoder.getSerialNum()))

  interfaceKit.setOnSensorChangeHandler(interfaceKitSensorChanged)
  interfaceKit.setOnInputChangeHandler(interfaceKitInputChanged)
  encoder.setOnPositionChangeHandler(encoderPositionChangeHandler)


  while True:
    time.sleep(0.05)
    liblo.send(target, "/steer", steer)
    liblo.send(target, "/velocity", float(velocity))

  interfaceKit.closePhidget()

except PhidgetException as e:
  print ("Phidget Exception %i: %s" % (e.code, e.detail))
  exit(1)
