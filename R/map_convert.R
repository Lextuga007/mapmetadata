#' map_convert
#'
#' The 'OUTPUT_' file groups multiple categorisations onto one line e.g. Domain_code could read '1,3' \cr \cr
#' This function creates a new longer output 'L-OUTPUT_' which gives each categorisation its own row. \cr \cr
#' This 'L-OUTPUT_' may be more useful when using these csv files in later analyses.
#' @param output_csv The name of the 'OUTPUT_' csv file that was created from metadata_map
#' @param output_dir The location of output_csv
#' @return The function will return 'L-OUTPUT_' in the same output_dir
#' @export
#' @importFrom utils read.csv write.csv
#' @examples
#' # Locate file path and file name for the example files in the package
#' demo_output_dir <- system.file("outputs", package = "mapmetadata")
#' demo_output_csv <- "MAPPING_360_NationalCommunityChildHealthDatabase(NCCHD)_CHILD_2024-12-19-14-17-45.csv"
#'
#' # Run the function
#' map_convert(output_csv = demo_output_csv, output_dir = demo_output_dir)
map_convert <- function(output_csv, output_dir) {
  output <- read.csv(paste0(output_dir, "/", output_csv))
  output_long <- output[0, ] # make duplicate

  for (row in seq_len(nrow(output))) {
    if (grepl(",", output$domain_code[row])) { # Domain_code for this row is a list
      domain_code_list <- output$domain_code[row] # extract Domain_code list
      domain_code_list_split <- unlist(strsplit(domain_code_list, ",")) # split the list
      for (code in seq_len(length(domain_code_list_split))) { # for every domain code in list, create a new row
        row_to_copy <- output[row, ] # extract row
        row_to_copy$domain_code <- domain_code_list_split[code] # change domain code to single
        output_long[nrow(output_long) + 1, ] <- row_to_copy # copy altered row
      }
    } else { # Domain_code for this row is not list
      row_to_copy <- output[row, ] # extract row
      output_long[nrow(output_long) + 1, ] <- row_to_copy # copy unaltered row
    }
  }

  # Save output_long
  write.csv(output_long, paste0(output_dir, "/", "L-", output_csv), row.names = FALSE)
}
