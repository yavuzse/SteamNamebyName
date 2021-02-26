local DISCORD_WEBHOOK = ""
local DISCORD_NAME = "System"
local DISCORD_IMAGE = "https://pbs.twimg.com/profile_images/847824193899167744/J1Teh4Di_400x400.jpg" -- default is FiveM logo

RegisterCommand('getSteam', function(source, args, user)
	if IsPlayerAceAllowed(source, "command") then
		if args[1] == nil then
			print("no success firstname not found")
			return
		else
			if args[2] == nil then
				print("no success secondname not found")
			else
				MySQL.Async.fetchAll('SELECT * FROM users WHERE firstname = @firstname AND lastname = @lastname ', {
					['@firstname'] = args[1],
					['@lastname'] = args[2]
				}, function(result)
					print(json.encode(result[1].identifier))
					sendToDiscord("getSteam", result[1].identifier, 65280)
				end)
			end
		end
   end
end)

function sendToDiscord(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Made by Yavuz",
            },
        }
    }
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end
