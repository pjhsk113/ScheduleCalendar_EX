    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    });

    $(function () {
        $('#view li:first-child a').tab('show')
    });

    $(function () {
        $('[data-toggle="popover"]').popover().on('inserted.bs.popover')
    });

    $('.week, .daily-calendar').click(function() {
        $('#registerSchedule').modal('show');
    });

    $(".event-consecutive, .event, .event-repeated").click(function(event) {
        event.stopPropagation();
    });

    $(function () {
        $('#datetimepicker1').datetimepicker({
            format: 'YYYY-MM-DD',
            onClose: function( selectedDate ) {   
            	$("#datetimepicker3").datetimepicker( "option", "minDate", selectedDate );
                } 
        });
        $('#datetimepicker3').datetimepicker({
            format: 'YYYY-MM-DD',
            onClose: function( selectedDate ) {
                $("#datetimepicker1").datetimepicker( "option", "maxDate", selectedDate );
            }
        });
    });

    $(function () {
        $('#datetimepicker2').datetimepicker({
            format: 'HH:mm'
        });
        $('#datetimepicker4').datetimepicker({
            format: 'HH:mm'
        });
    });
