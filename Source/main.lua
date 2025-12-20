import "./components/button"
import "./components/select"
import "./components/dialog"
import "navManager"

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X')

playdate.display.setRefreshRate(50)
gfx.setFont(font)

local select1 = Select(200, 80, { "Option 1", "Option 2", "Option 3" })

local dialog1 = Dialog(
	"Dialog Title",
	"This is a sample dialog message.",
	60, 50,
	200, 150,
	function() print("Dialog Confirmed") end,
	function() print("Dialog Canceled") end
)

local button1 = Button("Button", 50, 80, function()
	dialog1:open()
end, { padding = 8, borderRadius = 8 })

local navContext = navManager.createNavContext()
navContext:addRow()
navContext:addComponentToRow(1, button1)
navContext:addComponentToRow(1, select1)

local handlers = {
	upButtonUp = function()
		navContext:moveUp()
	end,
	downButtonUp = function()
		navContext:moveDown()
	end,
	leftButtonUp = function()
		navContext:moveLeft()
	end,
	rightButtonUp = function()
		navContext:moveRight()
	end,
	AButtonUp = function()
		local currentComponent = navContext:getCurrentComponent()
		if currentComponent and currentComponent.onClick then
			currentComponent.onClick()
		end
	end
}
playdate.inputHandlers.push(handlers)

function playdate.update()
	gfx.clear()
	button1:draw()
	select1:draw()
	dialog1:draw()
end
