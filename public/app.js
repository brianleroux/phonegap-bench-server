google.load("visualization", "1", {packages:["corechart"]});
x$.ready(function() { 

    google.setOnLoadCallback(function() {
        // load the data
        x$(window).xhr('/reports.json', function(e) {
            var reports = JSON.parse(this.responseText)
            // iterate the reports drawing a bar chart for each
            reports.forEach(function(report, reportIndex) {
                // create an element for the report
                x$('#chart_div').after('<div id=report-'+ reportIndex +'></div>')
                // setup the chart junk
                var data = new google.visualization.DataTable()
                ,   chart = new google.visualization.BarChart(x$('#report-'+ reportIndex)[0])
                ,   config = {title:report.title, height:200}

                data.addColumn('string', 'reports')
                data.addColumn('number', 'ms')
                data.addRows(report.length)

                report.forEach(function(row, rowIndex) {
                    data.setValue(rowIndex, 0, row.name)
                    data.setValue(rowIndex, 1, row.ms)
                })
                // yay draw the chart!
                chart.draw(data, config)
            })
        })
    })
})
