local install_packages = function(packages, flags)
    flags = flags or " " 
    str = "sudo pacman " .. flags .. " " .. table.concat(packages, " ")
    os.execute(str)
    print(str)
end

local make_dir = function(dirs, commands)
    commands = commands or " "
    for k,v in ipairs(dirs) do
        os.execute("cd " .. v .. "&& sudo make " .. commands)
    end
end


local curl = function(urls, outputs)
    sudo = sudo or ""
    for k,v in ipairs(urls) do
        for i,j in ipairs(outputs) do
            str = sudo .. "curl " .. v .. " -o " .. j  
            os.execute(str)
            print(str)
        end
    end
end

local hollow = function(repos, dirs, sudo)
    sudo = sudo or ""
    for k,v in ipairs(repos) do
        for i,j in ipairs(dirs) do
            str = sudo .. "git clone " .. v .. " " ..  j  
            os.execute(str)
            print("Cloned: " .. v .. "Into: " .. j)
        end
    end
end

-- [[ DWM CATPPUCCIN RICE
-- Packages: kitty feh xorg xorg-xinit git base-devel dmenu
-- Repo: https://github.com/kavulox/dwmx
-- Wallpaper: https://raw.githubusercontent.com/catppuccin/wallpapers/main/waves/cat-blue-eye.png
--


local catppuccin_rice = function(format, xinit)
    local minimal = function()
        packages = {"cava", "neofetch", "kitty", "xorg", "xorg-xinit", "git", "base-devel", "dmenu", "picom"}
        repos = {"https://github.com/kavulox/dwm"}
        install_packages(packages, "-Syu --noconfirm")
        hollow(repos, {"/usr/src/dwm/"}, "sudo ")
        make_dir({"/usr/src/dwm/"}, "clean install")
        os.execute("mkdir -p ~/.config/picom/")
        curl({"https://raw.githubusercontent.com/catppuccin/wallpapers/main/waves/cat-blue-eye.png"}, {"~/.wallpaper.png"}) 
        curl({"https://raw.githubusercontent.com/yshui/picom/next/picom.sample.conf"}, {"~/.config/picom/picom.conf"})
        if xinit == "true" then
            os.execute("echo \"feh --bg-scale ~/.wallpaper.png\" >> ~/.xinitrc && echo 'Made template at ~/.xinitrc'")
        else
            os.execute("feh --bg-scale ~/.wallpaper.png && picom -b")
        end
    end
    local full = function()
        print("Not currently implemented.")
    end
    if format == "minimal" then
        minimal()
    elseif format == "full" then
        full()
    else
        minimal()
    end
end

catppuccin_rice("minimal")
