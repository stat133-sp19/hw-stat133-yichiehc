#
# binomial
#
# Scripts for functions used in the "binomial" package.
#
#
#
# Some useful keyboard shortcuts for package authoring:
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
#





#################################
### Private Checker Functions ###
#################################


# @title check_prob
# @description test if an input 'prob' is a valid probability value (i.e. 0 <= p <= 1)
# @param prob the probability of success on each trial
# @return TRUE if 'prob' is vaild; Error if 'prob' is invalid
check_prob <- function(prob) {
  if (0 <= prob & prob <= 1) {
    return(TRUE)
  } else {
    stop('invalid prob value')
  }
}


# @title check_trials
# @description test if an input 'trials' is a valid value for number of trials (i.e. n is a non-negative integer)
# @param trials the number of (fixed) trials
# @return TRUE if 'trials' is vaild; Error if 'trials' is invalid
check_trials <- function(trials) {
  if (trials >= 0 & trials %% 1 == 0) {
    return(TRUE)
  } else {
    stop('invalid trials value')
  }
}


# @title check_success
# @description test if an input 'success' is a valid value for number of successes (i.e. 0 <= k <= n)
# @param trials the number of (fixed) trials
# @param success a vector of the numbers of successes out of n trials
# @return TRUE if 'success' is vaild; Error if 'success' is invalid
check_success <- function(success, trials) {
  if (sum(success >= 0) + sum(success %% 1 == 0) + sum(success <= trials) == 3*length(success)) {
    return(TRUE)
  } else {
    stop('invalid success value')
  }
}





###################################
### Private Auxiliary Functions ###
###################################

# aux_mean(trials, prob): return mean
# aux_variance(trials, prob): return variance
# aux_mode(trials, prob): return mode
# aux_skewness(trials, prob): return skewness
# aux_kurtosis(trials, prob): return kurtosis


aux_mean <- function(trials, prob) {
  return(trials * prob)
}


aux_variance <- function(trials, prob) {
  return(trials * prob * (1 - prob))
}


aux_mode <- function(trials, prob) {
  m  <-  trials * prob + prob
  if (m %% 1 == 0) {
    return(c(m, m-1))
  } else {
    return(floor(m))
  }
}


aux_skewness <- function(trials, prob) {
  return((1-2*prob)/sqrt(trials*prob*(1-prob)))
}


aux_kurtosis <- function(trials, prob) {
  return((1-6*prob*(1-prob))/(trials*prob*(1-prob)))
}





#############################
### Function bin_choose() ###
#############################


#' @title bin_choose
#' @description calculate the number of combinations in which k successes can occur in n trials
#' @param n trials
#' @param k a vector of the numbers of successes out of n trials
#' @return n choose k
#' @export
#' @examples
#' bin_choose(n = 5, k = 2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)
bin_choose <- function(n, k) {
  if (sum(k>n) != 0) {
    stop('k can not be greater than n')
  } else {
    return(factorial(n)/(factorial(k)*factorial(n-k)))
  }
}





##################################
### Function bin_probability() ###
##################################


#' @title bin_probability
#' @description calculate the probability
#' @param success a vector of the numbers of successes out of n trials
#' @param trials the number of (fixed) trials
#' @param prob the probability of success on each trial
#' @return the probability
#' @export
#' @examples
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#' bin_probability(success = 55, trials = 100, prob = 0.45)
bin_probability <- function(success, trials, prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)

  result <- bin_choose(n = trials, k = success) * prob^success * (1-prob)^(trials-success)
  return(result)
}





###################################
### Function bin_distribution() ###
###################################


#' @title bin_distribution
#' @description return a data frame with the probability distribution: success and probability
#' @param trials the number of (fixed) trials
#' @param prob the probability of success on each trial
#' @return a data frame with the probability distribution
#' @export
#' @examples
#' bin_distribution(trials = 5, prob = 0.5)
bin_distribution <- function(trials, prob) {
  bin_dis <- data.frame(
    success = 0:trials,
    probability = bin_probability(0:trials, trials, prob)
  )
  class(bin_dis) <- c('bindis', 'data.frame')
  return(bin_dis)
}

#' @export
plot.bindis <- function(bin_dis) {
  barplot(bin_dis$probability, names.arg = bin_dis$success, xlab = "successes", ylab = "probability")
}
#dis1 <- bin_distribution(trials = 5, prob = 0.5)
#plot(dis1)





#################################
### Function bin_cumulative() ###
#################################


