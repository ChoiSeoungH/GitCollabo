package util;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.time.Instant;

import org.apache.ibatis.session.SqlSession;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import vo.Auction;
import vo.Product;
public class UpdateEndDateJob implements Job {

    @Override
    public void execute(JobExecutionContext ctx) throws JobExecutionException {
        SqlSession session = MybatisConfig.getInstance().openSession();
        List<Auction> list = session.selectList("mapper.product.selectAllAuction");
        
        // 현재 시간 계산
        Date currentDate = new Date();

        try {
            for (Auction auction : list) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date lastBidDate = dateFormat.parse(auction.getLastBidDate());
                Calendar calendar = Calendar.getInstance();
                Date fo = calendar.getTime();

                // reg_date가 9:00일 경우, 12:00 이후인지 확인
                calendar.setTime(lastBidDate);

                if (auction.getLastBidderNo() == 0) {
                    calendar.add(Calendar.HOUR_OF_DAY, 24);
                } else {
                    calendar.add(Calendar.HOUR_OF_DAY, 3);
                }
                Date threeHoursAgoDate = calendar.getTime();

                if (currentDate.after(calendar.getTime())) {
                    // 현재 시간으로 end_date 업데이트
                    String endDate = dateFormat.format(threeHoursAgoDate);
                    Product vo = new Product(auction.getProductNo(), endDate);
                    List<Product> productList = session.selectList("mapper.product.autoAuctionEnd", vo);
                }
            }
            // MyBatis에서는 자동으로 commit이 이루어지지 않기 때문에 수동으로 commit
            session.commit();
        } catch (ParseException e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}