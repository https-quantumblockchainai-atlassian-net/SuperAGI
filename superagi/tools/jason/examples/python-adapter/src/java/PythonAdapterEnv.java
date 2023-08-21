import jason.asSyntax.Literal;
import jason.asSyntax.Structure;
import jason.environment.Environment;

import org.jpl7.Util;
import org.jpl7.Compound;
import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Variable;

// import py4j.examples.StackEntryPoint;
import py4j.examples.JavaAgentSpeakClient;

public class PythonAdapterEnv extends Environment {

    // Literal init0  = Literal.parseLiteral("continue");

    private JavaAgentSpeakClient java_agentspeak_client;

    @Override
    public void init(String[] args) {
	this.java_agentspeak_client = new JavaAgentSpeakClient();
	String[] myargs = new String[0];
	this.java_agentspeak_client.main(myargs);
	Query.oneSolution("consult('jason_python_wrapper.pl')");
        // initial perceptsd
        // addPercept(init0);
    }

    public Environment getEnvironment() {
	return this;
    }

    public String processPrologCall(Term[] arr) {
	System.out.println("Started call from Prolog");
	int i;
	for (i = 0; i < arr.length; ++i) {
	    Term oneTerm = arr[i];
	    System.out.println("XXXXX: " + "<<<" + oneTerm.toString() + ">>>");
	    addPercept(Literal.parseLiteral(oneTerm.toString()));
	}
	System.out.println("Received call from Prolog");
	informAgsEnvironmentChanged();
	System.out.println("Env Changed, Agents Informed");
	return "Received call from Prolog";
    }

    /**
     * Implementation of the agent's basic actions
     */
    @Override
    public boolean executeAction(String ag, Structure act) {

        clearPercepts();

	if (act.toString().equals("jpl_poll")) {
	    try {
		var string0 = "jpl_poll_messages("+ag+",Result)";
		// System.out.println("  " + string0);
		var solution0 =  Query.oneSolution(string0);
		var result0 = solution0.get("Result");
		if (result0.isVariable()) {
		    // System.out.println("\t" + ag + " has no return value");
		} else {
		    if (! result0.toString().equals("'[]'")) {
			System.out.println("JPL_POLL RESULT: " + result0.toString());
			// need to convert this to a array of terms and call processPrologCall
			Term[] arr1 = Util.listToTermArray(result0);
			int i;
			for (i = 0; i < arr1.length; ++i) {
			    Term[] arr = Util.listToTermArray(arr1[i]);
			    processPrologCall(arr);
			}
		    }
		}
		return true;
	    } catch (Exception e) {
		System.out.println("error executing " + ag + " for " + act + ": " + e.toString());
		// throw e;
		return false;
	    }
	} else {
	    System.out.println("Agent "+ag+" is doing "+act);
	    try {
		var string1 = "jpl_execute_action("+ag+","+act+",Result)";
		System.out.println("  " + string1);
		var solution1 =  Query.oneSolution(string1);
		var result1 = solution1.get("Result");
		if (result1.isVariable()) {
		    System.out.println("\t" + ag + " has no return value");
		    // getEnvironmentInfraTier().getRuntimeServices().stopMAS();
		} else {
		    var string2 = "jpl_perceive("+ag+",Percepts,Result)";
		    System.out.println("  " + string2);
		    var solution2 =  Query.oneSolution(string2);
		    var percepts2 =  solution2.get("Percepts");

		    // /System.out.println("\t" + ag + " currentEvents: " + currentEvents);
		    Term[] arr = Util.listToTermArray(percepts2);
		    int i;
		    for (i = 0; i < arr.length; ++i) {
			Term oneTerm = arr[i];
			System.out.println("\t" + ag + " <<<" + oneTerm.toString() + ">>>");
			addPercept(Literal.parseLiteral(oneTerm.toString()));
		    }
		    var result2 = solution2.get("Result");
		    System.out.println("\t" + ag + " Result " + result2.toString());
		} 
		System.out.println("");
		informAgsEnvironmentChanged();
		return true;
	    } catch (Exception e) {
		System.out.println("error executing " + ag + " for " + act + ": " + e.toString());
		// throw e;
		return false;
	    }
	}
    }
}

