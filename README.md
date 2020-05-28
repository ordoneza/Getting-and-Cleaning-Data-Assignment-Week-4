---
title: "README"
author: "Andrea Ordonez"
date: "5/28/2020"
output: html_document
---

## Getting and Cleaning Data Week4 Assignment

This repo was created to complete the Getting and Cleaning Data course. 

**Data Description**
The data provided for this assignment was based on recording signal measurements, using smart phones, of every day human activity. Various signal measurments were computed for 30 subjects conducting 6 different activites (walking, walking upstrairs, walking downstairs, sitting, standing, laying)

**Data Manipulation**

The original files for this project can be found at <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> and for more background imformation on this experimental set-up, reference <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.

From the original data, the training and test data sets were grouped together and labels for each variable were assigned, including the activities column were labels were assinged corresponding to its interger value. A new "tidy data" set was created with the averages of each variable for each activity and suject. Variable names were also edited to maked them more readable. 

 