fx_version 'adamant'

game 'gta5'

description 'ExeLds Vehicles Advanced Kilometer Script'

version '1.0.0'

server_scripts {
    'config.lua',
    'server/main.lua',
	'@mysql-async/lib/MySQL.lua'
}

client_scripts {
    'config.lua',
    'client/main.lua'
}
