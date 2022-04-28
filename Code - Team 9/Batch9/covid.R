#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(shinythemes)
library(shinyjs)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(lubridate)
library(plotly)
library(reshape2)
library(scales)
library(sqldf)
library(stringr)
library(readr)
library(shinyRGL)
library(hrbrthemes)
library(stringr)
library(reader)
library(DT)
library(shinycssloaders)


setwd("./data")
covid = read.csv("COVID19.csv")
names(covid)[1] = "Date_reported"
#View(covid)

covid_tm = read.csv('time_covid19.csv', header = T)
country_list = unique(covid$Country)
#View(covid_tm) 
covid_tm = covid_tm %>% rename(Country = Country.Region)

country_tm_df = as.data.frame(unique(covid_tm$Country))
#View(country_tm_df)
names(country_tm_df)[1] = 'Country'

country_df = as.data.frame(unique(covid$Country))
#View(country_df)
names(country_df)[1] = 'Country'


covid_tm2 = covid_tm %>% select(Country , Lat, Long)
#covid = inner_join(covid, covid_tm2, by = 'Country')

#View(covid)

#View(covid_tm)
#covid_tm = covid_tm %>% rename( Country = Country.Region )

covid$Date_reported_lt  = strptime(covid$Date_reported, "%Y-%m-%d")
covid$Date_reported_ct = as.POSIXct(covid$Date_reported_lt)





# # Define UI for application that draws a histogram
# tab_landing_page = tabPanel(title = "Home", 
#                             
#                             # parent container
#                             #tags$div(class="landing-wrapper",
#                                      
#                                      # child element 1: images
#                                      #tags$div(class="landing-block background-content",
#                                               
#                                               # top left
#                                               
#                                               #img(src=top_left),
#                                               includeHTML("Index.html")
#                                               # img(src='bear.jpg',
#                                               #     #src='Capture_034_05072021_164249.jpg', 
#                                               #     #align = 'middle',
#                                               #     height="50%", width="50%",
#                                               #     style="vertical-align:bottom")
#                                               
#                                               
#                                       #) 
#                                      # 
#                                      # # child element 2: content
#                                      # tags$div(class="landing-block foreground-content",
#                                      #          tags$div(class="foreground-text",
#                                      #                   tags$p("  ")
#                                      #          )
#                                      # )
#                             #)
# )
# 

tab_landing_page = tabPanel(title = "Home", div(id="landing", 
                           
                            fluidPage(
                                fluidRow(box(htmlOutput("inc"), width =12))
                                     )
                             
                                    )
                            )











