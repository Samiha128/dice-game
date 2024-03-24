package bo;

public class User {
	

	private String name;

	private String email;

	private String password;

	private double score;

	private double bestScore;

	private int compteurLancer;

	public User() {
	}

	public User( String name, String email, String password, double score, double bestScore,
			int compteurLancer) {
		
		this.name = name;
		this.email = email;
		this.password = password;
		this.score = score;
		this.bestScore = bestScore;
		this.compteurLancer = compteurLancer;
	}
	public User( String name, String email, String password) {
		
		this.name = name;
		this.email = email;
		this.password = password ;
	}
	

	@Override
	public String toString() {
		return "Utilisateur [prenom=" + name + ", email="
				+ email + ", password=" + password + ", score=" + score + ", bestScore=" + bestScore
				+ ", compteurLancer=" + compteurLancer + "]";
	}

	public User(String prenom, String email, String password, double score, double bestScore) {
		
		this.name = prenom;
		this.email = email;
		this.password = password;
		this.score = score;
		this.bestScore = bestScore;
	}

	public String getPrenom() {
		return name;
	}

	public void setPrenom(String prenom) {
		this.name = prenom;
	}

	public String getemail() {
		return email;
	}

	public void setemail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {

		this.score = score;
	}

	public double getBestScore() {
		return bestScore;
	}

	public void setBestScore(double bestScore) {
		this.bestScore = bestScore;
	}

	public int getCompteurLancer() {
		return compteurLancer;
	}

	public void setCompteurLancer(int compteurLancer) {
		this.compteurLancer = compteurLancer;
	}

	public void incrementLance() {
		this.compteurLancer++;
	}
	
	
	

}
