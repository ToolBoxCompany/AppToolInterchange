package mainfolder.toolinterchangeapp;

import javafx.fxml.FXML;
import javafx.scene.control.Label;

import java.io.IOException;

public class StockController {

    @FXML
    private Label welcomeText;

    @FXML
    protected void onHelloButtonClick() {
        welcomeText.setText("Welcome to JavaFX Application!");
    }

    public void goMenu() throws IOException {
        HelloApplication.setRoot("hello-view");
    }

}