tab_one_country = tabPanel(title = "Country",
                           
                           dashboardPage(skin='red',
                                         
                                         dashboardHeader(title='COVID Analytics', titleWidth = 1200),
                                         
                                         dashboardSidebar(
                                           sidebarMenu( 
                                             menuItem(text='One Country', 
                                                      icon=icon('tachometer-alt'),
                                                      tabName = 'dashboard_acnt')
                                           ) 
                                         ),
                                         
                                         dashboardBody(
                                           
                                           tags$head(tags$style(HTML('.info-box {min-height: 45px;} 
                            .info-box-icon {height: 45px; 
                            line-height: 45px;} 
                            .info-box-content {padding-top: 0px; padding-bottom: 0px;}
                            .skin-red .main-sidebar {background-color:  #006699 !important;}
                            #contents{color: green;
                                 font-size: 20px;
                                 font-style: italic;
                                 }
                            '))),
                                           tabItems(
                                             
                                             tabItem(tabName = 'dashboard_acnt',
                                                     
                                                     fluidRow(column(width = 3,
                                                                     selectInput(inputId = 'country1_db1', 
                                                                                 label   = 'Please select country :', 
                                                                                 choices = country_list,
                                                                                 selected= 'India' )
                                                     )
                                                     ),
                                                     fluidRow(
                                                       column(width = 12,
                                                              plotlyOutput(outputId = 'plot1_db1')
                                                              
                                                       )
                                                       
                                                       
                                                     ), 
                                                     fluidRow(
                                                       column(width = 12,
                                                              plotlyOutput(outputId = 'plot2_db1')
                                                              
                                                       )
                                                       
                                                     )
                                                     
                                             )) 
                                           
                                         )
                                         
                                         
                                         
                           )              
                           
)



tab_two_country = tabPanel(title = "Compare",
                           
                           dashboardPage(skin='red',
                                         
                                         dashboardHeader(title='COVID Analytics - Comprae Countries', titleWidth = 1200),
                                         
                                         dashboardSidebar(
                                           sidebarMenu( 
                                             menuItem(text='Compare', 
                                                      icon=icon('tachometer-alt'),
                                                      tabName = 'dashboard_comp') 
                                           ) 
                                         ),
                                         
                                         dashboardBody(
                                           
                                           tags$head(tags$style(HTML('.info-box {min-height: 45px;} 
                            .info-box-icon {height: 45px; 
                            line-height: 45px;} 
                            .info-box-content {padding-top: 0px; padding-bottom: 0px;}
                            .skin-red .main-sidebar {background-color:  #006699 !important;}
                            #contents{color: green;
                                 font-size: 20px;
                                 font-style: italic;
                                 }
                            '))),
                                           tabItems(
                                             
                                             tabItem(tabName = 'dashboard_comp',
                                                     
                                                     fluidRow(
                                                       column(width = 3,
                                                              selectInput(inputId = 'country1_db2', 
                                                                          label   = 'Please select country-1 :', 
                                                                          choices = country_list,
                                                                          selected=  country_list[1])
                                                       ),
                                                       column(width = 3,
                                                              selectInput(inputId = 'country2_db2', 
                                                                          label   = 'Please select country-2 :', 
                                                                          choices = country_list,
                                                                          selected=  country_list[2])
                                                       )
                                                     ),
                                                     fluidRow(
                                                       column(width = 12,
                                                              plotlyOutput(outputId = 'plot1_db2')
                                                              
                                                       )
                                                       
                                                     ),
                                                     fluidRow(
                                                       column(width = 12,
                                                              plotlyOutput(outputId = 'plot2_db2')
                                                              
                                                       )
                                                       
                                                     )
                                                     
                                                     
                                             )) 
                                           
                                         )
                                         
                                         
                                         
                           )              
                           
)


ui = tagList(
  
  #'////////////////////////////////////////
  # head + css
  tags$head(
    tags$link(href="app.css", rel="stylesheet", type="text/css")
  ),
  
  #'////////////////////////////////////////
  # UI
  shinyUI(
    
    # layout
    navbarPage(title = 'Batch 9 Analytics',theme = shinytheme("readable"),
               
               
               # tab 1: landing page
               tab_landing_page,
               
               # tab2 : one Country Anlysis
               tab_one_country,
               
               #tab3 : Compare
               tab_two_country
               
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$plot1_db1 = renderPlotly({
    
    fig1 = covid %>% filter(Country %in% c(input$country1_db1) ) %>%  
      plot_ly(x = ~Date_reported_ct, y = ~New_cases, type = 'scatter', mode= 'line', name = 'Cases' )  
    fig2 = covid %>% filter(Country %in% c(input$country1_db1) ) %>%  
      plot_ly(x = ~Date_reported_ct, y = ~New_deaths, type = 'scatter', mode= 'line', name = 'deaths' )    
    
    
    fig_daily = subplot(fig1, fig2, shareX = T,   nrows = 2)  %>%
      layout(title = 'COVID-19 Daily Report', 
             xaxis = list(title = 'Date'))
    
    return(fig_daily)
    
  })
  output$plot2_db1 = renderPlotly({  
    fig3 = covid %>% filter(Country %in% c(input$country1_db1) ) %>%  
      plot_ly(x = ~Date_reported_ct, y = ~Cumulative_cases, type = 'scatter', mode= 'line', name = 'Cases' )  
    fig4 = covid %>% filter(Country %in% c(input$country1_db1) ) %>%  
      plot_ly(x = ~Date_reported_ct, y = ~Cumulative_deaths, type = 'scatter', mode= 'line', name = 'deaths' )    
    
    
    fig_cum = subplot(fig3, fig4, shareX = T, nrows = 2) %>%
      layout(title = 'COVID-19 Camulative Report',
             xaxis = list(title = 'Date'))
    
    return(fig_cum)
    
  })
  
  
  output$plot1_db2 = renderPlotly({
    covid %>% filter(Country %in% c(input$country1_db2, input$country2_db2)) %>%  
      plot_ly(x = ~Date_reported_ct, y = ~New_cases, color = ~Country_code, type = 'scatter', mode= 'line' )
    
  })
  output$plot2_db2 = renderPlotly({
    covid %>% filter(Country %in% c(input$country1_db2, input$country2_db2)) %>%  
      plot_ly(x = ~Date_reported_ct, y = ~New_deaths, color = ~Country_code, type = 'scatter', mode= 'line' )
    
  })
  
  
  
  getPage<-function() {
    return(includeHTML("Index.html"))
  }
  output$inc<-renderUI({getPage()})
} 

# Run the application 
shinyApp(ui = ui, server = server)
