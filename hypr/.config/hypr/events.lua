hl.on("window.active", function(window)
    if window.class == "org.telegram.desktop" then
        hl.exec_cmd("hyprctl switchxkblayout current 1")
    else
        hl.exec_cmd("hyprctl switchxkblayout current 0")
    end
end)
