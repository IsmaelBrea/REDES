import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.canvas.integrated.IntegratedCanvasVisualizer;
import inet.common.scenario.ScenarioManager;

import inet.node.inet.ManetRouter;

network Manet
{
    parameters:
        @display("bgb=1290,520");
        int n;

    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("p=80,70");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=80,190");
        }
        visualizer: IntegratedCanvasVisualizer {
            @display("p=80,310");
        }
        scenario: ScenarioManager {
            @display("p=80,430");
        }

        static1: ManetRouter {
            @display("i=device/wifilaptop;p=200,250");
        }
        static2: ManetRouter {
            @display("i=device/wifilaptop;p=1200,250");
        }
        mobile[n]: ManetRouter {
            @display("i=device/pocketpc;p=700,250");
        }
    connections allowunconnected:
}

