fx_version 'adamant'

game 'gta5'

description 'getSteam'

version '1.0.3'

server_only 'yes'
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'main.lua',
}
