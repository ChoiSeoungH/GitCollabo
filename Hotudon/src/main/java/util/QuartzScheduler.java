package util;

import java.util.Collection;

import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.SimpleScheduleBuilder;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

public class QuartzScheduler {
	
	 private static Scheduler scheduler;

	    public static void initScheduler() throws SchedulerException {
	        SchedulerFactory schedulerFactory = new StdSchedulerFactory();
	        scheduler = schedulerFactory.getScheduler();
	        scheduler.start();
	        scheduleJob();
	    }

	    private static void scheduleJob() throws SchedulerException {
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
	    }
	}