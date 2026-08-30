pfUI:RegisterSkin("Gossip and Quest", function ()
  local frames = {'Quest', 'Gossip'}
  local panels = {'Greeting', 'Detail', 'Progress', 'Reward'}
  local buttons = {
    QuestFrameGreetingGoodbyeButton, GossipFrameGreetingGoodbyeButton,
    QuestFrameDeclineButton, QuestFrameAcceptButton,
    QuestFrameGoodbyeButton, QuestFrameCompleteButton,
    QuestFrameCancelButton, QuestFrameCompleteQuestButton
  }

  for _, button in pairs(buttons) do
    SkinButton(button)
  end

  local function SetWhite(text)
    if text then
      text:SetTextColor(1, 1, 1, 1)
      text:SetShadowColor(0, 0, 0, 1)
      text:SetShadowOffset(1, -1)
    end
  end

  local function SetButtonWhite(button)
    if not button then return end

    local text = button:GetFontString()

    if text then
      SetWhite(text)
    end

    if button.normalText then
      SetWhite(button.normalText)
    end

    if button.highlightText then
      SetWhite(button.highlightText)
    end

    if button.disabledText then
      SetWhite(button.disabledText)
    end

    local regions = {button:GetRegions()}

    for _, region in pairs(regions) do
      if region and region:GetObjectType() == "FontString" then
        SetWhite(region)
      end
    end
  end

  local function SetGossipButtonsWhite()
    for i = 1, 32 do
      SetButtonWhite(_G["GossipTitleButton"..i])
      SetButtonWhite(_G["QuestTitleButton"..i])
    end
  end

  local function SetQuestTextWhite()
    local texts = {
      QuestTitleText,
      QuestDescriptionText,
      QuestProgressTitleText,
      QuestProgressText,
      QuestProgressRequiredItemsText,
      QuestProgressRequiredMoneyText,
      QuestRewardTitleText,
      QuestRewardText,
      QuestRewardRewardTitleText,
      QuestRewardItemChooseText,
      QuestRewardItemReceiveText,
      QuestRewardSpellLearnText,
      QuestDetailItemReceiveText,
      QuestDetailSpellLearnText,
      GreetingText,
      GossipGreetingText,
      CurrentQuestsText,
      AvailableQuestsText,
      QuestObjectiveText,
      QuestObjectivesText,
      QuestObjectiveTitleText,
      QuestObjectivesTitleText
    }

    for _, text in pairs(texts) do
      SetWhite(text)
    end

    SetWhite(QuestFrameNpcNameText)
    SetWhite(GossipFrameNpcNameText)
    SetGossipButtonsWhite()
  end

  do
    StripTextures(QuestGreetingScrollChildFrame)

    QuestTitleText:SetPoint("TOPLEFT", 10, -10)
    QuestProgressTitleText:SetPoint("TOPLEFT", 10, -10)

    StripTextures(QuestRewardItemHighlight)
    local QuestRewardItemHighlight = CreateFrame("Frame", nil, QuestRewardScrollChildFrame)
    local QuestRewardItemHighlightBG = QuestRewardItemHighlight:CreateTexture(nil, "OVERLAY")
    QuestRewardItemHighlightBG:SetTexture(1,1,1,.2)
    QuestRewardItemHighlightBG:SetAllPoints()

    hooksecurefunc("QuestFrameItems_Update", function()
      QuestRewardItemHighlight:Hide()
      SetQuestTextWhite()
    end)

    hooksecurefunc("QuestRewardItem_OnClick", function()
      if this.type == "choice" then
        QuestRewardItemHighlight:SetAllPoints(this.backdrop)
        QuestRewardItemHighlight:Show()
      end
    end)

    if QuestFrame_SetTextColor then
      hooksecurefunc("QuestFrame_SetTextColor", function(text)
        SetWhite(text)
      end)
    end

    if QuestFrame_SetTitleTextColor then
      hooksecurefunc("QuestFrame_SetTitleTextColor", function(text)
        SetWhite(text)
      end)
    end

    if QuestInfo_Display then
      hooksecurefunc("QuestInfo_Display", function()
        SetQuestTextWhite()
      end)
    end

    if GossipFrameUpdate then
      hooksecurefunc("GossipFrameUpdate", function()
        SetQuestTextWhite()
        SetGossipButtonsWhite()
      end)
    end

    if GossipFrameAvailableQuestsUpdate then
      hooksecurefunc("GossipFrameAvailableQuestsUpdate", function()
        SetGossipButtonsWhite()
      end)
    end

    if GossipFrameActiveQuestsUpdate then
      hooksecurefunc("GossipFrameActiveQuestsUpdate", function()
        SetGossipButtonsWhite()
      end)
    end

    if GossipFrameOptionsUpdate then
      hooksecurefunc("GossipFrameOptionsUpdate", function()
        SetGossipButtonsWhite()
      end)
    end

    if QuestFrameGreetingPanel_OnShow then
      hooksecurefunc("QuestFrameGreetingPanel_OnShow", function()
        SetQuestTextWhite()
        SetGossipButtonsWhite()
      end)
    end

    if QuestFrameDetailPanel_OnShow then
      hooksecurefunc("QuestFrameDetailPanel_OnShow", function()
        SetQuestTextWhite()
      end)
    end

    if QuestFrameProgressPanel_OnShow then
      hooksecurefunc("QuestFrameProgressPanel_OnShow", function()
        SetQuestTextWhite()
      end)
    end

    if QuestFrameRewardPanel_OnShow then
      hooksecurefunc("QuestFrameRewardPanel_OnShow", function()
        SetQuestTextWhite()
      end)
    end

    for _, name in pairs({ "QuestProgressItem", "QuestDetailItem", "QuestRewardItem" }) do
      for i = 1, 6 do
        local name = name .. i
        local item = _G[name]
        local icon = _G[name.."IconTexture"]
        local count = _G[name.."Count"]
        local title = _G[name.."Name"]

        local xsize = item:GetWidth() -12
        local ysize = item:GetHeight() -12

        item:SetWidth(xsize)
        StripTextures(item)
        CreateBackdrop(item, nil, nil, .75)
        SetAllPointsOffset(item.backdrop, item, 4)
        SetHighlight(item)

        icon:SetWidth(ysize)
        icon:SetHeight(ysize)
        icon:ClearAllPoints()
        icon:SetPoint("LEFT", 6, 0)
        icon:SetTexCoord(.08, .92, .08, .92)
        icon:SetParent(item.backdrop)
        icon:SetDrawLayer("OVERLAY")

        count:SetParent(item.backdrop)
        count:SetDrawLayer("OVERLAY")

        title:SetParent(item.backdrop)
        title:SetDrawLayer("OVERLAY")

        SetWhite(title)
      end
    end
  end

  for _, f in pairs(frames) do
    local frameName = f
    local frame = _G[frameName.."Frame"]
    local NPCName = _G[frame:GetName().."NpcNameText"]

    CreateBackdrop(frame, nil, nil, .75)
    CreateBackdropShadow(frame)

    frame.backdrop:SetPoint("TOPLEFT", 12, -18)
    frame.backdrop:SetPoint("BOTTOMRIGHT", -28, 66)
    frame:SetHitRectInsets(12,28,18,66)
    EnableMovable(frame)

    SkinCloseButton(_G[frame:GetName()..'CloseButton'], frame.backdrop, -6, -6)

    _G[frame:GetName()..'Portrait']:Hide()

    NPCName:ClearAllPoints()
    NPCName:SetPoint("TOP", frame.backdrop, "TOP", 0, -10)

    SetWhite(NPCName)

    for _, v in pairs(panels) do
      local panel = v
      if frameName == 'Gossip' and panel ~= 'Greeting' then break end

      local fname = frame:GetName()..panel.."Panel"
      StripTextures(_G[fname])

      local scroll = _G[frameName..panel.."ScrollFrame"]
      scroll:SetHeight(330)
      SkinScrollbar(_G[scroll:GetName().."ScrollBar"])
      CreateBackdrop(scroll, nil, true, 0)

      local bg = scroll:CreateTexture(nil, "LOW")
      bg:SetAllPoints()
      bg:SetTexture(0, 0, 0, .50)

      _G[fname.."MaterialTopLeft"].SetTexture = function(self, texture)
        bg:SetTexture(0, 0, 0, .50)
      end

      _G[fname.."MaterialTopLeft"].Hide = function()
        bg:SetTexture(0, 0, 0, .50)
      end

      _G[fname.."MaterialTopLeft"].Show = function() return end
      _G[fname.."MaterialTopRight"].Show = function() return end
      _G[fname.."MaterialBotLeft"].Show = function() return end
      _G[fname.."MaterialBotRight"].Show = function() return end

      _G[fname.."MaterialTopLeft"]:Hide()
      _G[fname.."MaterialTopRight"]:Hide()
      _G[fname.."MaterialBotLeft"]:Hide()
      _G[fname.."MaterialBotRight"]:Hide()

      if panel ~= 'Greeting' then
        local num_items, hook_func

        if panel == 'Progress' then
          num_items = MAX_REQUIRED_ITEMS
          hook_func = "QuestFrameProgressItems_Update"
        else
          num_items = MAX_NUM_ITEMS
          hook_func = "QuestFrameItems_Update"
        end
      end
    end
  end

  SetQuestTextWhite()
end)
