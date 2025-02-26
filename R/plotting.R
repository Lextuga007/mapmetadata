#' Internal: empty_plot
#'
#' This function is called within the metadata_map function. \cr \cr
#' It plots  \cr \cr
#' @param dataframe Dataframe to plot. Output of empty_count.R function.
#' @param bar_title Title for the plot.
#' @return A plotly object
#' @keywords internal
#' @importFrom plotly plot_ly layout

empty_plot <- function(dataframe, bar_title) {
  barplot_html <- plot_ly(dataframe,
    x = ~Table,
    y = ~N_Variables,
    color = ~Empty,
    colors = c("grey", "darkturquoise"),
    type = "bar",
    text = ~N_Variables,
    textposition = "inside",
    texttemplate = "%{text}",
    textfont = list(color = "black", size = 10)
  ) %>%
    layout(
      barmode = "stack",
      title = bar_title,
      xaxis = list(title = "Table"),
      yaxis = list(title = "Variable Count"),
      legend = list(title = list(text = "Empty Description"))
    )

  barplot_html
}

#' Internal: ref_plot
#'
#' This function is called within the metadata_map function. \cr \cr
#' It plots a reference table to guide the user in their categorisation of domains. \cr \cr
#' This reference table is based on the user inputted domains and the default domains provided by this package.  \cr \cr
#' @param domains The output of load_data
#' @return A reference table that appears in the Plots tab. A list of 2 containing the derivatives for this plot, used later in metadata_map'
#' @keywords internal
#' @importFrom gridExtra tableGrob grid.arrange
#' @importFrom graphics plot.new

ref_plot <- function(domains) {
  colnames(domains)[1] <- "Domain Name"
  plot.new()
  domains_extend <- rbind(c("*NO MATCH / UNSURE*"), c("*METADATA*"), c("*ID*"), c("*DEMOGRAPHICS*"), domains)
  code <- data.frame(code = 0:(nrow(domains_extend) - 1))
  domain_table <- tableGrob(cbind(code, domains_extend), rows = NULL)
  grid.arrange(domain_table, nrow = 1, ncol = 1)

  return(list(code = code, domain_table = domain_table))
}

#' Internal: end_plot
#'
#' This function is called within the metadata_map function. \cr \cr
#' A summary plot is created that includes the domain code reference table and counts of domain code categorisations \cr \cr
#'
#' @param df The Output dataframe with all the domain categorisations
#' @param table_name The table name
#' @param ref_table The domain code reference table (which domain maps to which integer)
#' @return It returns a ggplot
#' @keywords internal
#' @importFrom dplyr %>% group_by count arrange
#' @importFrom stats reorder
#' @importFrom gridExtra grid.arrange
#' @import ggplot2

end_plot <- function(df, table_name, ref_table) {
  counts <- df %>%
    group_by(domain_code) %>%
    count() %>%
    arrange(n)

  domain_plot <- counts %>%
    ggplot(aes(x = reorder(domain_code, -n), y = n)) +
    geom_col() +
    ggtitle(paste("Data Elements in", table_name, "grouped by domain code")) +
    theme_gray(base_size = 18) +
    theme(axis.text.x = element_text(
      angle = 90,
      vjust = 0.5,
      hjust = 1
    )) +
    xlab("Domain Code") +
    ylab("Count") +
    scale_y_continuous(breaks = seq(0, max(counts$n), 1))

  full_plot <- grid.arrange(domain_plot,
    ref_table,
    nrow = 1,
    ncol = 2
  )
  return(full_plot)
}
