library(xlsx)
library(googleVis)
library(dplyr)
library(digest)
library(networkD3)
library(plyr)
library(rCharts)
library(rjson)
library(devtools)

setwd("X:/Trans/STAFF/Reid/Project Tracking/phase_analysis")

phase<-read.xlsx("PhaseAnalysisForAllAwardsSince2012.xlsx", sheetName="tidy_data")
phase$summary<-phase$Award.Type
phase$summary<-gsub(".*Construction.*","Includes Construction",phase$Award.Type)
phase_select<-phase %>% select( process2,summary, Amount)
colnames(phase_select) <- c("source", "target", "value")

sankeyPlot <- rCharts$new()
sankeyPlot$set(data = phase_select, nodeWidth = 30, nodePadding = 30,layout = 32,width = 700,height = 600,units = "$",title = "Phases and Funding")
sankeyPlot$setLib('X:/Trans/STAFF/Reid/Project Tracking/phase_analysis/rCharts_d3_sankey-gh-pages/rCharts_d3_sankey-gh-pages/libraries/widgets/d3_sankey')

sankeyPlot$setTemplate(
  afterScript = "
  <script>
  d3.selectAll('#{{ chartId }} svg text')
  .style('font-size', '16')
  </script>
  ")

sankeyPlot$save('mysankey.html')
