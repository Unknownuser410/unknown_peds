fx_version 'cerulean'
game 'gta5'

author "Unknown_user410"
description "Peds Script"
version "1.0.1"


server_script {
	"@oxmysql/lib/MySQL.lua",
	'script/server.lua',
}

client_script {
	'script/client.lua',
}

files {
	'meta/*.meta',
}

data_file 'PED_METADATA_FILE' 'meta/example.meta' --peds.meta eintragen--
