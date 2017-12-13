--[[
Explosive Gaming

This file can be used with permission but this and the credit below must remain in the file.
Contact a member of management on our discord to seek permission to use our code.
Any changes that you may make to the code are yours but that does not make the script yours.
Discord: https://discord.gg/r6dC2uK
]]
--Please Only Edit Below This Line-----------------------------------------------------------
--this function can be called at any time to make an announcement
function announcement(message,rank,player)
	if not message then return end
	local rank = ranking.string_to_rank(rank) or ranking.string_to_rank_group('User').lowest_rank
	local player = player or '<server>'
	ExpGui.draw_frame.popup('announcement',{player,rank,message})
end
--this is the in game gui for the announcements
ExpGui.add_input.button('send_message',{'announcements.button-send-message'},{'announcements.button-send-message-tooltip'},function(player,element)
	local text = element.parent.parent.input.text
	local rank = ranking.string_to_rank(element.parent.drop_down.get_item(element.parent.drop_down.selected_index))
	ExpGui.draw_frame.popup('announcement',{player,rank,text})
	element.parent.parent.parent.destroy()
end)

ExpGui.add_frame.popup('announcement','item/programmable-speaker',{'announcements.toolbar-tooltip'},
function(player,frame)
	frame.style.maximal_width = 600
	local text_box = frame.add{name='input',type='text-box'}
	text_box.text = 'Enter Message To Send'
	text_box.read_only = false
	text_box.word_wrap = true
	text_box.selectable = true
	text_box.style.maximal_width = 400
	text_box.style.minimal_width = 400
	text_box.style.minimal_height = 100
	local flow = frame.add{name='flow',type='flow',direction='horizontal'}
	ExpGui.add_input.draw_button(flow,'send_message','Send')
	flow.add{name='label',type='label',caption={'announcements.send-to-ranks'},style="caption_label"}
	local drop_down = flow.add{name='drop_down',type='drop-down'}
	for n,rank_name in pairs(ranking.get_ranks('name')) do drop_down.add_item(rank_name) if rank_name == 'Guest' then drop_down.selected_index = n end end
end,
function(player,frame,args)
	frame.style.maximal_width = 600
	local from_rank = nil; if args[1] == '<server>' then from_rank='<server>' else from_rank = ranking.get_player_rank(args[1]).name end
	local to_rank = nil; if args[2].name == 'Guest' then to_rank = 'Everyone' else to_rank = args[2].name..'s' end
	if ranking.get_player_rank(player).power > args[2].power then frame.parent.destroy() else
		frame.add{name='label',type='label',caption={'announcements.message',from_rank,to_rank},style="caption_label"}
		local text_box = frame.add{name='message',type='text-box'}
		text_box.text = args[3]
		text_box.read_only = true
		text_box.word_wrap = true
		text_box.selectable = true
		text_box.style.maximal_width = 400
		text_box.style.minimal_width = 400
	end
end)