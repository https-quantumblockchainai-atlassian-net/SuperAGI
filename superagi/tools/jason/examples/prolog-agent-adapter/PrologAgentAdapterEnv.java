import jason.asSyntax.Literal;
import jason.asSyntax.Structure;
import jason.environment.Environment;

import org.jpl7.Util;
import org.jpl7.Compound;
import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Variable;

public class PrologAgentAdapterEnv extends Environment {

    @Override
    public void init(String[] args) {
    Query.oneSolution("consult('jason_prolog_agent_wrapper.pl')");
    }

    /**
     * Implementation of the agent's basic actions
     */
    @Override
    public boolean executeAction(String ag, Structure act) {
        System.out.println("\tAgent "+ag+" is doing "+act);

        clearPercepts();

    try {
        var string = "jpl_prolog_agent_execute_action("+ag+","+act+",Answers,Result)";
        System.out.println("\t" + string);
        var solution =  Query.oneSolution(string);
        var answers = solution.get("Answers");
        System.out.println("\t" + "Answers: " + answers);
        if (answers.isVariable()) {
        // getEnvironmentInfraTier().getRuntimeServices().stopMAS();
        } else {
        Term[] arr = Util.listToTermArray(answers);
        int i;
        for (i = 0; i < arr.length; ++i) {
            Term oneTerm = arr[i];
            System.out.println("\t<<<" + oneTerm.toString() + ">>>");
            addPercept(Literal.parseLiteral(oneTerm.toString()));
        }
        } 
        var result = solution.get("Result");
        System.out.println("\t" + "Result " + result.toString());
        if (result.toString().equals("fail")) {
            System.out.println("\tFail");
        return false;
        } else {
            System.out.println("\tTrue");
        return true;
        }
        // System.out.println("");
        // informAgsEnvironmentChanged();
    } catch (Exception e) {
            System.out.println("error executing " + ag + " for " + act + ": " + e.toString());
        // throw e;
        return false;
    }
    }
}
