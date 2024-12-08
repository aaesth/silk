local decalId = "rbxassetid://13333189485" -- blehhh

local function addDecal(object)
    if object:IsA("BasePart") then
        local decal = Instance.new("Decal")
        decal.Texture = decalId
        decal.Face = Enum.NormalId.Front -- blehhh
        decal.Parent = object
    end
end

for _, object in ipairs(game:GetDescendants()) do
    pcall(addDecal, object)
end

game.DescendantAdded:Connect(function(object)
    pcall(addDecal, object)
end)
