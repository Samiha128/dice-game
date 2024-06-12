package filtrers;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import bo.Message;



import org.apache.log4j.Level;
import org.apache.log4j.Logger;


import java.io.IOException;

public class ExceptionFilter implements Filter {

    private static final Logger LOGGER = Logger.getLogger(ExceptionFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation du filtre
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        LOGGER.debug("Execution du filtre ExceptionFilter");
        try {
            chain.doFilter(request, response);
        } catch (Exception e) {
            Level logLevel = LOGGER.getLevel();
            if (logLevel.equals(Level.WARN)) {
                request.getServletContext().getRequestDispatcher("/Web_inf/vues/pages/error404_warn.jsp").forward(request, response);
            } else if (logLevel.equals(Level.ERROR)) {
                request.getServletContext().getRequestDispatcher("/Web_inf/vues/pages/error.jsp").forward(request, response);
            } else {
                LOGGER.debug("Niveau de journalisation inconnu rencontré. Cause de l'exception : " + e.getMessage(), e);
                // Redirection vers une page par défaut si le niveau de log n'est pas géré
                request.getServletContext().getRequestDispatcher("/WEB-INF/vues/pages/error.jsp").forward(request, response);
            }
        }
    }

    @Override
    public void destroy() {
        // Destruction du filtre
    }
}

