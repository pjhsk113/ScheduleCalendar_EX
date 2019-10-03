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
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" pattern="yyyy년 MM월" var="toDay1" />
<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" var="toDay2" />
<fmt:formatDate value="${toDay}" pattern="dd" var="toDay" />

<fmt:parseNumber var="D" type="number" value="${toDay}" />
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
				
				<li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-link active" id="tab-month"
					 role="tab" aria-controls="month" aria-selected="true">월</a></li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/daliy.do?target=${D}" class="nav-link" id="tab-day"
					role="tab" aria-controls="day" >일</a></li>
			</ul>
		</div>
		
		<div class="tab-content">
			<div class="tab-pane active show" id="month" role="tabpanel" aria-labelledby="tab-month">
				<div class="monthly-calendar">
					<div class="tab-pane" id="day" role="tabpanel" aria-labelledby="tab-day">
					<div class="daily-calendar">
						<span class="day-name">${target}일 ${weekDay}요일</span>
							<c:forEach var="item" items="${output}">
							<c:choose>					      								
        						<c:when test="${(item.sub_date > 0) && (item.repeats == 0 && (fn:substring(item.start_date,5,7) == month))}">
									<div class="event-consecutive event-start event-end" data-toggle="popover" data-html="true" data-placement="left" data-content='<div class="content-line">
										<div class="event-consecutive-marking"></div>
										<div class="title">
											<h5>${item.title}</h5>
											<h7 class="reservation">${item.start_date} ~ ${item.end_date}</h7>
										</div>
									</div>
										<div class="content-line">
											<i class="material-icons">notes</i>
        								<div class="title"><h7 class="reservation">${item.content}</div>'>${item.title}</div>
        						</c:when>
        						
        						<c:when test="${(item.sub_date == 0) && (item.repeats == 0 && (fn:substring(item.start_date,5,7) == month))}">
									<div class="event event-start event-end" data-toggle="popover" data-html="true" data-placement="left" data-content='<div class="content-line">
										<div class="event-marking"></div>
										<div class="title">
											<h5>${item.title}</h5>
											<h7 class="reservation">${item.start_date} ~ ${item.end_date}</h7>
											<h7 class="reservation">${item.start_date} ~ ${item.end_date}<span class="reservation-time">${item.start_time} ~ ${item.end_time}</span></h7>
										</div>
									</div>
										<div class="content-line">
											<i class="material-icons">notes</i>
        								<div class="title"><h7 class="reservation">${item.content}</div>'>${item.title}</div>
        						</c:when>
        						
        						<c:when test="${(item.sub_date >= 0) && (item.repeats != 0 && (fn:substring(item.start_date,5,7)== month))}">
									<div class="event-repeated event-start event-end" data-toggle="popover" data-html="true" data-placement="left" data-content='<div class="content-line">
										<div class="event-repeated-marking"></div>
										<div class="title">
											<h5>${item.title}</h5>
											<h7 class="reservation">${item.start_date} ~ ${item.end_date}</h7>
											<h7 class="reservation">${item.start_date} ~ ${item.end_date}<span class="reservation-time">${item.start_time} ~ ${item.end_time}</span><span class="repeat-message">⋅매월 반복</span></h7>
										</div>
									</div>
										<div class="content-line">
											<i class="material-icons">notes</i>
        								<div class="title"><h7 class="reservation">${item.content}</div>'>${item.title}</div>
        						</c:when>
        					</c:choose>
        					</c:forEach>
					</div>
					</div>
				</div>
			</div>
		</div>
</body>
<%@ include file="/WEB-INF/views/inc/writepop.jsp"%>
<script type="text/javascript" src="/js/main.js"></script>
</html>