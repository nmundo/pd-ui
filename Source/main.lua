import "greeting"
import "button"

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X')

local function load()
	playdate.display.setRefreshRate(50)
	gfx.setFont(font)
end

load()

local button1 = button("Click Me", 50, 80, function()
	print("Button Clicked!")
end, { padding = 8, borderRadius = 8 })

function playdate.update()
	gfx.clear()
	button1:draw()
	button1:setSelected(true)
end
