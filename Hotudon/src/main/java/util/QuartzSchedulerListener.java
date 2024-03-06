package util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

public class QuartzSchedulerListener implements ServletContextListener{
	
	 @Override
	    public void contextInitialized(ServletContextEvent sce) {
	        try {
	            QuartzScheduler.initScheduler();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    @Override
	    public void contextDestroyed(ServletContextEvent sce) {
	        // 애플리케이션이 종료될 때 필요한 작업 수행
	    }
	}


