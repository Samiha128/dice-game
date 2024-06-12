package com.web.servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import bo.GameState;
import bo.User;
import helpers.contextemanagement;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpServletResponseWrapper;

/**
 * Servlet implementation class kogintest
 */


@WebServlet("/kogintest")
public class kogintest extends jakarta.servlet.http.HttpServlet {
private static final long serialVersionUID = 1L;
 
		 

    
    

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("email") == null || request.getParameter("password") == null) {
            // Rediriger vers la page de connexion (login.jsp)
            getServletContext().getRequestDispatcher("/Web_inf/vues/back/login.jsp").forward(request, response);
            return;
        }
        // Si les paramètres email et password sont présents, continuer vers la méthode doPost()
        doPost(request, response);
     // Vérifier si l'utilisateur est null
        User user = (User) request.getAttribute("user");
        if (request.getAttribute("user") != null) {
            // Rediriger vers la page d'erreur
            getServletContext().getRequestDispatcher("/Web_inf/vues/back/error404_warn.jsp").forward(request, response);
        }
        System.out.println("L'utilisateur est null.");
        
        // Rediriger vers la page d'erreur
        getServletContext().getRequestDispatcher("/Web_inf/vues/back/error404_warn.jsp").forward(request, response);
        
    }
	

	
		

	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// On récupére les données envoyées dans le formulaire
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		// On instancie la liste que nous utiliserons pour stocker les messages
		// à passer à la vue
		

		contextemanagement gameContext = contextemanagement.getInstance(getServletContext());

		// On recherche l'utilisateur par email
		User user =gameContext.getUserByemail(email.trim());
		// Si un utilisateur existe
		if(user==null) {
			request.getRequestDispatcher("/Web_inf/vues/back/error404_warn.jsp").forward(request, response);

		}
		if (user != null) {
		    // On vérifie que les mots de passe sont identiques
		    if (user.getPassword() != null && user.getPassword().equals(password)) {
		        // On stocke l'objet stockant l'état de jeu dans la session
		        GameState gameSate = new GameState(user);
		        request.getSession().setAttribute("gameState", gameSate);

		        // On stocke l'utilisateur authentifié dans la session
		        request.getSession().setAttribute("user", user);
		        gameContext.insertUser(user);
		        

		        // On envoie une vue qu'est la page home comme résultat
		        getServletContext().getRequestDispatcher("/Web_inf/vues/back/home.jsp").forward(request, response);

		        // Fin
		        return;
		    } else {
		        // Redirection vers la page error404 si le mot de passe est incorrect
		        response.sendRedirect(request.getContextPath() + "/Web_inf/vues/back/error404_warn.jsp");
		        return;
		    }
		} else {
		    // Redirection vers la page error404 si l'utilisateur n'est pas trouvé
		    response.sendRedirect(request.getContextPath() + "/Web_inf/vues/back/error404_warn.jsp");
		    return;
		}

	}
			
	

}
