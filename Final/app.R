library("shiny")

trial_coin <- read.csv("coin_trials.csv")
trial_coin$Trial <- NULL
trial_dice <- read.csv("dice_trials.csv")
trial_dice$Trial <- NULL
trial_20 <- read.csv("trials.csv")
trial_20$Trial <- NULL

ui <- fluidPage(includeCSS("styles.css"),
  fluidRow(
    withMathJax(),
    column(8,
           h1("Final Project, Part 3")
           ),
    column(2,
           h6("Daniel Izaguirre"), 
           h6("Daniel Mihok"),
           h6("Brandon Day")
           ),
    column(2,
           h6("Probablilty and Statistics"),
           h6("Professor Ying"),
           h6("Project Part 3 - Game")
    )
  ),
  fluidRow(
    h2("Lottery Game"),
    sidebarLayout(
      sidebarPanel(
        h2("The Game Rules:"),
        p("1) The player must flip a coin. The player loses with a tails."),
        p("2) If the player flipped heads, then the player may roll a dice."),
        p("3) The player only wins if the dice roll is greater than 3. Win on 4+."),
        h2("Events"),
        h4("The Coin Flip"),
        p("If \\(X\\) is a Random Binomial variable, then"), 
        p("$$P(X = x ) = 1/2$$", style = "font-size:200%"),
        hr(),
        h4("The Dice Roll(D6)"),
        p("If \\(X\\) is a Discrete Random variable per roll, then"), 
        p("$$P(X = x ) = 1/6$$", style = "font-size:200%"),
        p("If \\(X\\) is a Discrete Random variable to win, then"), 
        p("$$P(X = x ) = 1/2$$", style = "font-size:200%"),
        h4("To Win"),
        p("If \\(X\\) is a Discrete Random variable for a coin flip and dice roll, then"), 
        p("$$P(Coin(Head)||Dice(4+)) = 1/4$$", style = "font-size:200%")
      ),
      mainPanel(
        mainPanel(
          h2("Tree Diagram"),
          img(src = 'prob_tree.jpg', height = '350px', width = '500px'),
          h2("Probability Table"),
          img(src = 'prob_table.jpg', height = '350px', width = '500px')
        ),
        sidebarPanel(
          h2("Need a coin?"),
          helpText(a("Coin", href="https://www.freeonlinedice.com/#coin", target="_blank")),
          h2("Need a die?"),
          p("Remember to set the amount of dice to 1."),
          helpText(a("Die", href="https://www.freeonlinedice.com/#dice", target="_blank")),
          p("*Disclaimer: Computers use pseudorandom number generation.*"),
          p("For best results: Find a real quarter and 6 sided dice.")
        )
      )    
    )
  ),
  fluidRow(
    sidebarLayout(
      sidebarPanel(
        h2("10 Coin Flips"),
        p("This is 10 trials of a coin flip. It was about a 50/50 split between
          heads and tails, where the trial favored heads. In the Game, this means that you would only be able 
          to move onto the dice roll half of the time. The odd at 50% to proceed 
          are not significant.")
      ),
      mainPanel(
        h2("10 Trials of a Coin Flip"),
        DT::dataTableOutput("coin10")
      )
    ),
    sidebarLayout(
      sidebarPanel(
        h2("10 Dice Rolls"),
        p("This is 10 trials of a dice roll. The dice was rolled 10 times and it
          provided a relatively even spread of high and low numbers. This would 
          mean that the odd to win the game with a 4+ is relatively low. Having this 
          condition with the dice makes winning the game difficult. It is certaintly
           not in favor of the player.")
      ),
      mainPanel(
        h2("10 Trials of a Dice Roll"),
        DT::dataTableOutput("dice10")
      )
    )
  ),
  fluidRow(
    sidebarLayout(
      sidebarPanel(
        h2("Test the Game:"),
        p("Play this game yourself. Find a coin and die, then test the probabilities of the game yourself.
          You will certainly fall into the losing side after 20 trials. At that amount of trials, the odds
          are not in your favor, because there are many events. Within the events there are conditions which
          are like events themselves. With more events there is a lower chance of winning the game. This idea 
          is highly relevent to the lottery."),
        h2("Save Your Money"),
        p("The odds of winning the lottery are terrible. In the same manner, each even that is possible is far larger.
          This is because many people buy lottery tickets. With more people buying lottery tickets, your chances
          of winning drop with each of their tickets. Therefore it is better to simply save your money.")
      ),
      mainPanel(
        h2("20 Trials Following the Rules of the Game"),
        DT::dataTableOutput("trials")
      )
    )
  )
)

server <- function(input, output, session){
  output$coin10 <- DT::renderDataTable({
    DT::datatable(trial_coin)
  })
  output$dice10 <- DT::renderDataTable({
    DT::datatable(trial_dice)
  })
  output$trials <- DT::renderDataTable({
      DT::datatable(trial_20)
  })
}

shinyApp(ui = ui, server = server)