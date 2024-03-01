package frontcontroller;

import controller.Controller;
import model.Connector;

import java.util.HashMap;

public class HandlerMapping {
    private final HashMap<String, Controller> mappings;

    public HandlerMapping() {
        mappings = new HashMap<String, Controller>();

        // user

        // product

        // category

        // auction

        // delivery

        // chat

        // chatroom

        // alarm
    }

    public Controller getController(String key) { return mappings.get(key); }
}
