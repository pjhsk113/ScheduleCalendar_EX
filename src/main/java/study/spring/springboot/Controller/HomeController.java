package study.spring.springboot.Controller;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import study.spring.springboot.Mapper.ScheduleMapper;
import study.spring.springboot.Model.Schedule;
import study.spring.springboot.helper.WebHelper;

@Controller
public class HomeController {
	@Autowired
	private ScheduleMapper mapper;
	
	@Autowired
	private WebHelper webHelper;
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String index(Model model) {
		
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_MONTH, 0);
		int year = calendar.get(Calendar.YEAR);
		int month= calendar.get(Calendar.MONTH) +1;
	
		calendar.set(Calendar.DAY_OF_MONTH, 1);
	    int first_day= calendar.get(Calendar.DAY_OF_WEEK);						// 해당월 1일의 요일
		int last_day = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);		// 해당월의 마지막 날짜
	    
	    
	    int week = calendar.getActualMaximum(Calendar.WEEK_OF_MONTH);			//이번 달은 몇주로 되어있는가
	    
	    calendar.add(calendar.MONTH, -1);
		int last_end = calendar.getActualMaximum(Calendar.DAY_OF_MONTH); 	// 이번달에 표시될 지난달의 마지막 날짜
	    int lsat_start = (last_end+1) - (first_day-1);						// 이번달에 표시될 지난달의 시작날짜 
	   
	    List<Schedule> output = null;
	    
	    try {
			output = mapper.ScheduleList();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    model.addAttribute("output", output);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("first_day", first_day);
		model.addAttribute("last_day", last_day);
		model.addAttribute("week", week);
		model.addAttribute("last_start", lsat_start);
		model.addAttribute("last_end", last_end);
		
		
		return "calendar";
	}
	
	@RequestMapping(value="/add_ok.do", method = RequestMethod.POST)
	public ModelAndView add(Model model,  HttpServletRequest request) {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String start_date = request.getParameter("start_date");
		String start_time = request.getParameter("start_time");
		String end_date = request.getParameter("end_date");
		String end_time = request.getParameter("end_time");
		String allday1 = request.getParameter("allday");
		
		String startday_only = start_date.substring(start_date.lastIndexOf("-")+1);
		String endday_only = end_date.substring(start_date.lastIndexOf("-")+1);
		int day = Integer.parseInt(startday_only);
		int endday= Integer.parseInt(endday_only);
		int sub_date = endday-day;
		
		int allday;
		if(allday1 == null) {
			allday1 = "0";
			allday = Integer.parseInt(allday1);
		}else {
			allday = Integer.parseInt(allday1);
			end_time = "23:59:59";
		}
		
		int repeats= 0;		// repeats --> 1:매월, 2:매주, 3:매일
		String repeat1 = request.getParameter("repeats");
		
		if(repeat1 == null) {
			repeat1 = "0";
			repeats = Integer.parseInt(repeat1);
			System.out.println(repeat1);
			
		}else if(repeat1.equals("3")) {
			repeats = Integer.parseInt(repeat1);
			sub_date = 0;
		}else {
			repeats = Integer.parseInt(repeat1);
		}
		
		 
		
		Schedule input = new Schedule();
		input.setTitle(title);
		input.setContent(content);
		input.setStart_date(start_date);
		input.setStart_time(start_time);
		input.setEnd_date(end_date);
		input.setEnd_time(end_time);
		input.setAllday(allday);
		input.setRepeats(repeats);
		input.setDay(day);
		input.setSub_date(sub_date);
		
		try {
			mapper.addItem(input);
		} catch (Exception e) {
			return webHelper.redirect("/","Fail");
		}
		
		return webHelper.redirect("/", "Success");
	}
	
	@RequestMapping(value="/daliy.do", method = RequestMethod.GET)
	public ModelAndView daliy(Model model, HttpServletRequest request) {
		String target1 = request.getParameter("target");
		int target = Integer.parseInt(target1);
		
		String[] day_name = {"일","월","화","수","목","금","토"};
		
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month= calendar.get(Calendar.MONTH) +1;
		
		calendar.set(Calendar.DAY_OF_MONTH,target);
		int wd = calendar.get(Calendar.DAY_OF_WEEK);
		String weekDay = day_name[wd-1];
		
		Schedule input = new Schedule();
		input.setDay(target);
		
		List<Schedule> output = null;
		
		try {
			output = mapper.DaliyList(input);
		} catch (Exception e) {
			return webHelper.redirect("/","Fail");
		}
		
		model.addAttribute("output",output);
		model.addAttribute("target",target);
		model.addAttribute("weekDay",weekDay);
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		return new ModelAndView("/daliy");
	}
	
	@RequestMapping(value="/delete_ok.do", method = RequestMethod.GET)
	public ModelAndView deleteItem(Model model, HttpServletRequest request) {
		String no = request.getParameter("no");
		int event_id = Integer.parseInt(no);
		
		Schedule input = new Schedule();
		input.setEvent_id(event_id);
		
		try {
			mapper.deleteSchedule(input);
		} catch (Exception e) {
			return webHelper.redirect("/","Delete Fail");
		}
		return webHelper.redirect("/", "Delete Ok");
	}
}
