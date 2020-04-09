Menu = {
    {
        mBind = 51,
        mIndex = "showcase",
        Name = "test",
        Title = "Test Auto Menu",
        SubTitle = "~b~Test subtitle",
        --Header = true, --OPTIONAL
        --Glare = true, --OPTIONAL
        --Instructional = true,-- OPTIONAL
        --TextureDictionary ="",
        --TextureName = "",
        Items = {
            {
                Type = "button",
                Title = "My Test Button",
                SubTitle = "My button's subtitle",
                Activated = true,
                Badges = {  },
                Selected = function ()
                    --print("test")
                end,
                Hovered = function ()
                   -- print("Test is okay")
                end,
                Active = function ()
                   --print("Test is okay")
                end,
                SubMenu = nil,
                Condition = function()
                    if "job" == "job" then
                        --Activated = false
                        return true
                    end
                end

            },
            {
                Type = "button",
                Title = "My Test SubMenu Button",
                SubTitle = "My SubMenu button's subtitle",
                Activated = true,
                Badges = {  },
                Selected = function ()
                    --print("test")
                end,
                Hovered = function ()
                   -- print("Test is okay")
                end,
                Active = function ()
                   --print("Test is okay")
                end,
                SubMenu = {'showcase', 'SubMenu'},

            }
        },
        Panels = {

          --[[  {
                Type = "gridhorizontal",
                PosIndex = nil,
                X = 0.5,
                LeftLabel = "Gauche",
                RightLabel = "Droite",
                --[[Hovered = function ()
                   -- print("Test is okay")
                end,
                Active = function ()
                   --print("Test is okay")
                end,             
            },
            {
                Type = "grid",
                PosIndex = nil,
                X = 0.5,
                Y = 0.5,
                LeftLabel = "Gauche",
                RightLabel = "Droite",
                TopLabel = "Haut",
                BottomLabel = "Bas",
                --[[Hovered = function ()
                   -- print("Test is okay")
                end,
                Active = function ()
                   --print("Test is okay")
                end,            
            },
            {
                Type = "gridvertical",
                Y = 0.5,
                TopLabel = "Haut",
                BottomLabel = "Bas",
                PosIndex = nil,
                --[[Hovered = function ()
                   -- print("Test is okay")
                end,
                Active = function ()
                   --print("Test is okay")
                end,             
            },]]
            {
                Type = "percentage",
                Title = "My Test percentage Panel",
                PosIndex = nil,
                Percent = 0.5,                
                MinText = "Min text",
                MaxText = "Max text"
                --[[Hovered = function ()
                   -- print("Test is okay")
                end,
                Active = function ()
                   --print("Test is okay")
                end,]]
            },
            {
                Type = "statistic",
                Title = "My Test statistic Panel",
                Percent = 0.5,                
                PosIndex = nil,
                --[[Hovered = function ()
                   -- print("Test is okay")
                end,
                Active = function ()
                   --print("Test is okay")
                end,]]
            },
            --[[{
                Type = "colour",
                Title = "My Test colour Panel",
                Colours = 50,
                Index = 7,
                --[[Hovered = function ()
                   -- print("Test is okay")
                end,
                Active = function ()
                   --print("Test is okay")
                end,
            } ]]




        },
        SubMenus = {
            {
                mIndex = "showcase",
                Name = "SubMenu",
                Title = "Test Sub MEnu",
                SubTitle = "~b~Test Submenu subtitle",
                --Header = true, --OPTIONAL
                --Glare = true, --OPTIONAL
                --Instructional = true, --OPTIONAL
                --TextureDictionary ="", --OPTIONAL
                --TextureName = "", --OPTIONAL
                Items = {
                    {
                        Type = "list",
                        Title = "My Test List",
                        SubTitle = "My List's subtitle",
                        Activated = true,
                        List = {"My","Test", "List"},
                        Index = 1,
                        Badges = {  },
                        Selected = function (k,v)
                            v.Title ="My List's Value :  " .. v.List[v.Index]
                        end,
                        Hovered = function ()
                        -- print("Test is okay")
                        end,
                        Active = function ()
                            print("Test is okay")
                        end,
                        SubMenu = nil,
        
                    },
                    {
                        Type = "checkbox",
                        Title = "My Test test checkbox",
                        SubTitle = "My SubMenu checkbox's subtitle",
                        Activated = true,
                        Badges = {  },
                        Index = 1,
                        Selected = function ()
                            --print("test")
                        end,
                        Hovered = function ()
                        -- print("Test is okay")
                        end,
                        Active = function ()
                        end,
                        SubMenu = nil,
                    },
                    {
                        Type = "slider",
                        Title = "My Test test Slider",
                        SubTitle = "My SubMenu Slider's subtitle",
                        Activated = true,
                        Badges = {  },
                        Index = 1,
                        IndexMax = 10,
                        Divider = 1,
                        Selected = function (k,v)
                            v.Title ="My Slider's Value :  " .. v.Index
                            
                        end,
                        Hovered = function (k,v)
                            

                        end,
                        Active = function ()
                        end,
                        SubMenu = nil,
                    }
                }
            },
        }
    }
}

---------------------------------------------------
GenMenu(Menu)