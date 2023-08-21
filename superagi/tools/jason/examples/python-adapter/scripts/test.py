import pprint
from py4j.java_gateway import JavaGateway, java_import

gateway = JavaGateway()

java_import(gateway.jvm, "py4j.examples.StackEntryPoint")

java_list = gateway.jvm.java.util.ArrayList()
java_list.append(214)
java_list.append(120)
gateway.jvm.java.util.Collections.sort(java_list)
pprint.pprint(java_list)

# stack = gateway.entry_point.getStack()



# stack = gateway.jvm.py4j.examples.getStack
stack = gateway.entry_point.getStack()
pprint.pprint(stack)

result = stack.pop()

pprint.pprint(result)

# stack.push("First %s" % ('item'))

# stack.push("Second item")

# u'Second item'
# stack.pop()
# u'First item'
# stack.pop()
# u'Initial Item'
