#!/usr/bin/env Rscript
library(sqldf)
library(plyr)
library(ggplot2)
library(reshape2)

grey <- '#333333'

if (!('ip' %in% ls())) {
  ip <- sqldf('SELECT * FROM "finalip";', dbname = '/tmp/finalip.db')
}

n.decisions <- ddply(ip, 'District', function(df) {c(Decisions=nrow(df))})
n.decisions <- n.decisions[order(n.decisions$Decisions, decreasing = T),]

png('finalip.png', width = 1600, height = 900, res = 150)
par(las = 2, mar = c(6, 4, 4, 0),
    col = grey, fg = grey, col.main = grey,
    col.axis = grey, col.lab = grey)
barplot(
    n.decisions$Decisions, names.arg = n.decisions$District,
    main = 'ORM Final Individual Permit Decisions by District',
    xlab = '',
    ylab = 'Count since 2009',
    border = NA,
    col = ifelse(n.decisions$District == 'New Orleans', 'red', grey)
)
par(las = 0)
mtext('Nota bene: This dataset is not complete.', side = 3, padj = 1)
dev.off()
