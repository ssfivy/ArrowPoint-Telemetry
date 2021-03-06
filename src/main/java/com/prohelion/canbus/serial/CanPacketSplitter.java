package com.prohelion.canbus.serial;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.annotation.Splitter;
import org.springframework.stereotype.Component;

import com.prohelion.canbus.model.CanPacket;
import com.prohelion.canbus.model.UdpPacket;

@Component
public class CanPacketSplitter {

    private static final Logger LOG = LoggerFactory.getLogger(CanPacketSplitter.class);
    
    @Splitter
    public List<CanPacket> extractCanPackets(UdpPacket udpPacket) {
        LOG.debug("Extracting {} CanPackets from udpPacket", udpPacket.getCanPackets().size());
        
        return udpPacket.getCanPackets();
    }
}
