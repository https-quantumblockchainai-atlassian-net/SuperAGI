package py4j.examples;

import py4j.GatewayServer;

public class StackEntryPoint {

    public Stack stack;
    public StackEntryPoint() {
	System.out.println("Creating StackEntryPoint");
	stack = new Stack();
	stack.push("Initial Item");
	System.out.println("Initial Item Pushed");
    }

    public Stack getStack() {
	return stack;
    }

    public void startStackEntryPoint()  {
    }

    public static void main(String[] args) {
	System.out.println("Starting Gateway Server...");
	GatewayServer gatewayServer = new GatewayServer(new StackEntryPoint());
	gatewayServer.start();
	System.out.println("Gateway Server Started");
    }

    // public void startStackEntryPoint() {
    // 	// if (running == false) {
    // 	    System.out.println("Starting Gateway Server...");
    // 	    // new StackEntryPoint()
    // 	    GatewayServer gatewayServer = new GatewayServer();
    // 	    // gatewayServer.start();
    // 	    System.out.println("Gateway Server Started");
    // 	    // running = true;
    // 	    // }
    // }

}
