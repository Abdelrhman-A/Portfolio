#!/usr/bin/env python
# coding: utf-8

# ## Sentiment Analysis

# In[1]:


import pandas as pd
import matplotlib.pyplot as plt
import tensorflow as tf

from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM,Dense, Dropout, SpatialDropout1D
from tensorflow.keras.layers import Embedding

df = pd.read_csv("C:/Users/abd elrahman/Desktop/New folder/Tweets.csv")


# In[2]:


df.head()


# In[3]:


df.columns


# In[4]:


tweet_df = df[['text','airline_sentiment']]
print(tweet_df.shape)
tweet_df.head(5)


# In[5]:


tweet_df = tweet_df[tweet_df['airline_sentiment'] != 'neutral']
print(tweet_df.shape)
tweet_df.head(5)


# In[6]:


tweet_df["airline_sentiment"].value_counts()


# In[7]:


sentiment_label = tweet_df.airline_sentiment.factorize()
sentiment_label


# In[8]:


tweet = tweet_df.text.values
tokenizer = Tokenizer(num_words=5000)
tokenizer.fit_on_texts(tweet)
vocab_size = len(tokenizer.word_index) + 1
encoded_docs = tokenizer.texts_to_sequences(tweet)
padded_sequence = pad_sequences(encoded_docs, maxlen=200)


# In[9]:


print(tokenizer.word_index)


# In[10]:


print(tweet[0])
print(encoded_docs[0])


# In[11]:


print(padded_sequence[0])


# In[12]:


embedding_vector_length = 32
model = Sequential() 
model.add(Embedding(vocab_size, embedding_vector_length, input_length=200) )
model.add(SpatialDropout1D(0.25))
model.add(LSTM(50, dropout=0.5, recurrent_dropout=0.5))
model.add(Dropout(0.2))
model.add(Dense(1, activation='sigmoid')) 
model.compile(loss='binary_crossentropy',optimizer='adam', metrics=['accuracy'])  
print(model.summary())


# In[16]:


history = model.fit(padded_sequence,sentiment_label[0],validation_split=0.2, epochs=5, batch_size=32)


# In[17]:


def predict_sentiment(text):
    tw = tokenizer.texts_to_sequences([text])
    tw = pad_sequences(tw,maxlen=200)
    prediction = int(model.predict(tw).round().item())
    print("Predicted label: ", sentiment_label[1][prediction])


# In[32]:


test_sentence1 = "I'm too consumed with my own life"
predict_sentiment(test_sentence1)

test_sentence3 = "i enjoy studying"
predict_sentiment(test_sentence3)

predict_sentiment('life is good but it can be so sad')


# In[ ]:




