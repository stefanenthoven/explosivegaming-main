--[[
Explosive Gaming

This file can be used with permission but this and the credit below must remain in the file.
Contact a member of management on our discord to seek permission to use our code.
Any changes that you may make to the code are yours but that does not make the script yours.
Discord: https://discord.gg/r6dC2uK
]]
--Please Only Edit Below This Line-----------------------------------------------------------
ExpGui.add_frame.center('readme',{'readme-gui.name'},{'readme-gui.tooltip'})

ExpGui.add_frame.tab('rules',{'readme-gui.rule-name'},{'readme-gui.rule-tooltip'},'readme',function(player,frame)
	for i = 1,10 do frame.add{name=i, type="label", caption={'readme-gui.rule'..tostring(i)}}.style.maximal_width=480 frame[i].style.single_line = false end
end)

ExpGui.add_frame.tab('chat',{'readme-gui.chat-name'},{'readme-gui.chat-tooltip'},'readme',function(player,frame)
    frame.add{name='chat', type="label", caption={'readme-gui.chat-caption'}}.style.maximal_width=480
    frame.chat.style.single_line = false
end)

ExpGui.add_frame.tab('commands',{'readme-gui.command-name'},{'readme-gui.command-tooltip'},'readme',function(player,frame)
    frame.add{name='intro', type="label", caption={'readme-gui.command-caption'}}.style.maximal_width=480
    frame.intro.style.single_line = false
	-- table setup
	frame.add{name='command_table',type='table',column_count=2}
	frame.command_table.add{name='command_title',type='label',caption={'readme-gui.command-command'}}
    frame.command_table.add{name='help_title',type='label',caption={'readme-gui.command-help'}}
    frame.command_table.draw_vertical_lines = true
    frame.command_table.draw_horizontal_line_after_headers = true
	-- adds all commands which this player can use
    for n,command in pairs(get_commands(ranking.get_player_rank(player).name)) do
        frame.command_table.add{name='command_'..n,type='label',caption='/'..command.name}
        frame.command_table.add{name='help_'..n,type='label',caption=command.help}.style.maximal_width=400
        frame.command_table['help_'..n].style.single_line = false
    end
end)
--[[
ExpGui.add_frame.tab('players',{'readme-gui.players-name'},{'readme-gui.players-tooltip'},'readme',function(player,frame)
    frame.add{name='intro', type="label", caption={'readme-gui.players-caption'}, single_line=false}.style.maximal_width=480
    local table_area = frame.add{type='flow',name='flow',direction='vertical'}
    ExpGui.player_table.draw_filters(player,table_area,{'player_name','online_time','rank'})
    ExpGui.player_table.draw(player,table_area,{{'player_name'},{'online_time'},{'rank'}},table_area)
end)]]
--Draws the read me gui when a player joins uses a loop hole do so so not recomened
Event.register(defines.events.on_player_joined_game,function(event) 
    local player = game.players[event.player_index]
    if not player.admin and tick_to_min(player.online_time) < 1 then
        local fake_button = {name='readme'}
        ExpGui.draw_frame.center(player,fake_button)
    end
end)


