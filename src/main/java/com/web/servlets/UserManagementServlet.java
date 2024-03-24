package com.web.servlets;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import bo.Message;
import bo.User;
import helpers.StockageManagement;

@WebServlet("/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String errorPage = "/Web-inf/vues/back/error.jsp";
        String loginForm = "/Web-inf/vues/back/login.jsp";
        ServletContext cntx = getServletContext();

        String name = request.getParameter("Name");
        String email = request.getParameter("Email");
        String password = request.getParameter("Password");

        // Création d'un nouvel utilisateur avec les informations fournies
        User user = new User( name , email , password, 0); // Pas besoin de meilleur score ici pour l'instant

        // Gestionnaire de contexte de jeu pour manipuler les données d'application
        StockageManagement gameContext = StockageManagement.getInstance(getServletContext());

        List<Message> messages = new ArrayList<>();

        // Ajout de l'utilisateur à la liste des utilisateurs
        gameContext.insertUser(user);

        // Message de succès pour la création du compte
        messages.add(new Message("Compte créé avec succès. Vous pouvez maintenant vous connecter.", Message.INFO));

        // Enregistrement des messages dans la requête pour affichage ultérieur
        request.setAttribute("messages", messages);

        // Redirection vers la page de connexion
        cntx.getRequestDispatcher(loginForm).forward(request, response);
    }
}
