CAPSTONE FINAL PRESENTATION 
========================================================
Data Science Capstone Project

Next Word Prediction

An application to predict the next word given a text example

author: Iren Matyus

date: 05.08.2017


Background
========================================================


- The next word prediction app is hosted on shinyapps.io: https://matyusirene.shinyapps.io/capstone_final_app/

- This application was developed for the Johns Hopkins Data Science Specialisation. 

- The object of the app is to construct an algorithm to predict the next word from specific text input.

- Dataset is based on the provided SwiftKey dataset.

- Algorithm is about using pre-computed ngrams to predict next word of a phrase. Pre-computed ngrams includes unigram, bigram, trigram, and quadgram.

UI.R
========================================================


- User can select number of predictions using a slider input (default set to 1 per requirement)

- The slider input is used to set how many Number of Word Predictions are used to output.

- You have to input a phrase to Text Input to see the predictions of the next word/words. 

- User input is echoed back with leading and trailing whitespaces removed. 

- Word predictions are displayed below the text input box.
(Predicted word(s) (in probability (descending order)). 

- On the right side there is a Help text.


Server.R, PredictWord.R
========================================================



- Server.R and PredictWord.R provide the backend of the application.

- There have been Echo the input to UI after removing whitespaces.

- The ngram data is loading, after it is sorted in frequency descending order.

- For details of the processes and combineWords functions, please see the next slide.


Sites
========================================================


- This presentation for the Capstone Final Application is located here: http://rpubs.com/MatyusI/

- App is hosted at: https://matyusirene.shinyapps.io/capstone_final_app/

- The whole code of this application, related scripts and code of this presentation can be found in this Github repo: https://github.com/MatyusI/Capstone-Final-Project-DS


Future Research
========================================================



- A number of things can be done to develop and improve the app, for example:

-- Spell correction of the original corpus.

-- Speed up the prediction algorithm by different methods.

-- Applying more sophisticated methods for predicting instances not in the ngram tables


