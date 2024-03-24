package filtrers;
import jakarta.servlet.http.HttpFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import bo.Message;

import jakarta.servlet.*;

public class ExceptionFilter {
	
	Logger LOGGER = Logger.getLogger(getClass());

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		LOGGER.debug("Execution du filtre ExceptionFilter");
		try {

			chain.doFilter(request, response);

		} catch (Exception e) {
			LOGGER.debug("Erreur gérée par le filtre. Cause de l'exception :" + e.getMessage(), e);
			List<Message> list = new ArrayList<>();
			list.add(new Message("Une erreur est survenue veuillez consulter le fichier journal pour plus de détails",
					Message.ERROR));
			request.setAttribute("messages", list);
			getServletContext().getRequestDispatcher("/WEB-INF/vues/pages/error.jsp").forward(request, response);

		}
	}
	
	
	
	
	

}
