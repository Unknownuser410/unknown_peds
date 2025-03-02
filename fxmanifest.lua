fx_version 'cerulean'
game 'gta5'


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
