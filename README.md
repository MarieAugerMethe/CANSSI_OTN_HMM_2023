# CANSSI OTN Hidden Markov Model Workshop 2023

## Description and format

This workshop was developed by Fanny Dupont, Natasha Klappstein, Arturo Esquivel, Marco Gallegos Herrada, Vinky Wang, Eric Ste-Marie, Ron Togunov, Vianey Leos Barajas, and Marie Auger-Méthé, for the 2023 CANSSI meeting and OTN ERC workshop. The goal of the workshop is to illustrate how hidden Markov models (HMMs) can be used to classify behaviours and identify behaviour-specific habitat associations using a range of movement and biologging data. It is divided in two parts: morning and afternoon.

## Pre workshop preparation

Before the workshop, please read the instruction in one of the Installing instruction files (e.g., [0_Installing_packages](0_Installing_packages.Rmd)) files. Some of the packages can be tricky to install, so please install them before the workshop.
  
## Morning tutorial 
The tutorial will be completed together, and can be found in the [activity](./Morning_Tutorial/Activity/Tutorial_Narwhal_morning_activity.Rmd) folder and will begin with a 30-minute introduction that will provide an overview of the tutorial objectives, and will go through the statistical background required. The tutorial has some guided activities.

## Workshop learning objectives

- Statistical framework for HMMs and their application to animal movement data
- Selecting appropriate temporal resolution for HMM analysis
- Interpolating missing locations (linear, crw, path segmentation, and multiple imputation)
- Fit HMMs to animal movement data to identify behaviours
- Incorporate covariates on state transition probability to identify conditions that promote different behaviours
- Integrating covariates on emission probabilities to model biased random walks 

## Prerequisite experience

- Intermediate R coding
- Familiarity with animal movement/telemetry data

## Preparation/instructions

- Download and unzip workshop zip from Github
- Install all the required packages as described in 0_Installing_packages.Rmd
- Make sure all packages are up-to-date as older versions may not work
- View each lecture in advance of their respective workshop date
- Create new R script in the CANSSI_OTN_HMM_2023 directory
- Follow the slides by opening  [slides](./Morning_Tutorial/presentation_slides.pdf)
- If you get lost, you can follow along with the completed tutorial [html](./Morning_Tutorial/Narwhal/Tutorial_Narwhal_morning.html) file.

## Afternoon Tutorial

The session will begin with a 20-minute introduction to accelerometer data then move into a live coding demonstration of how a basic HMM can be fit to acceleration data. There will be exercises at the end and the solutions will be posted the following day. 

## Workshop learning objectives 

  - Fit a basic HMM to accelerometer data using `momentuHMM`
  - Incorporating and interpreting covariates on behaviour transition probabilities
  - Visualizing the Depth time series with decoded states
  - Use the Akaike Information Criteria for model selection
  - Practice what you've learned by working on exercises 
