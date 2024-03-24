package com.web.servlets;

import java.io.IOException;

import helpers.contextemanagement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import bo.User;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupérer les données du formulaire
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Vérifier si les données ne sont pas vides
        if (name != null && email != null && password != null && !name.isEmpty() && !email.isEmpty() && !password.isEmpty()) {
            // Créer un nouvel utilisateur
            User user = new User(name, email, password);
            
            // Ajouter l'utilisateur au contexte
            contextemanagement gameContext = contextemanagement.getInstance(getServletContext());
            gameContext.insertUser(user);
            
            // Rediriger vers une page de succès ou de confirmation
            getServletContext().getRequestDispatcher("/Web_inf/vues/back/login.jsp").forward(request, response);
        } else {
            // Les données du formulaire sont incomplètes ou manquantes, rediriger vers une page d'erreur
            response.sendRedirect(request.getContextPath() + "/registration-error.jsp");
        }
    }
}
