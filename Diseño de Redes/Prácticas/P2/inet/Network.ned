import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.configurator.ipv6.Ipv6FlatNetworkConfigurator;
import inet.visualizer.canvas.integrated.IntegratedCanvasVisualizer;

import inet.node.inet.StandardHost;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.Router;
import inet.node.ethernet.Eth1G;

network Network
{
    parameters:
        @display("bgb=600,600");
        int n;

    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("p=80,60");
        }
        configurator6: Ipv6FlatNetworkConfigurator {
            @display("p=80,160");
        }
        visualizer: IntegratedCanvasVisualizer {
            @display("p=80,260");
        }
        server_remote: StandardHost {
            @display("p=300,60;i=device/server");
        }
        host[n]: StandardHost {
            @display("p=300,300,c,80;i=device/pc");
        }
        server_local: StandardHost {
            @display("p=300,220;i=device/server");
        }
        switch: EthernetSwitch {
            @display("p=200,260");
        }
        router: Router {
            @display("p=200,160");
        }
    connections:
        server_local.ethg++ <--> Eth1G <--> switch.ethg++;
        for i=0..n-1 {
            host[i].ethg++ <--> Eth1G <--> switch.ethg++;
        }
        switch.ethg++ <--> Eth1G <--> router.ethg++;
        server_remote.ethg++ <--> Eth1G <--> router.ethg++;
}
