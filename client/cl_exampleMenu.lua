local foods = {
    "Banana",
    "Apple",
    "Pizza",
    "Quartilicious",
    "Steak",
    0xF00D,
}
local description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
Menu = {
    {
        mBind = 51,
        mIndex = "showcase",
        Name = "main",
        Title = "RageUI",
        SubTitle = "~b~RAGEUI SHOWCASE",
        Glare = false, --OPTIONAL I SET ON FALSE BECAUSE OF DOUBLE ENTRY BUG
        --TextureDictionary ="",  --OPTIONAL
        --TextureName = "", --OPTIONAL
        Items = {
            {
                Type = "checkbox",
                Title = "Add ketchup ?",
                SubTitle = "Do you wish to add ketchup ?",
                Badges = {Style = RageUI.CheckboxStyle.Tick},
                Index = 1,
                Selected = function (k,v)
                    RageUI.Text({
                        message = string.format("~r~Ketchup status: ~b~%s", tostring(v.Index))
                    })
                end,
            },
            {
                Type = "list",
                Title = "Food",
                SubTitle = "Select the type of food you want to eat.",
                List = foods,
                Index = 1,
                Active = function (k,v)
                    RageUI.Text({
                        message = string.format("Preparing ~b~%s~w~...", v.List[v.Index])
                    })
                end,
                SubMenu = {
                    {"showcase","main"},
                    {"showcase","submenu"},
                    {"showcase","badges"},
                    {"showcase","submenu"},
                    {"showcase","badges"},
                    {"showcase","submenu"},
                },
            },
            {
                Type = "slider",
                Title = "Quantity",
                SubTitle = "Select the amount of food you want to eat.",
                Index = 0,
                IndexMax = 10,
                Selected = function (k,v)
                    RageUI.Text({
                        message = string.format("Preparing ~r~%s ~b~%s(s)~w~...", v.Index, foods[Menu[1].Items[2].Index])
                    })                    
                end,
            },
            {
                Type = "button",
                Title = "Cook !",
                SubTitle = "Cook the dish with the appropriate ingredients and ketchup.",
                Badges = {RightBadge = RageUI.BadgeStyle.Tick  },
                Selected = function ()
                    local string = string.format("You have ordered ~r~%s ~b~%s(s)~w~ ~r~with~w~ ketchup.", Menu[1].Items[3].Index, foods[Menu[1].Items[2].Index])
                    if not (Menu[1].Items[1].Index) then
                        string = string.format("You have ordered ~r~%s ~b~%s(s)~w~ ~r~without~w~ ketchup.", Menu[1].Items[3].Index, foods[Menu[1].Items[2].Index])
                    end
                    RageUI.Text({
                        message = string;
                    })
                end,
            },
            {
                Type = "button",
                Title = "Another Menu",
                SubTitle = description,
                Badges = {RightLabel = "→→→" },
                SubMenu = {"showcase","submenu"}
            },
            {
                Type = "button",
                Title = "RageUI.BadgeStyle",
                SubTitle = description,
                Badges = {RightLabel = "→→→" },
                SubMenu = {"showcase","badges"}
            },
        },
        SubMenus = {
            {
                mIndex = "showcase",
                Name = "submenu",
                Title = "RageUI",
                SubTitle = "~b~RAGEUI SHOWCASE",
                Header = false, --OPTIONAL
                Glare = false, --OPTIONAL
                EnableMouse = true,
                Items = {},
                Panels = {
                    {
                        Type = "gridhorizontal",
                        PosIndex = 1,
                        X = 0.5,
                        LeftLabel = "Ouverts",
                        RightLabel = "Plissés",
                    },
                    {
                        Type = "grid",
                        PosIndex = 2,
                        X = 0.5,
                        Y = 0.5,
                        LeftLabel = "Intérieur",
                        RightLabel = "Extérieur",
                        TopLabel = "Haut",
                        BottomLabel = "Bas",
                    },
                    {
                        Type = "gridvertical",
                        Y = 0.5,
                        TopLabel = "Haut",
                        BottomLabel = "Bas",
                        PosIndex = 4,
                    },
                   {
                        Type = "colour",
                        Title = "Couleur principale",
                        Colours = RageUI.PanelColour.HairCut,
                        Index = {1,1},
                        PosIndex = 5,
                        Active = function (k,v)
                            RageUI.Text({
                                message = string.format("Value : ~r~%s ", v.Index[2])
                            })
                        end,
                    },
                    {
                        Type = "percentage",
                        Title = "Percentage",
                        PosIndex = 7,
                        Percent = 0.5,              
                        MinText = nil,
                        MaxText = nil
                    },
                    {
                        Type = "statistic",
                        Title = "Weapon MK2",
                        Percent = 0.9,
                        PosIndex = 7,
                    },
                    {
                        Type = "statistic",
                        Title = "Weapon",
                        Percent = 0.6,
                        PosIndex = 7,
                    },
                }
            },
            {
                mIndex = "showcase",
                Name = "badges",
                Title = "RageUI",
                SubTitle = "~b~RAGEUI.BADGESTYLE",
                Items = {}
            },
        }
    }
}
for i = 1,100 do
 MyBtn = {
    Type = "button",
    Title = string.format("Items - %s", i),
    SubTitle = description,
    }
    table.insert(Menu[1].SubMenus[1].Items, MyBtn)
end
for BadgeName, Badge in pairs(RageUI.BadgeStyle) do
    MyBtn = {
       Type = "button",
       Title = string.format("RageUI.BadgeStyle.%s", BadgeName),
       SubTitle = nil,
       Badges = {RightBadge = Badge, LeftBadge = Badge}
    }
    table.insert(Menu[1].SubMenus[2].Items, MyBtn)
end
---------------------------------------------------
GenMenu(Menu)