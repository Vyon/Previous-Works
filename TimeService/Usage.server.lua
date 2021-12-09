-- Usage written 12/9/2021

local time_service = require(script.TimeService)
local current_time = time_service.time('est')
local current_date = time_service.date()

print('Current Time:', current_time)
print('Current Date:', current_date)