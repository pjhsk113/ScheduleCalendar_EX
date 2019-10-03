<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- favicon -->
<%@ include file="/WEB-INF/views/inc/script.jsp"%>
<!-- Stylesheets -->
<%@ include file="/WEB-INF/views/inc/style.jsp"%>


</head>
<body>
	<div class="calendar-container">
		<div class="calendar-header">
			
			<button class="btn btn-light">Today</button>
			<div class="ico-arrow">
				<a href="${pageContext.request.contextPath}/" data-toggle="tooltip" data-placement="top" title="이전">
					<i class="material-icons"> chevron_left </i>
				</a> <a href="${pageContext.request.contextPath}/" data-toggle="tooltip" data-placement="top" title="다음" >
					<i class="material-icons"> chevron_right </i>
				</a>
			</div>
			<h4>${year}년 ${month}월</h4>
			<ul class="nav nav-tabs view-tab" id="view" role="tablist">
				<jsp:useBean id="toDay" class="java.util.Date" />
				<fmt:formatDate value="${toDay}" pattern="dd" var="toDay" />
				<fmt:parseNumber var="D" type="number" value="${toDay}" />
				<li class="nav-item"><a class="nav-link active" id="tab-month"
					data-toggle="tab" href="${pageContext.request.contextPath}/" role="tab" aria-controls="month"
					aria-selected="true">월</a></li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/daliy.do?target=${D}" class="nav-link" id="tab-day"
					role="tab" aria-controls="day" >일</a></li>
			</ul>
		</div>
		<div class="tab-content">
			<div class="tab-pane active show" id="month" role="tabpanel"
				aria-labelledby="tab-month">
				<div class="monthly-calendar">
					<div class="week-day">
						<div class="day-name">일</div>
						<div class="day-name">월</div>
						<div class="day-name">화</div>
						<div class="day-name">수</div>
						<div class="day-name">목</div>
						<div class="day-name">금</div>
						<div class="day-name">토</div>
					</div>

					<c:set var="date" value="1" />
					<c:set var="loop_flag" value="false" />
					<c:set var="temp" value="6" />
					
					<c:forEach var="i" begin="1" end="${week}" step="1" varStatus="status">
						<div class="week">
						<c:if test="${first_day!=1 && i==1}">
							<c:forEach var="x" begin="${last_start}" end="${last_end}" step="1" varStatus="status">
								<div class="day">
									<h3 class="day-label">${x}</h3>
									<c:forEach items="${output}" var="item">
									<c:choose>
										<c:when test="${(item.day == x) && ((fn:substring(item.end_date,5,7))== month-1)}">
										<div class="event-consecutive event-start event-end" data-span="${item.sub_date+1}" data-toggle="popover" data-html="true" data-content='<div class="content-line">
											<div class="event-consecutive-marking"></div>
											<div class="title"> <h5>${item.title}</h5> <h7 class="reservation">${item.start_date} ~ ${item.end_date} </div>
        								</div>
        								<div class="content-line"><i class="material-icons">notes</i>
        								<div class="title"><h7 class="reservation">${item.content}</div>'>${item.title}</div>
        								</c:when>
        								<c:otherwise>
											
        								</c:otherwise>
        							</c:choose>
									</c:forEach>			
								</div>
								
								<c:set var="cnt" value="${cnt+1}" />
							</c:forEach>
							<c:set var="temp" value="${temp-cnt}" />
						</c:if>
						
							<c:choose>
								<c:when test="${i==1}">
									<c:set var="sum" value="${date+temp}" />
								</c:when>
								
								<c:otherwise>
									<c:set var="sum" value="${date+6}" />
								</c:otherwise>
							</c:choose>
							
							<c:forEach var="j" begin="${date}" end="${sum}" step="1" varStatus="status">
								<c:set var="date" value="${date+1}" />
								
								<c:if test="${not loop_flag }">
									<div class="day">
										<h3 class="day-label"><a href="${pageContext.request.contextPath}/daliy.do?target=${j}"><div>${j}</div></a></h3>
										<c:forEach items="${output}" var="item">
										<c:if test="${item.repeats==3}">
        									<div class="event-repeated event-start event-end" data-span="${item.sub_date+1}" data-toggle="popover" data-html="true" data-content='<div class="content-line">
												<div class="event-repeated-marking"></div>
												<div class="title"><h5>${item.title}</h5><h7 class="reservation">${item.start_date} ~ ${item.end_date}<br/><span class="reservation-time">${item.start_time} ~ ${item.end_time}</span></h7>
													<span class="repeat-message">매일 반복</span></div>
        										</div>
        									<div class="content-line"><i class="material-icons">notes</i>
											<div class="title"><h7 class="reservation">${item.content}</div><div style="padding-left:50px;"><a href="${pageContext.request.contextPath}/delete_ok.do?no=${item.event_id}">삭제하기</a></div>'>${item.title}</div>
										</c:if>
										
										<c:choose>					      								
        								<c:when test="${(item.day == j && item.sub_date == 0) && (item.repeats == 0 && (fn:substring(item.start_date,5,7)) == month)}">
        								
        								<div class="event event-start event-end" data-span="${item.sub_date+1}" data-toggle="popover" data-html="true" data-content='<div class="content-line">
											<div class="event-marking"></div>
											<div class="title"><h5>${item.title}</h5><h7 class="reservation"><span class="reservation-time">${item.start_date} ~ ${item.end_date}<br/>${item.start_time} ~ ${item.end_time}</span></h7></div>
       									</div>
       									<div class="content-line"><i class="material-icons">notes</i>
       									<div class="title"><h7 class="reservation">${item.content}</div><div style="padding-left:50px;"><a href="${pageContext.request.contextPath}/delete_ok.do?no=${item.event_id}">삭제하기</a></div>'>${item.title}</div>
       									
        								</c:when>
        								
        								<c:when test="${(item.day == j && item.sub_date > 0) && (item.repeats == 0 && (fn:substring(item.start_date,5,7)) == month)}">
										<div class="event-consecutive event-start event-end" data-span="${item.sub_date+1}" data-toggle="popover" data-html="true" data-content='<div class="content-line">
											<div class="event-consecutive-marking"></div>
											<div class="title"> <h5>${item.title}</h5> <h7 class="reservation">${item.start_date} ~ ${item.end_date}</h7></div>
        								</div>
        								<div class="content-line"><i class="material-icons">notes</i>
        								<div class="title"><h7 class="reservation">${item.content}<div style="padding-left:50px;"><a href="${pageContext.request.contextPath}/delete_ok.do?no=${item.event_id}">삭제하기</a></div></div>'>${item.title}</div>
        								</c:when>
        								<c:when test="${item.day == j && item.repeats != 0}">
        									<c:if test="${item.repeats==1}">
        									<div class="event-repeated event-start event-end" data-span="${item.sub_date+1}" data-toggle="popover" data-html="true" data-content='<div class="content-line">
												<div class="event-repeated-marking"></div>
												<div class="title"><h5>${item.title}</h5><h7 class="reservation">${item.start_date} ~ ${item.end_date}<br/><span class="reservation-time">${item.start_time} ~ ${item.end_time}</span></h7>
													<span class="repeat-message">매월 반복</span></div>
        										</div>
        									<div class="content-line"><i class="material-icons">notes</i>
											<div class="title"><h7 class="reservation">${item.content}</div><div style="padding-left:50px;"><a href="${pageContext.request.contextPath}/delete_ok.do?no=${item.event_id}">삭제하기</a></div>'>${item.title}</div>
											</c:if>
											<c:if test="${item.repeats==2}">
        									<div class="event-repeated event-start event-end" data-span="${item.sub_date+1}" data-toggle="popover" data-html="true" data-content='<div class="content-line">
												<div class="event-repeated-marking"></div>
												<div class="title"><h5>${item.title}</h5><h7 class="reservation">${item.start_date} ~ ${item.end_date}<br/><span class="reservation-time">${item.start_time} ~ ${item.end_time}</span></h7>
													<span class="repeat-message">매주 반복</span></div>
        										</div>
        									<div class="content-line"><i class="material-icons">notes</i>
											<div class="title"><h7 class="reservation">${item.content}</div><div style="padding-left:50px;"><a href="${pageContext.request.contextPath}/delete_ok.do?no=${item.event_id}">삭제하기</a></div>'>${item.title}</div>
											</c:if>
											
        								</c:when>
        								</c:choose>
										</c:forEach>
									</div>
									
									<c:if test="${last_day==j}">
										<c:set var="loop_flag" value="true" />
										<c:forEach var="k" begin="1" end="${sum-last_day}" step="1" varStatus="status">
											<div class="day">
												<h3 class="day-label">${k}</h3>
												<c:forEach items="${output}" var="item">
												<c:choose>
													<c:when test="${(item.day == k) && ((fn:substring(item.start_date,5,7))== month+1)}">
														<div class="event-consecutive event-start event-end" data-span="${item.sub_date+1}" data-toggle="popover" data-html="true" data-content='<div class="content-line">
															<div class="event-consecutive-marking"></div>
															<div class="title"> <h5>${item.title}</h5> <h7 class="reservation">${item.start_date} ~ ${item.end_date} </div>
        												</div>
        												<div class="content-line"><i class="material-icons">notes</i>
        													<div class="title"><h7 class="reservation">${item.content}</div>'>${item.title}</div>
        											</c:when>
        											<c:otherwise>
											
        											</c:otherwise>
        										</c:choose>
												</c:forEach>			
											</div>
										</c:forEach>	
									</c:if>
								</c:if>
							</c:forEach>
						</div>
					</c:forEach>
</body>

<%@ include file="/WEB-INF/views/inc/writepop.jsp"%>
<script type="text/javascript" src="/js/main.js"></script>
</html>