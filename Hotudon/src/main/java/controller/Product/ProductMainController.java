package controller.Product;

import java.io.IOException;

import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.SimpleScheduleBuilder;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.UpdateEndDateJob;

public class ProductMainController implements Controller{

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String saveDirectory = request.getServletContext().getRealPath("/img");
		System.out.println(saveDirectory);
		try {
			SchedulerFactory schedulerFactory = new StdSchedulerFactory();
			Scheduler scheduler = schedulerFactory.getScheduler();
			scheduler.start();

			JobDetail jobDetail = JobBuilder.newJob(UpdateEndDateJob.class)
					.withIdentity("updateEndDateJob", "group1")
					.build();
			Trigger trigger = TriggerBuilder.newTrigger()
					.withIdentity("updateEndDateTrigger", "group1")
					.startNow()
					.withSchedule(SimpleScheduleBuilder.simpleSchedule()
							.withIntervalInSeconds(20)
							.repeatForever())
					.build();

			scheduler.scheduleJob(jobDetail, trigger);
			System.out.println("트레거온");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("체크");
		}



		return "productMain";
	}

}