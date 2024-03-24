package bo;

import java.util.ArrayList;
import java.util.List;


public class GameState {
	private User user;

	private boolean gameOver = false;

	

	public void reinit() {
		gameOver = false;
		
		user.setScore(0);
		user.setCompteurLancer(0);

	}

	public String toString() {
		return "GameState [Score=" + user.getScore() + ", nombre lancers=" + user.getCompteurLancer() ;
	}

	

	public GameState(User user) {
		this.user = user;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public boolean isGameOver() {
		return gameOver;
	}

	public void setGameOver(boolean gameOver) {
		this.gameOver = gameOver;
	}

	

	
}

