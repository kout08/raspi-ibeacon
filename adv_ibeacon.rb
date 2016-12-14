info = `ifconfig eth0`
mac_addr = info.match(/\w\w:\w\w:\w\w:\w\w:\w\w:\w\w/)

puts "GET mac_addr : #{mac_addr}"
dev_id = `curl -F "mac_addr=#{mac_addr}" http://n302.herokuapp.com/id_maker`
DEV_ID = dev_id.to_i
puts "GET device id : #{DEV_ID}"

ADVERTISEMENT_TIME = 200
SERVICE_UUID = "9e205570-1407-442a-a9be-0e3aa7420a7a"
MINOR = 1
RSSI = -29
puts "Start advertise ibeacon."
`sudo ./bluez-ibeacon/bluez-beacon/ibeacon #{ADVERTISEMENT_TIME} #{SERVICE_UUID} #{dev_id} "#{MINOR}" #{RSSI}`
