# README

# Dependencies:
- ruby 3.0.0
- rails 6.1
- postgresql 

# For testing localy: 


```
bundle install; rake db:migratt; rails s
```

Establish a websocket connection:
```
ws://localhost:3000/cable
```

Connect to chennal: 
```
{
  "command":"subscribe",
  "identifier":"{\"channel\":\"ChatChannel\"}"
}
```

# For testing in prod:

Establish a websocket connection:
```
ws://quarttest.herokuapp.com/cable
```

Connect to chennal: 
```
{
  "command":"subscribe",
  "identifier":"{\"channel\":\"ChatChannel\"}"
}
```
