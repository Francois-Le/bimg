function bimg_include()
    local baseFolder = debug.getinfo(1,'S').source:match("^@(.+)/buildSystem/build.lua$")

    includedirs { path.join(baseFolder, "include") }
end

function bimg_project(options)
    options = options or {}
    local baseFolder = debug.getinfo(1,'S').source:match("^@(.+)/buildSystem/build.lua$")

    project "bimg"
        kind "StaticLib"
        language "C++"
        cppdialect "C++14"
        targetdir "%{wks.location}/bin/%{cfg.buildcfg}/%{prj.name}"
        location "%{wks.location}/%{prj.name}"
        exceptionhandling "Off"
        rtti "Off"
        files
        {
            path.join(baseFolder, "include/bimg/*.h"),
            path.join(baseFolder, "src/image.cpp"),
            path.join(baseFolder, "src/image_gnf.cpp"),
            path.join(baseFolder, "src/*.h"),
            path.join(baseFolder, "3rdparty/astc-codec/src/decoder/*.cc")
        }
        includedirs
        {
            path.join(baseFolder, "include"),
            path.join(baseFolder, "3rdparty/astc-codec"),
            path.join(baseFolder, "3rdparty/astc-codec/include"),
        }
        bx_include()

        if options.dependson then
            dependson { options.dependson }
        end
end