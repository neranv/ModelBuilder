# Interactive Model Builder

This was done as part of the Coursera course - "Developing Data Products"

This is an interactive linear model builder which helps one to see the 
effects of different predictors on the ouput. Two sample datasets are 
used - mtcars, iris. It is straight forward to use. First decide and choose a 
dataset. After choosing a dataset, select an output that you would like to 
predict and then select the predictors that you would like to include in your model. 
Click on build model. Once you click on that you would see summary and a plot. 
The plot shows acutal vs predicted values. 
Some things to note
1. The variable selected as ouput wont show up in the predictors list.
2. Model is built using the lm() function.
3. Predicted values are obtained using the predict() function.
