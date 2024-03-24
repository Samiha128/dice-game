package helpers;

import java.util.List;

import java.util.ArrayList;


import bo.User;

import jakarta.servlet.ServletContext;

public class contextemanagement  {
	private ServletContext conext;

	private static contextemanagement instance;

	private contextemanagement(ServletContext conext) {
		this.conext = conext;
	}

	synchronized public static final contextemanagement getInstance(ServletContext conext) {
		if (instance == null) {
			instance = new contextemanagement(conext);
		}
		return instance;
	}
	public List<User> getAllUsers() {
		return (List<User>) conext.getAttribute("users");

	}
	public void updateScore(User user) {
		List<User> users = getAllUsers();
		for (User it : users) {
			if (it.getemail().equals(user.getemail())) {
				it.setBestScore(user.getBestScore());
				break;
			}
		}

	}
	public void insertUser(User user) {
	    List<User> userList = getAllUsers();
	    if (userList == null) {
	        userList = new ArrayList<>(); // Initialiser la liste si elle est nulle
	        conext.setAttribute("users", userList); // Mettre à jour l'attribut dans le contexte
	    }

	    userList.add(user);
	}
	public User getUserByemail(String email) {
	    List<User> users = getAllUsers();
	    if (users != null) {
	        for (User it : users) {
	            System.out.println(it);
	            if (it.getemail().equals(email)) {
	                return it;
	            }
	        }
	    } else {
	        System.out.println("La liste des utilisateurs est vide ou null.");
	    }
	    return null;
	}

	
}
	


