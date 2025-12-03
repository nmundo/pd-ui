import "CoreLibs/object"
import "button"

local pd <const> = playdate
local gfx <const> = pd.graphics

select = {}

class("Select").extends(Button)

function Select:init(x, y, options, openDirection, popupWidth)
    Select.super.init(self, "Select", x, y, self.toggleOpen(self), { padding = 8, borderRadius = 8 })
    self.openDirection = openDirection or "down"
    self.popupWidth = popupWidth or 100
    self.options = options or {}
    self.open = true
    self.selectedIndex = 1
end

function Select:draw()
    Select.super.draw(self)

    if not self.open then return end

    local startX = self.x
    local startY = self.y

    if self.openDirection == "up" then
        startY = self.y - (#self.options * 30) - 2
    elseif self.openDirection == "down" then
        startY = self.y + self.height + 2
    elseif self.openDirection == "right" then
        startX = self.x + self.width + 2
    elseif self.openDirection == "left" then
        startX = self.x - self.popupWidth - 2
    end

    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(startX, startY, self.popupWidth + 8, (#self.options * 30), 6)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRoundRect(startX, startY, self.popupWidth + 8, (#self.options * 30), 6)

    for i, option in ipairs(self.options) do
        local yOffset = (i - 1) * 30
        if i == self.selectedIndex then
            gfx.setColor(gfx.kColorBlack)
            gfx.fillRoundRect(startX + 4, startY + yOffset + 3, self.popupWidth, 24, 4)
            gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        end
        gfx.drawText(option, startX + 10, startY + yOffset + 5)
        gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    end
end

function Select:toggleOpen()
    self.open = not self.open
end
