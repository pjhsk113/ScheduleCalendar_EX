package study.spring.springboot.Mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import study.spring.springboot.Model.Schedule;

@Mapper
public interface ScheduleMapper {
	public List<Schedule> ScheduleList() throws Exception;
	
	public List<Schedule> DaliyList(Schedule input) throws Exception;
	
	public int deleteSchedule(Schedule input)throws Exception;
	
	public int addItem(Schedule input) throws Exception;
}
