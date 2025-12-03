import "button"
import "select"

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X')

local function load()
	playdate.display.setRefreshRate(50)
	gfx.setFont(font)
end

load()

local button1 = Button("Click Me", 50, 80, function()
	print("Button Clicked!")
end, { padding = 8, borderRadius = 8 })

local select1 = Select(200, 80, { "Option 1", "Option 2", "Option 3" })
function playdate.update()
	gfx.clear()
	button1:draw()
	select1:draw()
end