#' @title bin_cumulative
#' @description return a data frame with both the probability distribution and the cumulative probabilities: success, probability, and cumulative
#' @param trials the number of (fixed) trials
#' @param prob the probability of success on each trial
#' @return a data frame with the probability distribution and cumulative probability
#' @export
#' @examples
#' bin_cumulative(trials = 5, prob = 0.5)
bin_cumulative <- function(trials, prob) {
  success <- 0:trials
  probability <- bin_probability(success, trials, prob)
  cumulative <- probability
  for (i in 2:length(probability)) {
    cumulative[i] <- cumulative[i-1] + probability[i]
  }
  bin_cum <- data.frame(
    success = success,
    probability = probability,
    cumulative = cumulative
  )
  class(bin_cum) <- c('bincum', 'data.frame')
  return(bin_cum)
}

#' @export
plot.bincum <- function(bin_cum) {
  plot(bin_cum$success, bin_cum$cumulative, type = 'o', xlab = "successes", ylab = "probability")
}
#dis2 <- bin_cumulative(trials = 5, prob = 0.5)
#plot(dis2)





###############################
### Function bin_variable() ###
###############################


#' @title bin_variable
#' @description return an object of class "binvar"
#' @param trials the number of (fixed) trials
#' @param prob the probability of success on each trial
#' @return an object of class "binvar"
#' @export
#' @examples
#' bin_variable(trials = 10, prob = 0.3)
bin_variable <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  list <- list(trials = trials, prob = prob)
  class(list) <- "binvar"
  return(list)
}

#' @export
print.binvar <- function(bin_var) {
  cat("\"Binomial variable\"\n\nParameters\n")
  cat("- number of trials: ", bin_var$trials, "\n")
  cat("- prob of successs: ", bin_var$prob)
}
#bin1 <- bin_variable(trials = 10, p = 0.3)
#bin1

#' @export
summary.binvar <- function(bin_var) {
  trials <- bin_var$trials
  prob <- bin_var$prob
  list <- list(trials = trials,
               prob = prob,
               mean = aux_mean(trials, prob),
               variance = aux_variance(trials, prob),
               mode = aux_mode(trials, prob),
               skewness = aux_skewness(trials, prob),
               kurtosis = aux_kurtosis(trials, prob)
  )
  class(list) <- "summary.binvar"
  return(list)
}

#' @export
print.summary.binvar <- function(summary_bin_var) {
  cat("\"Summary Binomial\"\n\nParameters\n")
  cat("- number of trials: ", summary_bin_var$trials, "\n")
  cat("- prob of successs: ", summary_bin_var$prob, "\n\n")
  cat("Measures\n")
  cat("- mean    : ", summary_bin_var$mean, "\n")
  cat("- variance: ", summary_bin_var$variance, "\n")
  cat("- mode    : ", summary_bin_var$mode, "\n")
  cat("- skewness: ", summary_bin_var$skewness, "\n")
  cat("- kurtosis: ", summary_bin_var$kurtosis)
}
#bin1 <- bin_variable(trials = 10, p = 0.3)
#binsum1 <- summary(bin1)
#binsum1





#############################
### Functions of measures ###
#############################


#' @title bin_mean
#' @description calculates the mean of the binomial distribution
#' @param trials the number of (fixed) trials
#' @param prob the probability of success on each trial
#' @return the mean of the binomial distribution
#' @export
#' @examples
#' bin_mean(10, 0.3)
bin_mean <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_mean(trials, prob))
}


#' @title bin_variance
#' @description calculates the variance of the binomial distribution
#' @param trials the number of (fixed) trials
#' @param prob the probability of success on each trial
#' @return the variance of the binomial distribution
#' @export
#' @examples
#' bin_variance(10, 0.3)
bin_variance <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_variance(trials, prob))
}


#' @title bin_mode
#' @description calculates the mode of the binomial distribution
#' @param trials the number of (fixed) trials
#' @param prob the probability of success on each trial
#' @return the mode of the binomial distribution
#' @export
#' @examples
#' bin_mode(10, 0.3)
bin_mode <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_mode(trials, prob))
}


#' @title bin_skewness
#' @description calculates the skewness of the binomial distribution
#' @param trials the number of (fixed) trials
#' @param prob the probability of success on each trial
#' @return the skewness of the binomial distribution
#' @export
#' @examples
#' bin_skewness(10, 0.3)
bin_skewness <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_skewness(trials, prob))
}


#' @title bin_kurtosis
#' @description calculates the kurtosis of the binomial distribution
#' @param trials the number of (fixed) trials
#' @param prob the probability of success on each trial
#' @return the kurtosis of the binomial distribution
#' @export
#' @examples
#' bin_kurtosis(10, 0.3)
bin_kurtosis <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_kurtosis(trials, prob))
}


