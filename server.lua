money = {}
if fs.exists("/currectdata.txt") then
    local file = fs.open("/currectdata.txt", "r")
    money = textutils.unserialize(file.read())
    file.close()
end
rednet.open("back")
function waitforshutdown()
    local event, key = os.pullEvent("key")
    if key == keys.q then
        print("Shutting down")
        rednet.unhost("currect", os.getComputerLabel())
        rednet.close()
        local file = fs.open("/currectdata.txt", "w")
        file.write(textutils.serialize(money))
        file.close()
        error()
    end
end

function waitforrequest()
    id,request = rednet.receive()
    if request[1] == "transfer" then 
        if money[id] >= request[2] then 
            money[id] = money[id] - request[2]
            money[request[3]] = money[request[3]] + request[2]
        end
    end
    if request[1] == "balance" then 
        rednet.send(id, money[id])
    end
    if request[1] == "register" then
        money[id] = 10
    end
end

print("Server starting, press q to shut down.")
while true do
    rednet.host("currect", os.getComputerLabel())
    parallel.waitForAny(waitforshutdown, waitforrequest)
end