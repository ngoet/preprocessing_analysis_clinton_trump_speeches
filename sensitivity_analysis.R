#######################
#Author: Niels Goet
#First version: 8 April 2017
#Current version: 18 April 2017
#######################
library(preText)
library(quanteda)
#library(methods) #uncomment if you want to run from terminal using Rscript
#preText documentation available at: http://www.mjdenny.com/getting_started_with_preText.html

speeches <- read.csv("speeches.csv",stringsAsFactors=F)
speeches <- speeches[order(speeches$speaker),]
texts <- speeches$speech
texts <- 
comps <- 50

  myCorpus <- corpus(texts)
  preprocessed_documents <- factorial_preprocessing(
    myCorpus,
    use_ngrams = TRUE,
    verbose = FALSE,
    cores = 4)
  
 
  
  preText_results <- preText(
    preprocessed_documents,
    dataset_name = "US Presidential Campaign Speeches 2016",
    distance_method = "cosine",
    num_comparisons = comps,
    verbose = FALSE)
  
sensitivity_results <- preText_results$regression_results[,1:4]

print(sensitivity_results)

#generate plot
regression_coefficient_plot(sensitivity_results,
                            remove_intercept = TRUE)

dev.copy2pdf(file="pre_processing_decisions_graph.pdf", width = 5, height = 4)


