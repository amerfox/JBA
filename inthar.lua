function intharr(msg)
text = nil
if msg and msg.content and msg.content.text then
xname =  (Redis:get(Fast.."Name:Bot") or "𓊆 𝑱 𝑩 𝑨𓊇") 
text = msg.content.text.text
if text:match("^"..xname.." (.*)$") then
text = text:match("^"..xname.." (.*)$")
end
end
if tonumber(msg.sender_id.user_id) == tonumber(Fast) then
return false
end
if text then
local neww = Redis:get(Fast.."Get:Reides:Commands:Group"..msg.chat_id..":"..text) or Redis:get(Fast.."All:Get:Reides:Commands:Group"..text)
if neww then
text = neww or text
end
end


if text then
if text:match('^انذار @(%S+)$') or text:match('^إنذار @(%S+)$') then
if not msg.Admin then
return send(msg.chat_id,msg.id,'\n*⌔︙هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
local UserName = text:match('^انذار @(%S+)$') or text:match('^إنذار @(%S+)$')
local UserId_Info = bot.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg.chat_id,msg.id,"\n⌔︙عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg.chat_id,msg.id,"\n⌔︙عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg.chat_id,msg.id,"\n⌔︙عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local UserInfo = bot.getUser(UserId_Info.id)
local zz = Redis:get(Fast.."zz"..msg.chat_id..UserInfo.id)
if not zz then
Redis:set(Fast.."zz"..msg.chat_id..UserInfo.id,"1")
return send(msg.chat_id,msg.id,Reply_Status(UserInfo.id,"⌔︙تم اعطاءه انذار وتبقا له اثنين ").Reply,"md",true)  
end
if zz == "1" then
Redis:set(Fast.."zz"..msg.chat_id..UserInfo.id,"2")
return send(msg.chat_id,msg.id,Reply_Status(UserInfo.id,"⌔︙تم اعطاءه انذارين وتبقا له انذار ").Reply,"md",true)  
end
if zz == "2" then
Redis:del(Fast.."zz"..msg.chat_id..UserInfo.id)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'كتم', data = msg.sender_id.user_id..'mute'..UserInfo.id}, 
},
{
{text = 'تقييد', data = msg.sender_id.user_id..'kid'..UserInfo.id},  
},
{
{text = 'حظر', data = msg.sender_id.user_id..'ban'..UserInfo.id}, 
},
}
}
return send(msg.chat_id,msg.id,Reply_Status(UserInfo.id,"⌔︙اختار العقوبه الان ").Reply,"md",true, false, false, true, reply_markup)
end
end 
end
if text == "انذار" or text == "إنذار" then
if msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg.chat_id,msg.id,'\n*⌔︙هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Fast.."ch:admin")
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n⌔︙عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = bot.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = bot.getUser(Message_Reply.sender_id.user_id)
if StatusCanOrNotCan(msg.chat_id,UserInfo.id) then
return send(msg.chat_id,msg.id,"\n*⌔︙عذرآ لا تستطيع استخدام الامر على { "..Controller(msg.chat_id,UserInfo.id).." } *","md",true)  
end
local zz = Redis:get(Fast.."zz"..msg.chat_id..UserInfo.id)
if not zz then
Redis:set(Fast.."zz"..msg.chat_id..UserInfo.id,"1")
return send(msg.chat_id,msg.id,Reply_Status(UserInfo.id,"⌔︙تم اعطاءه انذار وتبقا له اثنين ").Reply,"md",true)  
end
if zz == "1" then
Redis:set(Fast.."zz"..msg.chat_id..UserInfo.id,"2")
return send(msg.chat_id,msg.id,Reply_Status(UserInfo.id,"⌔︙تم اعطاءه انذارين وتبقا له انذار ").Reply,"md",true)  
end
if zz == "2" then
Redis:del(Fast.."zz"..msg.chat_id..UserInfo.id)
local reply_markup = bot.replyMarkup{
type = 'inline',
data = {
{
{text = 'كتم', data = msg.sender_id.user_id..'mute'..UserInfo.id}, 
},
{
{text = 'تقييد', data = msg.sender_id.user_id..'kid'..UserInfo.id},  
},
{
{text = 'حظر', data = msg.sender_id.user_id..'ban'..UserInfo.id}, 
},
}
}
return send(msg.chat_id,msg.id,Reply_Status(UserInfo.id,"⌔︙اختر العقوبه الان").Reply,"md",true, false, false, true, reply_markup)
end
end
end

end
return {Fast = intharr}