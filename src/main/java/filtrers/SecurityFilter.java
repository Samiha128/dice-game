package filtrers;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import filtrers.SecurityFilter;
public class SecurityFilter {
	private static final String CONNEXION_PAGE = "/Web_inf/vues/back/login.jsp";

	private final Logger LOGGER;

	public SecurityFilter() {
		LOGGER = Logger.getLogger(SecurityFilter.class);
	}



	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		LOGGER.debug("Le filtre de sécurité commence son travail ici ... ");

	
		HttpServletRequest rq = (HttpServletRequest) request;

		// On récupère la session
		HttpSession session = rq.getSession();

		// On vérifie si l'authentification a déjà eu lieu
		if (session.getAttribute("user") == null) {

			// Si non il faut interdir l'accès
			rq.getRequestDispatcher(CONNEXION_PAGE).forward(request, response);

			// Fin
			return;

		} else {

			// Si oui, alors continuer vers la resource suivante dans la chaine
			// (filtre suivant, servlet suivante ou jsp suivante..)
			chain.doFilter(request, response);

		}

	}
	
	
	

}
