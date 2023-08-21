#!/usr/bin/env python

import agentspeak
import agentspeak.runtime
import agentspeak.stdlib

import os
import pprint

from py4j.java_gateway import JavaGateway, java_import

gateway = JavaGateway()
java_import(gateway.jvm, "py4j.examples.JavaAgentSpeakClient")

actions = agentspeak.Actions(agentspeak.stdlib.actions)

@actions.add_function(".call_java_agentspeak", (int, ))
def call_java_agentspeak(x):
    stack = gateway.entry_point.getStack();
    pprint.pprint("Adding to stack: "+str(x));
    stack.push(str(x));
    return 1;

env = agentspeak.runtime.Environment()

with open(os.path.join(os.path.dirname(__file__), "agent.asl")) as source:
    agent = env.build_agent(source, actions)

if __name__ == "__main__":
    env.run_agent(agent)
