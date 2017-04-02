#!/usr/bin/Rscript 

library('RSQLite')

connection <- dbConnect(drv='SQLite', dbname='weather.sqlite')
alltables <- dbListTables(connection)

dwd_rdm_data <- dbGetQuery(connection, 'SELECT dwdweatherdata.timestamp AS timestamp, dwdweatherdata.temperature AS dwdtmp, dwdweatherdata.humidity AS dwdhum, dwdweatherdata.pressure as dwdpres, rdmweatherdata.temperature AS rdmtmp, rdmweatherdata.humidity AS rdmhum, rdmweatherdata.pressure as rdmpres FROM dwdweatherdata INNER JOIN rdmweatherdata ON dwdweatherdata.timestamp = rdmweatherdata.timestamp')

x11()
plot(dwd_rdm_data$dwdtmp, dwd_rdm_data$rdmtmp, xlab='Temperature measured by DWD', ylab='Temperature measured by RDM private weather station')
abline(lm(dwd_rdm_data$dwdtmp ~ dwd_rdm_data$rdmtmp), col='red')
abline(0, 1, col='green')

while (!is.null(dev.list())) Sys.sleep(1)
