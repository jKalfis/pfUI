pfUI:RegisterSkin("Books", function ()
  local function SetWhite(text)
    if text then
      text:SetTextColor(1, 1, 1, 1)
      text:SetShadowColor(0, 0, 0, 1)
      text:SetShadowOffset(1, -1)
    end
  end

  local function SetGold(text)
    if text then
      text:SetTextColor(1, .82, 0, 1)
      text:SetShadowColor(0, 0, 0, 1)
      text:SetShadowOffset(1, -1)
    end
  end

  local function SetItemTextColors()
    SetGold(ItemTextTitleText)
    SetWhite(ItemTextPageText)
    SetWhite(ItemTextCurrentPage)
  end

  StripTextures(ItemTextFrame)
  CreateBackdrop(ItemTextFrame, nil, nil, .75)
  CreateBackdropShadow(ItemTextFrame)

  ItemTextFrame.backdrop:SetPoint("TOPLEFT", 12, -12)
  ItemTextFrame.backdrop:SetPoint("BOTTOMRIGHT", -30, 72)
  ItemTextFrame:SetHitRectInsets(12,30,12,72)
  EnableMovable(ItemTextFrame)

  SkinCloseButton(ItemTextCloseButton, ItemTextFrame.backdrop, -6, -6)

  ItemTextScrollFrame:SetWidth(292)
  ItemTextPageText:SetWidth(282)
  ItemTextPageText:ClearAllPoints()
  ItemTextPageText:SetPoint("TOPLEFT", 4, -15)

  ItemTextTitleText:ClearAllPoints()
  ItemTextTitleText:SetPoint("TOP", ItemTextFrame.backdrop, "TOP", 0, -10)

  StripTextures(ItemTextScrollFrame)
  CreateBackdrop(ItemTextScrollFrame, nil, true, 0)
  SkinScrollbar(ItemTextScrollFrameScrollBar)
  ItemTextScrollFrame:ClearAllPoints()
  ItemTextScrollFrame:SetPoint("TOPRIGHT", -66, -46)

  -- black background
  local bg = ItemTextScrollFrame:CreateTexture(nil, "BORDER")
  bg:SetAllPoints()
  bg:SetTexture(0, 0, 0, .50)

  -- force black background instead of parchment
  ItemTextMaterialTopLeft.SetTexture = function(self, texture)
    bg:SetTexture(0, 0, 0, .50)
  end

  ItemTextMaterialTopLeft.Hide = function()
    bg:SetTexture(0, 0, 0, .50)
  end

  -- disable material backgrounds
  ItemTextMaterialTopLeft.Show = function() return end
  ItemTextMaterialTopRight.Show = function() return end
  ItemTextMaterialBotLeft.Show = function() return end
  ItemTextMaterialBotRight.Show = function() return end

  ItemTextMaterialTopLeft:Hide()
  ItemTextMaterialTopRight:Hide()
  ItemTextMaterialBotLeft:Hide()
  ItemTextMaterialBotRight:Hide()

  ItemTextCurrentPage:ClearAllPoints()
  ItemTextCurrentPage:SetPoint("TOP", ItemTextScrollFrame, "BOTTOM", 0, -10)

  local orig_SetText = ItemTextCurrentPage.SetText
  ItemTextCurrentPage.SetText = function(self, text)
    text = format(PAGE_NUMBER, text)
    orig_SetText(self, text)
    SetWhite(self)
  end

  ItemTextCurrentPage:SetFontObject("GameFontWhite")

  SkinArrowButton(ItemTextPrevPageButton, "left", 18)
  ItemTextPrevPageButton:ClearAllPoints()
  ItemTextPrevPageButton:SetPoint("TOPLEFT", ItemTextScrollFrame, "BOTTOMLEFT", 0, -6)

  SkinArrowButton(ItemTextNextPageButton, "right", 18)
  ItemTextNextPageButton:ClearAllPoints()
  ItemTextNextPageButton:SetPoint("TOPRIGHT", ItemTextScrollFrame, "BOTTOMRIGHT", 0, -6)

  ItemTextNextPageButton.Show = function(self) self:Enable() end
  ItemTextNextPageButton.Hide = function(self) self:Disable() end
  ItemTextPrevPageButton.Show = function(self) self:Enable() end
  ItemTextPrevPageButton.Hide = function(self) self:Disable() end

  do -- do not hide the scrollbar
    ItemTextScrollFrame:Show()
    ItemTextScrollFrameScrollBar:Show()
    ItemTextScrollFrameScrollBarScrollUpButton:Show()
    ItemTextScrollFrameScrollBarScrollDownButton:Show()

    ItemTextScrollFrame.Show = function(self) end
    ItemTextScrollFrame.Hide = function(self) end
    ItemTextScrollFrameScrollBar.Show = function(self) self.thumb:Show() end
    ItemTextScrollFrameScrollBar.Hide = function(self) self.thumb:Hide() end
    ItemTextScrollFrameScrollBarScrollUpButton.Show = function(self)
      if self:GetParent():GetValue() ~= 0 then
        self:Enable()
      end
    end
    ItemTextScrollFrameScrollBarScrollUpButton.Hide = function(self)
      self:Disable()
    end
    ItemTextScrollFrameScrollBarScrollDownButton.Show = function(self)
      self:Enable()
    end
    ItemTextScrollFrameScrollBarScrollDownButton.Hide = function(self)
      self:Disable()
    end

    local first
    ItemTextFrame:HookScript("OnShow", function()
      if not first then -- it is necessary to update the scrollbar when you first open the frame
        ItemTextScrollFrameScrollBar:Show()
        ItemTextScrollFrameScrollBar:Hide()
        ItemTextScrollFrameScrollBarScrollUpButton:Show()
        ItemTextScrollFrameScrollBarScrollUpButton:Hide()
        ItemTextScrollFrameScrollBarScrollDownButton:Show()
        ItemTextScrollFrameScrollBarScrollDownButton:Hide()
        first = true
      end

      SetItemTextColors()
    end)
  end

  CreateBackdrop(ItemTextStatusBar, nil, true)
  ItemTextStatusBar:DisableDrawLayer("OVERLAY")
  ItemTextStatusBar:SetStatusBarTexture(pfUI.media["img:bar"])
  ItemTextStatusBar:SetHeight(12)
  ItemTextStatusBar:ClearAllPoints()
  ItemTextStatusBar:SetPoint("BOTTOM", ItemTextScrollFrame, "BOTTOM", 0, 50)

  SetItemTextColors()
end)
