// Internal action code for project FoodSimulation

package prolog;

import jason.asSemantics.DefaultInternalAction;
import jason.asSemantics.TransitionSystem;

import org.jpl7.Util;
import org.jpl7.Compound;
import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Variable;

import java.util.logging.Logger;

/** function that computes the distance between two number */
public class swi extends DefaultInternalAction {

    private Logger logger = Logger.getLogger("ExecutiveFunctionAdapter."+swi.class.getName());

    public void doProlog(TransitionSystem ts, jason.asSyntax.Term[] args) throws Exception {
        try {
            logger.warning("heya!");

            // int n1 = (int)((NumberTerm)args[0]).solve();
            // int n2 = (int)((NumberTerm)args[1]).solve();
            // return Math.abs(n1 - n2);

        } catch (Exception e) {
            logger.warning("Error in function 'swi.doProlog'! "+e);
        }
    }
}
