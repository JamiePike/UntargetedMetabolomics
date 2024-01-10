# basic statistics of symptom development

# -------------- Set up -------------- #
# load packages
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(tidyverse))
# set working dir and load the data
setwd("/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/SymptomsScores")
rawdat <- read.csv("/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/SymptomsScores/rawdata.csv")

# ------------- Functions ------------- #
# create a function so aggregate can calculate more than one statistic
stats <- function(x) c(Mean = mean(x), SD = sd(x))

# --------- External Symptoms --------- #
# calculate mean for external symptom score
external_mean <- do.call(data.frame, aggregate(
    x = rawdat$External_ss,
    by = list(time = rawdat$Timepoint_no., treatment = rawdat$Treatment_group),
    FUN = stats))
# build plot of external symptom score over time
external_plot <- ggplot(data = external_mean, aes(x = time, y = x.Mean, col = treatment)) +
    geom_errorbar(aes(ymin=x.Mean-x.SD, ymax=x.Mean+x.SD), width=.035, alpha = 0.5, linetype = 5) +
    geom_line() + geom_point() +
    scale_color_manual(values=c("#999999", "#56B4E9", "#E69F00", "#e94646e6")) +
    labs(x="Sampling Time Point", y = "Mean Symptom Score", color="Treatment Group")+
    theme_bw() +
    scale_x_continuous(breaks=c(1,2,3)) +
    theme(legend.position="bottom")
# save the plot
ggsave("External_plot.png")

# --------- Internal Symptoms --------- #
# calculate mean for internal symptom score
internal_mean <- do.call(data.frame, aggregate(
    x = rawdat$Internal_ss,
    by = list(time = rawdat$Timepoint_no., treatment = rawdat$Treatment_group),
    FUN = stats))
# build plot of internal symptom score over time
external_plot <- ggplot(data = internal_mean, aes(x = time, y = x.Mean, col = treatment)) +
    geom_errorbar(aes(ymin=x.Mean-x.SD, ymax=x.Mean+x.SD), width=.035, alpha = 0.5, linetype = 5) +
    geom_line() + geom_point() +
    scale_color_manual(values=c("#999999", "#56B4E9", "#E69F00", "#e94646e6")) +
    labs(x="Sampling Time Point", y = "Mean Symptom Score", color="Treatment Group")+
    theme_bw() +
    scale_x_continuous(breaks=c(1,2,3)) +
    theme(legend.position="bottom")
# save the plot
ggsave("Internal_plot.png")
