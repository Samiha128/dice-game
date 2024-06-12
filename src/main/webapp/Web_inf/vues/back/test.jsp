<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Lancer le dé</title>
<link rel="stylesheet" href="styles.css">
</head>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
}

.container {
    max-width: 400px;
    margin: 50px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

label {
    font-size: 18px;
    font-weight: bold;
}

input[type="text"] {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    margin-bottom: 20px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

button {
    padding: 10px 20px;
    font-size: 16px;
    background-color: #4CAF50;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

button:hover {
    background-color: #45a049;
}

</style>
<body>

<div class="container">
    <label for="diceNumber" style="display: inline-block;">Lancer le numéro de dé :</label>
    <input type="text" id="diceNumber" name="diceNumber" placeholder="Entrez un numéro..." style="display: inline-block;">
    <button id="rollDice" onclick="sendDiceNumber()" style="display: inline-block; margin-right: 10px;">Lancer le dé</button>
    <form id="newGameForm" action="${pageContext.request.contextPath}/GameServlet" method="post" style="display: inline-block;">
        <!-- Champ caché pour le bouton "Nouvelle partie" -->
        <input type="hidden" name="newGameButton" value="newGame">
        <button type="submit" style="margin-right: 10px;">Nouvelle partie</button>
    </form>
    <form id="rollDiceForm" action="${pageContext.request.contextPath}/GameServlet" method="post" style="display: none;">
        <!-- Champ caché pour le numéro du dé -->
        <input type="hidden" id="diceNumberHidden" name="diceNumber" value="">
    </form>

    <br><br> <!-- Deux sauts de ligne -->

    <form id="returnHomeForm" action="${pageContext.request.contextPath}/Web_inf/vues/back/home.jsp" method="get" style="display: inline-block; margin-left: 20px;">
        <!-- Champ caché pour indiquer le retour à la page d'accueil -->
        <input type="hidden" name="returnHome" value="true">
        <button type="submit">Revenir à la page d'accueil</button>
    </form>
</div>




<script>
function submitNewGameForm() {
    // Soumettre le formulaire "Nouvelle partie"
    document.getElementById("newGameForm").submit();
}

function sendDiceNumber() {
    // Récupérer la valeur saisie dans le champ input
    var diceNumber = document.getElementById("diceNumber").value;
    
    // Mettre à jour la valeur du champ caché dans le formulaire de lancer de dé
    document.getElementById("diceNumberHidden").value = diceNumber;
    
    // Soumettre le formulaire de lancer de dé
    document.getElementById("rollDiceForm").submit();
}
</script>


</body>
</html>
    