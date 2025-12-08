navManager = {}

function navManager.createNavContext(grid)
    local navContext = {}
    navContext.currentFocusIndex = 1
    navContext.grid = grid or {} -- 2D array: grid[row][col]
    navContext.currentRow = 1
    navContext.currentCol = 1

    function navContext:addRow()
        table.insert(self.grid, {})
    end

    function navContext:addComponentToRow(row, component)
        table.insert(self.grid[row], component)
    end

    function navContext:_setFocus(row, col)
        local prevComponent = self.grid[self.currentRow] and self.grid[self.currentRow][self.currentCol]
        if prevComponent then prevComponent:setSelected(false) end

        self.currentRow = row
        self.currentCol = col

        local newComponent = self.grid[row][col]
        if newComponent then newComponent:setSelected(true) end
    end

    function navContext:moveRight()
        local row = self.currentRow
        local col = self.currentCol + 1
        if col > #self.grid[row] then col = 1 end
        self:_setFocus(row, col)
    end

    function navContext:moveLeft()
        local row = self.currentRow
        local col = self.currentCol - 1
        if col < 1 then col = #self.grid[row] end
        self:_setFocus(row, col)
    end

    function navContext:moveDown()
        local row = self.currentRow + 1
        if row > #self.grid then row = 1 end

        local col = self.currentCol
        if col > #self.grid[row] then col = #self.grid[row] end

        self:_setFocus(row, col)
    end

    function navContext:moveUp()
        local row = self.currentRow - 1
        if row < 1 then row = #self.grid end

        local col = self.currentCol
        if col > #self.grid[row] then col = #self.grid[row] end

        self:_setFocus(row, col)
    end

    function navContext:getCurrentComponent()
        local row = self.currentRow
        local col = self.currentCol
        return self.grid[row] and self.grid[row][col] or nil
    end

    return navContext
end
