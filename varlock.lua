local install_packages = function(packages, flags)
    flags = flags or " " 
    str = "pacman " .. flags .. " " .. table.concat(packages, " ")
    os.execute(str)
    print(str)
end

local make_dir = function(dirs, commands)
    commands = commands or " "
    for k,v in ipairs(dirs) do
        os.execute("cd " .. v .. "&& make " .. commands)
    end
end


local curl = function(url, output)
    str = "curl " .. url .. " -o " .. output
    os.execute(str)
    print(str)
end

local hollow = function(repos, dirs)
    for k,v in ipairs(repos) do
        for i,j in ipairs(dirs) do
            str = "git clone " .. v .. " " ..  j  
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


local catppuccin_rice = function(format)
    local minimal = function()
        packages = {"cava", "neofetch", "kitty", "xorg", "xorg-xinit", "git", "base-devel", "dmenu"}
        repos = {"https://github.com/kavulox/dwm"}
        install_packages(packages, "-Syu --noconfirm")
        hollow(repos, {"/usr/src/dwm/"})
        make_dir({"/usr/src/dwm/"}, "clean install")
        os.execute("exit")
        curl("https://raw.githubusercontent.com/catppuccin/wallpapers/main/waves/cat-blue-eye.png", ".wallpaper.png") 
        os.execute("mv .wallpaper.png $HOME/.wallpaper.png")
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
