# exchange_rate_prices

## Project Information
# Figma https://www.figma.com/file/Gd13gQCvkEyCo9Ef4r9Crz/Exchange-rate-app?type=design&node-id=0%3A1&mode=design&t=38OfvHVTwz7gq1v0-1
# The rate currency seems to be missing in the description I will use a Cat currency instead 🐱
# Added custom analysis_options.yaml


## Thought processes
# GIT policy: I usually do a single commit for base of the project -  done here as well, the logic is tied together and all the parts are needed for final result and visual testing and adjustments. After that base being done I like to have smaller commits especially when it changes the logic crucially. 
# Widget separation. I keep some widgets in the files of their screen. If the screen gets too big or the widgets could be reused I would put them to widget folder for a small simple screen I prefer keep them there for easier manipulation.
# Integration and Unit tests could be created here for a Bloc logic and API communication. Also End to end tests would be an option for the design and states. I treat it as out of scope and not necessary for such a small amount of logic.


## Ideas
# Change historyLength from Float to Int - it is more suitable data type
# The model could be separate for both endpoints because of different use but at the moment the data are too similar. When the detail info would be extended then it makes sense.
# The iOS and Android parts need a bit more care in order to be released - TBD
# Icon app would be nice to add - TBD