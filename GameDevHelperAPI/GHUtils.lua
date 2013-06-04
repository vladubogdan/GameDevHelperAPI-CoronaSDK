
module (..., package.seeall)

--!@docBegin
--!This file contains helper methods needed by the GameDevHelper API. Users should also find this methods useful.
--! 
--!@docEnd

--------------------------------------------------------------------------------
--!@docBegin
--!Loads json file and returns contents as a string.
--!@param filename The path to the json file.
--!@param base Optional parametter. Where it should look for the file. Default is system.ResourceDirectory.
function jsonFileContent( filename, base )
--!@docEnd

	-- set default base dir if none specified
	if not base then base = system.ResourceDirectory; end
	
	-- create a file path for corona i/o
	local path = system.pathForFile( filename, base )
	
	-- will hold contents of file
	local contents
	
	-- io.open opens a file at path. returns nil if no file found
	local file = io.open( path, "r" )
	if file then
	   -- read all contents of file into a string
	   contents = file:read( "*a" )
	   io.close( file )	-- close the file after using it
	end
	
	return contents
end


--!@docBegin
--!Returns the extention given a path string.
--!@param path A string representing the path.
--!@code
--!    local GHUtils =  require("GameDevHelperAPI.GHUtils");
--!    local ext = GHUtils.filenameExtension("Assets/image.png");
--!    --will return "png"
--!@endcode
function filenameExtension( path )
--!@docEnd
    return path:match( "%.([^%.]+)$" )
end

--!@docBegin
--!Returns the path without the extension.
--!@param path A string representing the path.
--!@code
--!    local GHUtils =  require("GameDevHelperAPI.GHUtils");
--!    local ext = GHUtils.stripExtension("Assets/image.png");
--!    --will return "Assets/image"
--!@endcode
function stripExtension( path )
--!@docEnd

	local i = path:match( ".+()%.%w+$" )
	if ( i ) then return path:sub(1, i-1) end
	return path

end

--!@docBegin
--!Returns the path without the filename.
--!@param path A string representing the path.
--!@code
--!    local GHUtils =  require("GameDevHelperAPI.GHUtils");
--!    local ext = GHUtils.getPathFromFilename("Assets/image.png");
--!    --will return "Assets/"
--!@endcode
function getPathFromFilename(path)
--!@docEnd
	return path:match( "^(.*[/\\])[^/\\]-$" ) or ""
end

--@docBegin
--Returns only the filename, without the path component.
--@param path A string representing the path.
--!@code
--!    local GHUtils =  require("GameDevHelperAPI.GHUtils");
--!    local ext = GHUtils.getFileFromFilename("Assets/image.png");
--!    --will return "image.png"
--!@endcode
function getFileFromFilename(path)
--!@docEnd
	return path:match( "[\\/]([^/\\]+)$" ) or ""
end

--!@docBegin
--!Replace all occurances of a string with another string.
--!@param str The string to use for the replace action.
--!@param toFind The string that should be replaced.
--!@param toreplace The string that should be be used.
--!@code
--!    local GHUtils =  require("GameDevHelperAPI.GHUtils");
--!    local ext = GHUtils.replaceOccuranceOfStringWithString("Assets/image.png", "png", "JPG");
--!    --will return "Assets/image.JPG"
--!@endcode
function replaceOccuranceOfStringWithString( str, tofind, toreplace )
--!@docEnd
    tofind = tofind:gsub( "[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1" )
	toreplace = toreplace:gsub( "%%", "%%%1" )
	return ( str:gsub( tofind, toreplace ) )
end

--!@docBegin
--!Given a string like "{500, 400}", returns a table like {x = 500, y = 400}
--!@param str The string representing a point value.
function pointFromString(str)
--!@docEnd

    local xStr = 0;
	local yStr = 0;
	local function pointHelper(a,b)
		xStr = tonumber(a)
		yStr = tonumber(b)
	end

	string.gsub(str, "{(.*), (.*)}", pointHelper) 
	return  { x = xStr, y = yStr}
end
--------------------------------------------------------------------------------
--function lh_sizeFromString(str)
--
--	local wStr = 0;
--	local hStr = 0;
--	
--	local function sizeHelper(a, b)
--		wStr = tonumber(a)
--		hStr = tonumber(b)
--	end
--	local retinaRatio = 1; --should be added shortly in LHSettings
--	
--	string.gsub(str, "{(.*), (.*)}", sizeHelper) 
--	return  { width = wStr/retinaRatio, height = hStr/retinaRatio}				
--end
--function lh_printSize(obj)
--
--	print("{ size = { width: " .. tostring(obj.width) .. " height: " .. tostring(obj.height) .. " }}");
--end

--------------------------------------------------------------------------------
--function lh_rectFromString(str)
--
--	local xStr = 0;
--	local yStr = 0;
--	local wStr = 0;
--	local hStr = 0;
--
--	local function rectHelper(a, b, c, d)
--		xStr = tonumber(a)
--		yStr = tonumber(b)
--		wStr = tonumber(c)
--		hStr= tonumber(d)
--	end
--
--	local retinaRatio = 1; --should be added shortly in LHSettings
--
--	string.gsub(str, "{{(.*), (.*)}, {(.*), (.*)}}", rectHelper)
--	return { origin = {x = xStr*retinaRatio, y = yStr*retinaRatio}, 
--			   size = {width = wStr*retinaRatio, height = hStr*retinaRatio}}
--end
