fx_version 'cerulean'
game 'gta5'

description 'Pharmacy Robbery'
version '1.0'
author 'Luniz'

lua54 'yes'

shared_script {
	'Config.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}