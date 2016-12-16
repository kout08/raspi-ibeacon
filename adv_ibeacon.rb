info = `ifconfig eth0`
mac_addr = info.match(/\w\w:\w\w:\w\w:\w\w:\w\w:\w\w/)

puts "GET mac_addr : #{mac_addr}"
dev_id_raw = `curl -F "mac_addr=#{mac_addr}" http://n302.herokuapp.com/id_maker`
dev_id = dev_id_raw.to_i
puts "GET device id : #{dev_id}"

ADVERTISEMENT_TIME = 200
#SERVICE_UUID = "9E205570-1407-442A-A9BE-0E3AA7420A7A"
SERVICE_UUID = "9E2055701407442AA9BE0E3AA7420A7A"
MINOR = 1
RSSI = -29
puts "Start advertise ibeacon."
DIR = File.dirname(__FILE__)
`sudo #{DIR}/bluez-ibeacon/bluez-beacon/ibeacon #{ADVERTISEMENT_TIME} #{SERVICE_UUID} #{dev_id} #{MINOR} #{RSSI}`
