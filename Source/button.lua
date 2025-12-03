import "CoreLibs/object"

local pd <const> = playdate
local gfx <const> = pd.graphics

--[[
    Basic button component
    Usage:
        label: string
        x, y: number, number // button position
        onClick: callback // TODO: implement click handling
        stile (optional) = {
            padding = number (default: 0)
            borderWidth = number (default: 1)
            borderRadius = number (default: 0)
        }
--]]

button = {}

class("Button").extends()

function Button:init(label, x, y, onClick, style)
    local textw, texth = gfx.getTextSize(label)
    self.label = label
    self.x, self.y = x, y
    self.width = textw + ((style.padding or 0) * 2)
    self.height = texth + ((style.padding or 0) * 2)
    self.borderRadius = style.borderRadius
    self.onClick = onClick
    self.style = style or {}
    self.selected = false
end

function Button:setSelected(selected)
    self.selected = selected
end

function Button:draw()
    if self.selected then
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRoundRect(self.x + 3, self.y + 3, self.width, self.height, self.borderRadius) -- shadow
    end
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(self.x, self.y, self.width, self.height, self.borderRadius)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRoundRect(self.x, self.y, self.width, self.height, self.borderRadius)
    gfx.drawText(self.label, self.x + (self.style.padding or 0), self.y + (self.style.padding or 0))
end
