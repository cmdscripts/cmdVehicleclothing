fx_version "adamant"
games { "gta5" }
lua54 "yes"

author "cmdscripts"
version "1.0"

shared_scripts {
	"@es_extended/imports.lua",
	"@ox_lib/init.lua",
	"config.lua"
}

client_script "client.lua"
server_script "server.lua"

dependencies {
	"es_extended",
	"ox_lib"
}