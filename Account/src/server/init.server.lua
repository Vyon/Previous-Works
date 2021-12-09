local account = require(script.Account)

local new_account = account.New()

new_account:Add(math.random(1000, 5000))

new_account:Sub(100)

new_account:Transactions()

print(new_account.Balance)