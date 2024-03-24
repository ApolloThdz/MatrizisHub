local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "MatrisHub", HidePremium = false, SaveConfig = true, ConfigFolder = "MatrisHub"})

local Tab = Window:MakeTab({
    Name = "Trollagens",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "Trollar pessoas"
})

local Dropdown = Tab:AddDropdown({
    Name = "Matar Player",
    Default = "Selecione um jogador",
    Callback = function(Value)
        print("Selecionou o jogador:", Value)
    end
})

Tab:AddButton({
    Name = "Matar",
    Callback = function()
        local jogadorSelecionado = Dropdown:GetValue()
        if jogadorSelecionado ~= "Selecione um jogador" then
            -- Eliminar o jogador selecionado
            local jogador = game.Players:FindFirstChild(jogadorSelecionado)
            if jogador then
                jogador:Kick("Você foi eliminado do jogo.")
            else
                print("Jogador não encontrado.")
            end
        else
            print("Nenhum jogador selecionado")
        end
    end    
})

