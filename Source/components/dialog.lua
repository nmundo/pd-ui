local pd <const> = playdate
local gfx <const> = pd.graphics

class("Dialog").extends()

local navContext = navManager.createNavContext()



function Dialog:init(title, message, x, y, width, height, onConfirm, onCancel)
    Dialog.super.init(self)

    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.title = title
    self.message = message
    self.onConfirm = onConfirm
    self.onCancel = onCancel
    self.isOpen = false
    self.handlers = {
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
        end,
        BButtonUp = function()
            self:close()
        end
    }

    self.confirmButton = Button("OK", x + width - 70, y + height - 40, function()
        if self.onConfirm then self.onConfirm() end
        self:close()
    end, { padding = 8, borderRadius = 8 })

    self.cancelButton = Button("Cancel", x + width - 140, y + height - 40, function()
        if self.onCancel then self.onCancel() end
        self:close()
    end, { padding = 8, borderRadius = 8 })
end

function Dialog:open()
    self.isOpen = true
    pd.inputHandlers.push(self.handlers)
end

function Dialog:close()
    self.isOpen = false
    pd.inputHandlers.pop()
end

function Dialog:draw()
    if not self.isOpen then return end
    -- background
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(self.x, self.y, self.width, self.height, 10)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRoundRect(self.x, self.y, self.width, self.height, 10)

    -- title
    gfx.setFont(gfx.font.new('font/Mini Sans 2X'))
    gfx.drawText(self.title, self.x + 20, self.y + 20)

    -- message
    gfx.setFont(gfx.font.new('font/Mini Sans'))
    gfx.drawText(self.message, self.x + 20, self.y + 60)

    -- buttons

    navContext:addRow()
    navContext:addComponentToRow(1, self.confirmButton)
    navContext:addComponentToRow(1, self.cancelButton)
    self.confirmButton:draw()
    self.cancelButton:draw()
end
