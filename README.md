# Roadmap (Very in flux rn)

- [ ] core ui components

  - [ ] buttons
  - [ ] dialogs
  - [ ] popovers
  - [ ] lists

- [ ] layout system

  - [ ] ??????

- [ ] event system

# components

## button (WIP)

need to add flexibility in color and select style

#### interface

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

#### methods

`Button:draw()`
`Button:setSelected(boolean)`

## select (WIP)

```
Select(
  x: number
  y: number
  options: string[]
  openDirection: "up"|"down"|"left"|"right" = "down"
  popupWidth: number = 100
)
```

#### methods

`Select:toggleOpen()`

## list

## popover
