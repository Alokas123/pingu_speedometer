fx_version 'cerulean'
games { 'gta5' }

author 'Pingu and JokkeX'
description 'Very simple speedometer utilising ox_lib'

version '1.0.0'

client_script 'client.lua'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
}

dependency 'ox_lib'