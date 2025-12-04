# Roadmap (Very in flux rn)

- [ ] core ui components

  - [ ] buttons
    - [x] base component
    - [ ] different border styles
    - [ ] different select states
  - [ ] select
    - [ ] base component
    - [ ] different drop down styles
  - [ ] dialogs
  - [ ] popovers
  - [ ] lists

- [ ] layout system

  - [ ] ??????

- [ ] navigation system
  - [x] base navigation system
  - [ ] `:removeComponent()`
  - [ ] ???????

# Components

## Button (WIP)

need to add flexibility in color and select style

#### Initialization

```
Button(
    label: string
    x: number
    y: number
    onClick: function()
    style?: {
        padding: number = 0
        borderWidth: number = 1
        borderRadius: number = 0
    }
)
```

#### Methods

`Button:draw()`
`Button:setSelected(boolean)`

## Select (WIP)

#### Initialization

```
Select(
  x: number
  y: number
  options: string[]
  openDirection: "up"|"down"|"left"|"right" = "down"
  popupWidth: number = 100
)
```

#### Methods

`Select:toggleOpen()`

## List

## Popover

## Navigation

#### Initialization

`function() navManager.createNavContext(): navContext`

`navContext`: 2d array of components and methods to navigate through them

##### Methods

`navContext:_setFocus(row: number, col: number)`
Called by the move methods. Calls `:setSelected(false)` on currently selected component then changes selection to `self.grid[row][column]` and calls `:setSelected(true)` on it.
`navContext:addRow()`
`navContext:addComponentToRow(row: number, component: any)`
`navContext:moveRight()`
`navContext:moveLeft()`
`navContext:moveDown()`
`navContext:moveUp()`
`navContext:getCurrentComponent(): component | nil`
