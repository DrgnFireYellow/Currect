rednet.open("back")
serverid = rednet.lookup("currect")
print("Connected to server with id " .. serverid)
print("Welcome to Currect!")
print("You're computer id is: " .. os.getComputerID())
print("Please select an option from the menu below:")
print("(0) Quit")
print("(1) Check Balance")
print("(2) Transfer funds")
print("(3) Register account WARNING: this will delete all existing account data")
choice = io.read()
if choice == "0" then
    print("Goodbye! Please come again!")
end
if choice == "1" then
    rednet.send(serverid, {"balance"})
    id,result = rednet.receive()
    if id == serverid then
        print(result)
    end
end
if choice == "2" then
    print("How much money would you like to transfer?")
    local moneytotransfer = tonumber(io.read())
    print("What is the computer id of the user you would like to transfer the money too?")
    local usertotransfertoo = tonumber(io.read())
    rednet.send(serverid, {"transfer", moneytotransfer, usertotransfertoo})
end
if choice == "3" then
    rednet.send(serverid, {"register"})
end
rednet.close()