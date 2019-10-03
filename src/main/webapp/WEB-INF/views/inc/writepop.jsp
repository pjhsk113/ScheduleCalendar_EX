<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<div class="modal fade" id="registerSchedule" tabindex="-1"
	role="dialog" aria-labelledby="registerScheduleLabel"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="registerScheduleLabel">일정 만들기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" action="${pageContext.request.contextPath}/add_ok.do">
					<div class="form-group">
						<label class="col-form-label">일정 제목</label> 
						<input type="text" class="form-control" id="recipient-name" name="title">
						
						
					</div>
					<div class="form-group">
						<label for="message-text" class="col-form-label">일정 설명</label>
						<textarea class="form-control" id="message-text" name="content"></textarea>
					</div>
					<div class="form-row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="col-form-label">일정 시작 날짜</label>
								<div class="input-group date" id="datetimepicker1"
									data-target-input="nearest">
									<input type="text" class="form-control datetimepicker-input"
										data-target="#datetimepicker1" name="start_date"/>
									<div class="input-group-append" data-target="#datetimepicker1"
										data-toggle="datetimepicker">
										<div class="input-group-text">
											<i class="material-icons"> calendar_today </i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group" id="checking_allday1">
								<label class="col-form-label">일정 시작 시간</label>
								<div class="input-group date" id="datetimepicker2"
									data-target-input="nearest">
									<input type="text" class="form-control datetimepicker-input"
										data-target="#datetimepicker2" name="start_time"/>
									<div class="input-group-append" data-target="#datetimepicker2"
										data-toggle="datetimepicker">
										<div class="input-group-text">
											<i class="material-icons"> access_time </i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="col-form-label">일정 종료 날짜</label>
								<div class="input-group date" id="datetimepicker3"
									data-target-input="nearest">
									<input type="text" class="form-control datetimepicker-input"
										data-target="#datetimepicker3" name="end_date" />
									<div class="input-group-append" data-target="#datetimepicker3"
										data-toggle="datetimepicker">
										<div class="input-group-text">
											<i class="material-icons"> calendar_today </i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group" id="checking_allday2">
								<label class="col-form-label" >일정 종료 시간</label>
								<div class="input-group date" id="datetimepicker4"
									data-target-input="nearest">
									<input type="text" class="form-control datetimepicker-input"
										data-target="#datetimepicker4" name="end_time"/>
									<div class="input-group-append" data-target="#datetimepicker4"
										data-toggle="datetimepicker">
										<div class="input-group-text">
											<i class="material-icons"> access_time </i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								id="inlineCheckbox1" name="repeats" value="1"> <label
								class="form-check-label" for="inlineCheckbox1">매월 반복</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								id="inlineCheckbox2" name="repeats" value="2"> <label
								class="form-check-label" for="inlineCheckbox2">매주 반복</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								id="inlineCheckbox3" name="repeats" value="3"> <label
								class="form-check-label" for="inlineCheckbox3">매일 반복</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox"
								id="inlineCheckbox4" name="allday" value="1"> <label
								class="form-check-label" for="inlineCheckbox4">하루 종일</label>
						</div>
					</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary">일정 만들기</button>
			</div>
			</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$('#inlineCheckbox4').click(function() {
    if( $(this).is(':checked')) {
        $("#checking_allday1").hide();
        $("#checking_allday2").hide();
    } else {
        $("#checking_allday1").show();
        $("#checking_allday2").show();
    }
}); 
</script>