package frontcontorller;



import controller.map.InsertAddressController;
import controller.map.MapController;
import controller.map.QuickMainController;

import java.util.HashMap;

public class HandlerMapping {
	private HashMap<String, Controller> mappings;

	public HandlerMapping() {
		mappings = new HashMap<String, Controller>();
		//quick
		mappings.put("/quickMain.do", new QuickMainController());

		//map
		mappings.put("/map.do", new MapController());
		mappings.put("/insertAddress.do", new InsertAddressController());
	}

	public Controller getController(String key) {
		return mappings.get(key);
	}
}
