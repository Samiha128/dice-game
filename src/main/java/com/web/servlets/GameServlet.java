package com.web.servlets;

import java.io.IOException;
import java.util.Random;

import bo.GameState;

import bo.User;
import helpers.contextemanagement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/GameServlet")
public class GameServlet extends HttpServlet {

    protected void play(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        contextemanagement gameContext = contextemanagement.getInstance(getServletContext());
        GameState gameState = (GameState) session.getAttribute("gameState");

        if (gameState.getDiceRolls() == 3 || gameState.isGameOver()) {
            session.setAttribute("score", gameState.getScore());
            gameState.addMessage(new Message("Partie terminée. Votre score : " + gameState.getScore(), Message.INFO));
            if (gameState.getScore() > user.getBestScore()) {
                user.setBestScore(gameState.getScore());
                gameContext.updateScore(user);
            }
            gameState.setGameOver(true);
            getServletContext().getRequestDispatcher("/WEB_INF/vues/back/home.jsp").forward(request, response);
            return;
        }

        int diceNumber = Integer.parseInt(request.getParameter("diceNumber"));

        if (gameState.getDiceRollsArray()[diceNumber - 1]) {
            session.setAttribute("score", -1);
            gameState.addMessage(new Message("Game Over. Vous avez lancé le dé numéro " + diceNumber + " plusieurs fois.", Message.INFO));
            gameState.setGameOver(true);
            getServletContext().getRequestDispatcher("/WEB_INF/vues/back/home.jsp").forward(request, response);
            return;
        }

        int diceResult = new Random().nextInt(6) + 1;

        gameState.setDiceRollsArrayElement(diceNumber - 1, true);
        gameState.addScore(diceResult);

        // Vérification des règles du jeu pour le dé 2
        if (gameState.getDiceRolls() == 3) {
            int[] rolls = gameState.getDiceRollsArray();
            int score = gameState.getScore();

            if (rolls[0] < rolls[1] && rolls[1] < rolls[2]) {
                session.setAttribute("score", score);
               
            } else {
                session.setAttribute("score", 0);
               
            }
            gameState.setGameOver(true);
            getServletContext().getRequestDispatcher("/WEB-INF/vues/back/home.jsp").forward(request, response);
            return;
        }

        // Vérification de la condition spéciale
        if (diceResult == 6 && diceNumber == 1) {
            session.setAttribute("score", 0);
           
            gameState.setGameOver(true);
            getServletContext().getRequestDispatcher("/WEB_INF/vues/back/home.jsp").forward(request, response);
            return;
        }

        getServletContext().getRequestDispatcher("/WEB_INF/vues/back/home.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        play(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        play(request, response);
    }
}
