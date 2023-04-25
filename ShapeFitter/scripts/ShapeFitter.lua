
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

local DELAY = 1000 -- ms between visualization steps for demonstration purpose

-- Create a viewer
local viewer = View.create()

-- Setup graphical overlay attributes
local regionDecoration = View.ShapeDecoration.create():setLineWidth(4)
regionDecoration:setLineColor(230, 230, 0) -- Yellow

local featureDecoration = View.ShapeDecoration.create():setPointSize(5)
featureDecoration:setLineWidth(4):setLineColor(75, 75, 255) -- Blue

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  local img = Image.load('resources/ShapeFitter.bmp')
  viewer:clear()
  viewer:addImage(img)
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

  viewer:addShape(outerCircle, regionDecoration)
  viewer:addShape(foundCircle, featureDecoration)

  -- Fitting edge
  local edgeCenter = Point.create(110, 310)
  local edgeRegion = Shape.createRectangle(edgeCenter, 40, 130, 0)
  local edgeSegm, _ = fitter:fitLine(img, edgeRegion:toPixelRegion(img), 0)

  viewer:addShape(edgeSegm, featureDecoration)
  viewer:addShape(edgeRegion, regionDecoration)
  viewer:present()
  print('App finished.')
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope-----------------
