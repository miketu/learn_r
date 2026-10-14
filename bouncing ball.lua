--! luart-extensions
import ui,canvas


-- create a simple Window 
local win = ui.Window("Drawing", "fixed", 1000, 1000)
local canvas = ui.Canvas(win)
canvas.align = "all"
canvas.bgcolor = 0x000000FF
local w = canvas.width
local h = canvas.height

-- Initial Parameters in Model
x_pos=300
y_pos=300
x_velocity=1
y_velocity=0
dt=0.1

function canvas:onPaint()
    self:begin()
    self:clear()
    self:rect(100,100,w-100,h-100,0xFFFFFFFF,5)
    self:circle(x_pos, y_pos, 10, 0xFFFFFFFF, 1)
    self:flip()
    
    
    
    
    if (x_pos<=110 or x_pos>=w-110) then
      x_velocity=-1*x_velocity
      if(x_pos<=110) then
        x_pos=110.5
      else
        x_pos=w-109.5
      end
      
      
    end
    
    if (y_pos<=110 or y_pos>=h-110) then
      y_velocity=-0.95*y_velocity
      if(y_pos<=110) then
        y_pos=110.5
      else
        y_pos=h-109.5
      end
      
    end
    
    
    x_pos=x_pos+x_velocity*dt
    y_pos=y_pos+y_velocity*dt
    y_velocity=y_velocity+9.8*dt
    
    
end

await win:showasync()
            