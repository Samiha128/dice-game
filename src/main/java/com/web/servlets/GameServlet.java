package com.web.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bo.GameState;
import bo.User;
import helpers.contextemanagement;
import java.util.Random;


@WebServlet("/GameServlet")
public class GameServlet extends HttpServlet {
    private contextemanagement gameContext;

    @Override
    public void init() throws ServletException {
        super.init();
        gameContext = contextemanagement.getInstance(getServletContext());
    }

    protected void play(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        GameState gameState = (GameState) session.getAttribute("gameState");
        if (gameState == null) {
            // Initialiser gameState si c'est null
            gameState = new GameState(user);
            session.setAttribute("gameState", gameState);
        }

        // Récupérer le numéro de dé à lancer depuis le formulaire
        String diceNumberStr = request.getParameter("diceNumber");
        if (diceNumberStr != null && !diceNumberStr.isEmpty()) {
            int diceNumber = Integer.parseInt(diceNumberStr);
	    if (diceNumber < 1 || diceNumber > 3) {
	                // Si le numéro du dé n'est pas valide, rediriger vers la page d'erreur
	                response.sendRedirect(request.getContextPath() + "/Web_inf/vues/back/error.jsp");
	                return;
	            }
           

            // Récupérer la liste des dés déjà lancés
            List<Integer> rolledDice = (List<Integer>) session.getAttribute("rolledDice");
            if (rolledDice == null) {
                rolledDice = new ArrayList<>();
                session.setAttribute("rolledDice", rolledDice);
            }
            if (rolledDice.contains(diceNumber)) {
                // Si le dé a déjà été lancé, arrêter la partie et attribuer un score de -1
                gameState.setGameOver(true);
                user.setScore(-1); // Définir le score de l'utilisateur à -1
                gameContext.updateScore(user);
                session.setAttribute("score", -1);
               
                // Pas besoin d'invalider la session ni de réinitialiser le compteur de lancer
                getServletContext().getRequestDispatcher("/Web_inf/vues/back/score.jsp").forward(request,response);
        
                
           
                return;
        
                
           
            }
            if (rolledDice.size() == 2) {
                Random random = new Random();
                int result1 = random.nextInt(6) + 1;
                int result2 = random.nextInt(6) + 1;
                int result3 = random.nextInt(6) + 1;

                if (result1 < result2 && result2 < result3) {
                    int score = result1 + result2 + result3;
                    user.setScore(score);
                    gameContext.updateScore(user);
                    session.setAttribute("score", score);
                    
                    // Rediriger vers la page de jeu
                    getServletContext().getRequestDispatcher("/Web_inf/vues/back/score.jsp").forward(request, response);
                    return; // Terminer la méthode après la redirection
                } else if (result1 == 6 || result1 == 5) {
                    // Si result1 est égal à 6 ou 5, attribuer un score de 0
                    user.setScore(0);
                    session.setAttribute("score", 0);
                    getServletContext().getRequestDispatcher("/Web_inf/vues/back/score.jsp").forward(request, response);
                }
            }

            // Rediriger vers la page de jeu si le score n'a pas été calculé
            getServletContext().getRequestDispatcher("/Web_inf/vues/back/test.jsp").forward(request, response);

            


            // Vérifier si ce dé a déjà été lancé
           

            // Ajouter le dé à la liste des dés déjà lancés
            rolledDice.add(diceNumber);
        }

        // Rediriger vers la page de jeu
        getServletContext().getRequestDispatcher("/Web_inf/vues/back/test.jsp").forward(request, response);
    }
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        play(request, response);
    }

    // Méthode pour réinitialiser l'ID de session
    private void resetSessionId(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate(); // Invalider la session actuelle

        // Créer une nouvelle session
        HttpSession newSession = request.getSession(true);

        // Récupérer les informations de l'utilisateur à partir du contexte
        List<User> userList = gameContext.getAllUsers();

        // Vérifier si la liste des utilisateurs n'est pas vide
        if (userList != null && !userList.isEmpty()) {
            // Récupérer le dernier utilisateur de la liste (celui ajouté le plus récemment)
            User us = userList.get(userList.size() - 1);

            // Vérifier si l'utilisateur du contexte n'est pas null avant de créer un nouvel utilisateur
            if (us != null) {
                // Créer un nouvel utilisateur avec les informations du contexte
                User newUser = new User();
                newUser.setPrenom(us.getPrenom());
                newUser.setemail(us.getemail());
                newUser.setScore(0);
                newUser.setPassword(us.getPassword());

                // Stocker le nouvel utilisateur dans la session
                newSession.setAttribute("user", newUser);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newGameButton = request.getParameter("newGameButton");

        // Vérifier si le formulaire "Nouvelle partie" est soumis
        if (newGameButton != null && newGameButton.equals("newGame")) {
            resetSessionId(request); // Réinitialiser l'ID de session
        }

        play(request, response);
    }
    
}