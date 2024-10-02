fx_version 'cerulean'
game 'gta5'

client_scripts {
    'client/*.lua',
    'client/utils/*.lua',
}

shared_scripts {
    'shared/*.lua',
    'log.lua',
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/classes/framework.lua',
    'server/classes/citizen.lua',
    'server/classes/player.lua',
    'server/handler.lua',
    'server/main.lua',
}
