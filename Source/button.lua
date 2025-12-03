local pd <const> = playdate
local gfx <const> = pd.graphics

button = {}

class("button").extends()

function button:init(label, x, y, onClick, style)
    local textw, texth = gfx.getTextSize(label)
    self.label = label
    self.x, self.y = x, y
    self.width = textw + (style.padding * 2 or 0)
    self.height = texth + (style.padding * 2 or 0)
    self.borderRadius = style.borderRadius
    self.onClick = onClick
    self.style = style or {}
    self.selected = false
end

function button:setSelected(selected)
    self.selected = selected
end

function button:draw()
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
