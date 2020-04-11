---@param menuTbl table
function GenMenu(menuTbl)
    if menuTbl ~= nil then
        for _,v in next, menuTbl do
            RMenu.Add(v.mIndex, v.Name, RageUI.CreateMenu(IsNilStr(v.Title), v.SubTitle),nil,nil,v.TextureDictionary,v.TextureName)
            if v.EnableMouse then
                RMenu:Get(v.mIndex, v.Name).EnableMouse = true
            end
            if v.Closed and IsFunction(v.Closed) then
                RMenu:Get(v.mIndex, v.Name).Closed = v.Closed
            end
            for kk,vv in next, v.SubMenus do
                RMenu.Add(vv.mIndex, vv.Name, RageUI.CreateSubMenu(RMenu:Get(v.mIndex, v.Name), IsNilStr(vv.Title), vv.SubTitle),nil,nil,vv.TextureDictionary,vv.TextureName)
                if vv.EnableMouse then
                    RMenu:Get(vv.mIndex, vv.Name).EnableMouse = true
                end
                if vv.Closed and IsFunction(vv.Closed) then
                    RMenu:Get(vv.mIndex, vv.Name).Closed = vv.Closed
                end
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
        return "Error"
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

function IsNilBool(Var)
    if Var == nil then
        return true
    else
        return Var
    end
end

function IsNilStr(Var)
    if Var == nil then
        return ""
    else
        return Var
    end
end

function M_IsVisible(v)
    RageUI.IsVisible(RMenu:Get(v.mIndex, v.Name), IsNilBool(v.Header), IsNilBool(v.Glare), IsNilBool(v.Instructional), function()
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

        if _v.Condition == nil then
            _v.Condition = function()
                return true
            end
        end
        if _v.Badges == nil then
            _v.Badges = {}
        end
        if _v.Title == nil then
            _v.Title = ""
        end
        if _v.SubTitle == nil then
            _v.SubTitle = ""
        end
        if _v.Condition() then
            if _v.Type == "button" then
                RageUI.Button(_v.Title, _v.SubTitle, _v.Badges, IsNilBool(_v.Activated), function(Hovered, Active, Selected)
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
                if _v.Index == nil then
                    _v.Index = 1 
                end

                local SubMenusList = {}

                for _,v in next, _v.SubMenu do
                    table.insert( SubMenusList, RMenu:Get(v[1], v[2]))
                end

                RageUI.List(_v.Title, _v.List,  _v.Index, _v.SubTitle, _v.Badges, IsNilBool(_v.Activated), function(Hovered, Active, Selected, Index)
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
                end,SubMenusList)

            elseif _v.Type == "checkbox" then
                if _v.Index == nil then
                    _v.Index = 1 
                end
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
                if _v.Divider == nil then
                    _v.Divider = false
                end
                RageUI.Slider(_v.Title, _v.Index, _v.IndexMax, _v.SubTitle, _v.Divider, _v.Badges, IsNilBool(_v.Activated), function(Hovered, Selected, Active, Index)
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

function DrawPanels(tblPanels)
    for _k,_v in next, tblPanels do
        if _v.Type == "gridhorizontal" then
            RageUI.GridPanelHorizontal(_v.X, _v.LeftLabel, _v.RightLabel, function(Hovered, Active, X)
                _v.X = X
                if (Hovered) and IsFunction(_v.Hovered) then
                    _v.Hovered(_k, _v)
                end
                if (Active) and IsFunction(_v.Active) then
                    _v.Active(_k, _v)
                end
               
            end, _v.PosIndex)

        elseif _v.Type == "grid" then
            RageUI.GridPanel(_v.X, _v.Y, _v.TopLabel, _v.BottomLabel, _v.LeftLabel, _v.RightLabel, function(Hovered, Active, X, Y)
                _v.X = X
                _v.Y = Y
                if (Hovered) and IsFunction(_v.Hovered) then
                    _v.Hovered(_k, _v)
                end
                if (Active) and IsFunction(_v.Active) then
                    _v.Active(_k, _v)
                end
            end, _v.PosIndex)

        elseif _v.Type == "gridvertical" then
            RageUI.GridPanelVertical(_v.Y, _v.TopLabel, _v.BottomLabel, function(Hovered, Active, Y)
                _v.Y = Y
                if (Hovered) and IsFunction(_v.Hovered) then
                    _v.Hovered(_k, _v)
                end
                if (Active) and IsFunction(_v.Active) then
                    _v.Active(_k, _v)
                end
            end, _v.PosIndex)

        elseif _v.Type == "colour" then
            RageUI.ColourPanel(_v.Title, _v.Colours, _v.Index[1], _v.Index[2] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                if (Active) then
                    _v.Index[2] = CurrentIndex - 1
                    _v.Index[1] = MinimumIndex
                    if IsFunction(_v.Active) then
                        _v.Active(_k, _v)
                    end
                end
                if (Hovered) and IsFunction(_v.Hovered) then
                    _v.Hovered(_k, _v)
                end
            end, _v.PosIndex)

        elseif _v.Type == "percentage" then
            RageUI.PercentagePanel(_v.Percent, _v.Title, _v.MinText, _v.MaxText, function(Hovered, Active, Percent)
                _v.Percent = Percent

                if (Hovered) and IsFunction(_v.Hovered) then
                    _v.Hovered(_k, _v)
                end
                if (Active) and IsFunction(_v.Active) then
                    _v.Active(_k, _v)
                end
            end, _v.PosIndex)

        elseif _v.Type == "statistic" then
            RageUI.StatisticPanel(_v.Percent, _v.Title, _v.PosIndex)

        end
    end
end

