package mainfolder.toolinterchangeapp;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;

import java.io.IOException;

public class HelloController {

    public Button sellers;

    public Button users;

    @FXML
    private Label welcomeText;

    @FXML
    protected void onHelloButtonClick() {
        welcomeText.setText("Welcome to JavaFX Application!");
    }

    public void goToSellers() throws IOException {
        HelloApplication.setRoot("user-view");
    }

    public void goToUsers() throws IOException {
        HelloApplication.setRoot("stock-view");
    }
}