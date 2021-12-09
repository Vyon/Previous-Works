local UserInputService = game:GetService("UserInputService")

local isOpen = false

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F2 then
        if isOpen == false then
            script.Parent.Visible = false
            isOpen = true
        elseif isOpen == true then
            script.Parent.Visible = true
            isOpen = false
        end
    end
end)