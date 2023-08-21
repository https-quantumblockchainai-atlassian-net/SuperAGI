package py4j.examples;

import py4j.GatewayServer;

public class JavaAgentSpeakClient {

    public Stack stack;

    public JavaAgentSpeakClient() {
	System.out.println("Initializing JavaAgentSpeak Client...");

	stack = new Stack();
	stack.push("Initial Item");

	System.out.println("Initialized JavaAgentSpeak Client.");
    }

    public Stack getStack() {
	return stack;
    }

    public void startStackEntryPoint()  {
    }

    public static void main(String[] args) {
	System.out.println("Starting Gateway Server...");
	GatewayServer gatewayServer = new GatewayServer(new JavaAgentSpeakClient());
	gatewayServer.start();
	System.out.println("Gateway Server Started");
    }

}
