package com.web.servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bo.GameState;

@WebServlet("/back/ReinitGameServlet")
public class ReinitGameServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Récupération de l'état du jeu de dé 2 depuis la session
        GameState gs = (GameState) session.getAttribute("gameState");

        if (gs != null) {
            // Réinitialisation de l'état du jeu
            gs.reinit();
        }

        // Réinitialisation du résultat précédent avec une valeur impossible pour le dé
        session.setAttribute("old_result", -1);

        // Redirection vers la page d'accueil de l'utilisateur
        getServletContext().getRequestDispatcher("/Web-inf/vues/back/home.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ce servlet ne gère pas les requêtes POST, donc il ne fait rien dans cette méthode
    }
}
