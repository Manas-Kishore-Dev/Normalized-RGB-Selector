local color = { r = 0.5, g = 0.5, b = 0.5 }
local sliders = {}
local buttonWidth = 60
local buttonHeight = 20

function love.load()
    love.window.setTitle("Normalized RGB Selector")
    love.window.setMode(400, 320)

    sliders = {
        { name = "Red", value = color.r, y = 50 },
        { name = "Green", value = color.g, y = 100 },
        { name = "Blue", value = color.b, y = 150 }
    }
end

function love.update(dt)
    for _, slider in ipairs(sliders) do
        if love.mouse.isDown(1) then
            local mx, my = love.mouse.getPosition()
            if my > slider.y and my < slider.y + 20 and mx > 50 and mx < 350 then
                slider.value = (mx - 50) / 300
            end
        end
    end

    color.r = sliders[1].value
    color.g = sliders[2].value
    color.b = sliders[3].value
end

function love.mousepressed(x, y, button)
    if button == 1 then
        -- Copy Normalized Value
        if x > 320 and x < 320 + buttonWidth and y > 270 and y < 270 + buttonHeight then
            local normalized = string.format("(%.2f, %.2f, %.2f)", color.r, color.g, color.b)
            love.system.setClipboardText(normalized)
        end

        -- Copy RGB Value
        if x > 320 and x < 320 + buttonWidth and y > 295 and y < 295 + buttonHeight then
            local rgb = string.format("(%d, %d, %d)", color.r * 255, color.g * 255, color.b * 255)
            love.system.setClipboardText(rgb)
        end
    end
end

function love.draw()
    -- Background
    love.graphics.clear(0.1, 0.1, 0.1)

    -- Color Preview
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.rectangle("fill", 50, 200, 300, 60)

    -- Draw Sliders
    for _, slider in ipairs(sliders) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(slider.name, 10, slider.y, 40, "right")

        -- Track
        love.graphics.setColor(0.2, 0.2, 0.2)
        love.graphics.rectangle("fill", 50, slider.y, 300, 20)

        -- Knob
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", 50 + slider.value * 300 - 5, slider.y, 10, 20)
    end

    -- Display Values
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(
        string.format("Normalized: (%.2f, %.2f, %.2f)", color.r, color.g, color.b),
        50, 270, 300, "left"
    )
    love.graphics.printf(
        string.format("RGB: (%d, %d, %d)", color.r * 255, color.g * 255, color.b * 255),
        50, 295, 300, "left"
    )

    -- Copy Buttons
    -- Normalized Copy Button
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", 320, 270, buttonWidth, buttonHeight)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Copy", 320, 270 + 5, buttonWidth, "center")

    -- RGB Copy Button
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", 320, 295, buttonWidth, buttonHeight)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Copy", 320, 295 + 5, buttonWidth, "center")
end
