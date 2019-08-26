--[[----------------------------------------------------------------------------

  Application Name:
  ShapeFitter

  Summary:
  Fitting circle and edge.

  How to Run:
  Starting this sample is possible either by running the app (F5) or
  debugging (F7+F10). Setting breakpoint on the first row inside the 'main'
  function allows debugging step-by-step after 'Engine.OnStarted' event.
  Results can be seen in the image viewer on the DevicePage.
  Restarting the Sample may be necessary to show images after loading the webpage.
  To run this Sample a device with SICK Algorithm API and AppEngine >= V2.5.0 is
  required. For example SIM4000 with latest firmware. Alternatively the Emulator
  in AppStudio 2.3 or higher can be used.

  More Information:
  Tutorial "Algorithms - Fitting and Measurement".

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

local DELAY = 1000 -- ms between visualization steps for demonstration purpose

-- Create a viewer
local viewer = View.create()

-- Setup graphical overlay attributes
local regionDecoration = View.ShapeDecoration.create()
regionDecoration:setLineColor(230, 230, 0) -- Yellow
regionDecoration:setLineWidth(4)

local featureDecoration = View.ShapeDecoration.create()
featureDecoration:setLineColor(75, 75, 255) -- Blue
featureDecoration:setLineWidth(4)
featureDecoration:setPointSize(5)

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  local img = Image.load('resources/ShapeFitter.bmp')
  viewer:clear()
  local imageID = viewer:addImage(img)
  viewer:present()
  Script.sleep(DELAY) -- for demonstration purpose only

  -- Creating common fitter object
  local fitter = Image.ShapeFitter.create()
  fitter:setProbeCount(25)

  -- Fitting circle
  local circleCenter = Point.create(312, 307)
  local outerCircle = Shape.createCircle(circleCenter, 40)
  local innerRadius = 10
  local foundCircle = fitter:fitCircle(img, outerCircle, innerRadius)

  viewer:addShape(outerCircle, regionDecoration, nil, imageID)
  viewer:addShape(foundCircle, featureDecoration, nil, imageID)

  -- Fitting edge
  local edgeCenter = Point.create(110, 310)
  local edgeRegion = Shape.createRectangle(edgeCenter, 40, 130, 0)
  local edgeSegm, _ = fitter:fitLine(img, edgeRegion:toPixelRegion(img), 0)

  viewer:addShape(edgeSegm, featureDecoration, nil, imageID)
  viewer:addShape(edgeRegion, regionDecoration, nil, imageID)
  viewer:present()
  print('App finished.')
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope-----------------
