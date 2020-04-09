---@param menuTbl table
function GenMenu(menuTbl)
    if menuTbl ~= nil then
        for _,v in next, menuTbl do
            RMenu.Add(v.mIndex, v.Name, RageUI.CreateMenu(v.Title, v.SubTitle),nil,nil,v.TextureDictionary,v.TextureName)
            for kk,vv in next, v.SubMenus do
                RMenu.Add(vv.mIndex, vv.Name, RageUI.CreateSubMenu(RMenu:Get(v.mIndex, v.Name), vv.Title, vv.SubTitle),nil,nil,TextureDictionary,TextureName)
            end
            RageUI.CreateWhile(1.0, RMenu:Get(v.mIndex, v.Name), v.mBind, function()
                M_IsVisible(v)
                for kk,vv in next, v.SubMenus do
                    M_IsVisible(vv)
                end
            end)
        end
    else
        print("Error when building Menu, Table seems to be empty or nil")
    end
end
---- Don't need to use these functions -------
function IsFunction(fct)
    if type(fct) == "function" then
        return true
    else
        return false
    end
end
function M_IsVisible(v)
    if v.Header == nil then
        v.Header = true
    end
    if v.Glare == nil then
        v.Glare = true
    end
    if v.Instructional == nil then
        v.Instructional = true
    end
    RageUI.IsVisible(RMenu:Get(v.mIndex, v.Name), v.Header, v.Glare, v.Instructional, function()
        if v.Items ~= nil then
            DrawItems(v.Items)
        end
    end, function()
       ---Panels
        if v.Panels ~= nil then
            DrawPanels(v.Panels)
        end

   end)
end

function DrawItems(tblItems)
    for _k,_v in next, tblItems do
        if _v.SubMenu == nil then
            _v.SubMenu = {nil,nil}
        end
        if _v.Divider == nil then
            _v.Divider = false
        end
        if _v.Condition == nil then
            _v.Condition = function()
                return true
            end
        end
        if _v.Condition() then
            if _v.Type == "button" then
                RageUI.Button(_v.Title, _v.SubTitle, _v.Badges, _v.Activated, function(Hovered, Active, Selected)
                    if (Selected) and IsFunction(_v.Selected) then
                        _v.Selected(_k, _v)
                    end
                    if (Hovered) and IsFunction(_v.Hovered) then
                        _v.Hovered(_k, _v)
                    end
                    if (Active) and IsFunction(_v.Active) then
                        _v.Active(_k, _v)
                    end
                end,RMenu:Get(_v.SubMenu[1], _v.SubMenu[2]))
            elseif _v.Type == "list" then
                RageUI.List(_v.Title, _v.List,  _v.Index, _v.SubTitle, _v.Badges, _v.Activated, function(Hovered, Active, Selected, Index)
                    tblItems[_k].Index = Index;
                    if (Selected) and IsFunction(_v.Selected)then
                        _v.Selected(_k, _v)
                    end
                    if (Hovered) and IsFunction(_v.Hovered) then
                        _v.Hovered(_k, _v)
                    end
                    if (Active) and IsFunction(_v.Active) then
                        _v.Active(_k, _v)
                    end
                end, function()
                    local SubMenusList = {}
                    for _,v in next, _v.SubMenu do
                        table.insert( SubMenusList, RMenu:Get(v[1], v[2]))
                    end
                    return SubMenusList
                end)
            elseif _v.Type == "checkbox" then
                RageUI.Checkbox(_v.Title, _v.SubTitle, _v.Index, _v.Badges, function(Hovered, Selected, Active, Checked)
                    tblItems[_k].Index = Checked;
                    if (Selected) and IsFunction(_v.Selected) then
                        _v.Selected(_k, _v)
                    end
                    if (Hovered) and IsFunction(_v.Hovered) then
                        _v.Hovered(_k, _v)
                    end
                    if (Active) and IsFunction(_v.Active) then
                        _v.Active(_k, _v)
                    end
                end)
            elseif _v.Type == "slider" then
                RageUI.Slider(_v.Title, _v.Index, _v.IndexMax, _v.SubTitle, _v.Divider, _v.Badges, _v.Activated, function(Hovered, Selected, Active, Index)
                    tblItems[_k].Index = Index;
                    if (Selected) and IsFunction(_v.Selected) then
                        _v.Selected(_k, _v)
                    end
                    if (Hovered) and IsFunction(_v.Hovered) then
                        _v.Hovered(_k, _v)
                    end
                    if (Active) and IsFunction(_v.Active) then
                        _v.Active(_k, _v)
                    end
                end)
            end
        end
    end
end

function DrawPanels(tblPanels) -- Not implemented yet
    for _k,_v in next, tblPanels do
        if _v.Type == "gridhorizontal" then
            RageUI.GridPanelHorizontal(_v.X, _v.LeftLabel, _v.RightLabel, function(Hovered, Active, X)
                -- TODO Implemented working
            end, _v.PosIndex)
        elseif _v.Type == "grid" then
            RageUI.GridPanel(_v.X, _v.Y, _v.TopLabel, _v.BottomLabel, _v.LeftLabel, _v.RightLabel, function(Hovered, Active, X, Y)
                -- TODO Implemented working
            end, _v.PosIndex)
        elseif _v.Type == "gridvertical" then
            RageUI.GridPanelVertical(_v.Y, _v.TopLabel, _v.BottomLabel, function(Hovered, Active, Y)
                -- TODO Implemented working
            end, _v.PosIndex)
        elseif _v.Type == "colour" then
            RageUI.ColourPanel(_v.Title, _v.Colours, _v.Index.colored[1], _v.Index.colored[2] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                -- TODO Implemented working
                if (Active) then
                    _v.Index.colored[2] = CurrentIndex - 1
                    _v.Index.colored[1] = MinimumIndex
                end
            end, _v.PosIndex)
        elseif _v.Type == "percentage" then
            RageUI.PercentagePanel(_v.Percent, _v.Title, _v.MinText, _v.MaxText, function(Hovered, Active, Percent)
                if (Active) then
    
                end
                _v.Percent = Percent
            end, _v.PosIndex)
        elseif _v.Type == "statistic" then
            RageUI.StatisticPanel(_v.Percent, _v.Title, _v.PosIndex)
        end
    end
end

