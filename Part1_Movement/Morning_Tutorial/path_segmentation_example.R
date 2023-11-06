library(adehabitatHR)
library(momentuHMM)
source("utility_functions.R")

tracks_gps <- read.csv("data/tracks_gps.csv")%>%
  mutate(time = ymd_hms(time))

tracks_gps <- tracks_gps %>% 
  # remove missing locations
  filter(!is.na(x) & !is.na(y),
         # remove identical records
         !(time == lag(time) & x == lag(x) & y == lag(y) & 
             loc_class == lag(loc_class)))

# Use function from utility_function.R to split data at gaps > 2 hours
data_split <- split_at_gap(data = tracks_gps, 
                           max_gap = 60, 
                           shortest_track = 20)

data_sf <- data_split %>%
  st_as_sf(coords = c("x", "y")) %>% # converts to an sf object
  st_set_crs(4326) %>% # define CRS
  st_transform(2962) # reproject data to a UTM

# crawl can fail to fit periodically, so I recommend always setting a seed 
set.seed(12)

# fit crawl
crwOut <- crawlWrap(obsData = data_sf, timeStep = "10 mins")
plot(crwOut, animals = "T172062-1", ask = FALSE)

# Get predicted tracks from crawl output
tracks_reg <- crwOut$crwPredict[which(crwOut$crwPredict$locType == "p"),
                                c( "ID", "mu.x", "mu.y", "time")]
colnames(tracks_reg) <- c( "ID","x", "y", "time")

data <- prepData(tracks_reg)
head(data)

hist(data$step, 25)
hist(data$angle, 25)

# define states (optional)
stateNames <- c("resident", "travel")

nbState <- length(stateNames)
# define distribution to use for each data stream
dist <- list(step = "gamma", angle = "vm")

# Setting up the starting values
mu0 <- c(100, 600) # Mean step length
sigma0 <- mu0/2 # SD of the step length
kappa0 <- c(0.1, 1) # Turn angle concentration parameter

# combine starting parameters 
Par0 <- list(step = c(mu0, sigma0), angle = kappa0)

# Fit a 2 state HMM
m1 <- fitHMM(data, 
             stateNames = stateNames,
             nbState = 2, 
             dist = dist, 
             Par0 = Par0)

# Let's look at parameter estimates 
m1
plot(m1, plotTracks = FALSE)

# Setting up the starting values
mu2 <- c(400, 600) # Mean step length
sigma2 <- mu2/2 # SD of the step length
kappa2 <- c(1, 1) # Turn angle concentration parameter
# combine starting parameters 
Par2 <- list(step = c(mu2, sigma2), angle = kappa2)

# Fit the same 2 state HMM
m1b <- fitHMM(data, 
              stateNames = stateNames, 
              nbState = 2, 
              dist = dist, 
              Par0 = Par2)

m1_RF <- fitHMM(data, 
                stateNames = stateNames, 
                nbState = 2, 
                dist = dist, 
                Par0 = Par0, 
                retryFits = 10)

plotPR(m1)

# Setting up the starting values
mu3 <- c(100, 600, 1000) # Mean step length
sigma3 <- mu3/2 # SD of the step length
kappa3 <- c(0.1, 1, 1) # Turn angle concentration parameter
# combine starting parameters 
Par3 <- list(step = c(mu3, sigma3), angle = kappa3)

m1c <- fitHMM(data, 
              nbState = 3, 
              dist = dist, 
              Par0 = Par3)

plot(m1c, plotTracks = FALSE)

plotPR(m1c)



### another option is to pad with NAs
# Create adehabitat trajectory padded with NAs
data_ade <- setNA(ltraj = as.ltraj(xy = data_split[, c("x", "y")], 
                                   date = data_split$time, 
                                   id = data_split$ID), 
                  date.ref = data_split$time[1], 
                  dt = 10, tol = 5, units = "min")

# Transform back to dataframe
data_na <- ld(data_ade)[, c("id", "x", "y", "date")]
colnames(data_na) <- c("ID", "x", "y", "time")



