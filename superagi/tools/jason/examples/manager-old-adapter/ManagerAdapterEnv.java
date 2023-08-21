import jason.asSyntax.Literal;
import jason.asSyntax.Structure;
import jason.environment.Environment;

import org.jpl7.Util;
import org.jpl7.Compound;
import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Variable;

public class ManagerAdapterEnv extends Environment {

    // Literal init0  = Literal.parseLiteral("continue");

    @Override
    public void init(String[] args) {
    Query.oneSolution("consult('jason_manager_wrapper.pl')");
        // initial percepts
        // addPercept(init0);
    }

    /**
     * Implementation of the agent's basic actions
     */
    @Override
    public boolean executeAction(String ag, Structure act) {
        System.out.println("Agent "+ag+" is doing "+act);

        clearPercepts();

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
