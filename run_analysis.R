

## Creating directory links ##
main_dir <- "C:/R/UCI HAR Dataset"


#################################################
### Step 1: Merging test and train data sets ####
#################################################


## Loading  data using a function ##

load_data <- function(file=c("test", "train")) {
  
        setwd(paste0(main_dir,"/",file))

        
        ## Loading each part of the dataset ##
        activity_id <- as.factor(scan(paste0("y_",file,".txt")))
        subject_id <- as.factor(scan(paste0("subject_",file,".txt")))
        X_data <- scan(paste0("X_",file,".txt"))
  
        X_data <- matrix(X_data, nrow=length(subject_id), 
                            ncol=length(X_data)/length(subject_id))

        ## Creating the final the data frame
        df<- data.frame(subject_id=subject_id, activity_id=activity_id, feature=X_data)
        
      return(df)
}

## First, loading data in a "large" list
data_types <- list("test", "train")
merge_data<- lapply(data_types, load_data)

## Second, merging extracted data frames
merge_data <- merge(merge_data[[1]], merge_data[[2]], all=TRUE)


#########################################################
### Step 2: Extracting means and standard deviations  ###
###         for each feature                          ###
#########################################################

means <- colMeans(merge_data[,3:ncol(merge_data)])
stds  <- apply(merge_data[,3:ncol(merge_data)], 2, sd)


############################################################
### Step 3: Creating data frame with appropriate labels  ###
############################################################

setwd(main_dir)

## Getting feature labels
feature_label <- read.csv("features.txt", header=F, fill=TRUE, sep = "")


## Putting data frame together ##

final_data <- data.frame(measurement=feature_label$V2, mean=means, st_dev=stds)


############################################################
### Step 4: Creating data frame with detailed extracts  ####
############################################################


library(plyr)

## Extract means from db by specific subjects and activities

df2 <- ddply(merge_data, .(subject_id, activity_id), summarize, 
              mean=colMeans(merge_data[,3:ncol(merge_data)]))

## Creating vector for frature names ## 

feat_vec <- rep(feature_label$V2, times=nrow(df2)/nrow(feature_label))

## Creating descriptive labels for activities ## 
act_label <- read.csv("activity_labels.txt", header=F, fill=TRUE, sep = "",
                      colClasses = "character")

attributes(df2$activity_id)$levels <- act_label$V2


## Replacing data frame for the complete tidy data set

df2 <- data.frame(subject_id=df2$subject_id, activity_id=df2$activity_id, 
                  measurement=feat_vec, mean=df2$mean)

write.table(df2, file="tidy_step5.txt", row.name=FALSE)





