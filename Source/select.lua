import "CoreLibs/object"
import "button"
import "navManager"

local pd <const> = playdate
local gfx <const> = pd.graphics

select = {}
local navContext = navManager.createNavContext()

class("Select").extends(Button)

function Select:init(x, y, options, openDirection, popupWidth)
    Select.super.init(self, "Select", x, y, function() self.toggleOpen(self) end, { padding = 8, borderRadius = 8 })
    self.openDirection = openDirection or "down"
    self.popupWidth = popupWidth or 100
    self.options = options or {}
    self.open = false
    self.selectedIndex = 1
    self.onClick = function() self:toggleOpen() end
    self.handlers = {
        upButtonUp = function()
            self.selectedIndex = self.selectedIndex - 1
            if self.selectedIndex < 1 then self.selectedIndex = #self.options end
        end,
        downButtonUp = function()
            self.selectedIndex = self.selectedIndex + 1
            if self.selectedIndex > #self.options then self.selectedIndex = 1 end
        end,
        AButtonUp = function()
            self.open = false
            print("Selected option: " .. self.options[self.selectedIndex])
            pd.inputHandlers.pop()
        end,
        BButtonUp = function()
            self:toggleOpen()
        end
    }
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
        navContext:addRow()
        navContext:addComponentToRow(i, self)
        gfx.drawText(option, startX + 10, startY + yOffset + 5)
        gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    end
end

function Select:toggleOpen()
    if not self.open then
        self.open = true
        pd.inputHandlers.push(self.handlers, true)
    else
        self.open = false
        pd.inputHandlers.pop()
    end
end
