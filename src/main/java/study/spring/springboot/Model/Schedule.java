package study.spring.springboot.Model;

import lombok.Data;

@Data
public class Schedule {
	private int event_id;
	private String title;
	private String content;
	private String start_date;
	private String start_time;
	private String end_date;
	private String end_time;	
	private int allday;
	private int repeats;
	private int day;
	private int sub_date;
}
