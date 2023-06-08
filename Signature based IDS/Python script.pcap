from jnetpcap import Pcap, PcapIf, PcapPacket, PcapPacketHandler, FormatUtils
from jnetpcap.protocol.lan import Ethernet
from jnetpcap.protocol.network import Ip4, Ip6
from jnetpcap.protocol.tcpip import Tcp
from jnetpcap.protocol.tcpip import Udp
from jnetpcap.protocol.network import Icmp
from jnetpcap.nio import JBuffer

def main():
    devs = PcapIf.getAllDevs()
    if devs is None or len(devs) == 0:
        print("Can't read list of devices")
        return

    print("Network devices found:")
    for i, device in enumerate(devs):
        description = device.getDescription() or "No description available"
        print(f"#{i}: {device.getName()} [{description}]")

    device = devs[2]  # Select the interface on which you think the traffic is located
    print(f"\nChoosing '{device.getDescription() or device.getName()}' on your behalf:")
    macI = ':'.join(f"{b:02X}" for b in device.getHardwareAddress())
    print(f"{device.getName()}={macI}")

    snaplen = 64 * 1024
    flags = Pcap.MODE_PROMISCUOUS
    timeout = 10 * 1000
    pcap = Pcap.openLive(device.getName(), snaplen, flags, timeout)

    if pcap is None:
        print(f"Error while opening device for capture: {pcap.getErr()}")
        return

    def packet_handler(user, header, packet):
        eth = Ethernet()
        ip = Ip4()
        tcp = Tcp()
        udp = Udp()
        icmp = Icmp()
        ip6 = Ip6()

        packet.getHeader(eth)
        if packet.hasHeader(ip):
            packet.getHeader(ip)
            source_ip = FormatUtils.ip(ip.source())
            destination_ip = FormatUtils.ip(ip.destination())
            mac = FormatUtils.mac(eth.source())

            print(mac)
            print(f"srcIP={source_ip} dstIP={destination_ip} caplen={header.getCaplen()}")

            if source_ip == destination_ip:
                print("Source and Destination address are the same: Possible IP spoofing - Land Attack")

            ip_spoofing(mac, macI, source_ip)

        if packet.hasHeader(tcp):
            packet.getHeader(tcp)
            payload = ip.getOffset() + ip.size()
            buffer = JBuffer(payload)
            buffer.peer(packet, payload, packet.size() - payload)
            dataS = buffer.toHexdump()

            syn_fin(tcp, packet)
            fin(tcp, packet)
            null_packet(tcp, packet)
            reserved(tcp, packet)
            port_check(tcp, packet)
            ack_check(tcp, packet)
            syn_check(tcp, packet, dataS)

        if packet.hasHeader(udp):
            packet.getHeader(udp)
            port_check_udp(udp, packet)

        if packet.hasHeader(icmp):
            payload = ip.getOffset() + ip.size()
            echo_check(payload, packet)

        if packet.hasHeader(ip6):
            print("IPv6 packet detected: suspicious")

    print("Capturing packets...")
    pcap.loop(-1, packet_handler, None)
    pcap.close()

def ip_spoofing(mac, macI, source_ip):
    reserved_ip = ["192.168.1.4", "192.168.1.1", "192.168.1.7", "172.16.0.3"]

    if mac != macI and source_ip not in reserved_ip:
       
