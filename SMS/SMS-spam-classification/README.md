# SMS spam classification
 ## Project Overview
The goal of this project is to classify SMS messages into spam or ham categories. The dataset is preprocessed and then fed into two types of models: a Support Vector Machine (SVM) and a Neural Network with LSTM layers.

## Technologies and Libraries
The project utilizes the following libraries and technologies:

- **scikit-learn**: For model training and evaluation (SVM, train_test_split, confusion_matrix, accuracy_score)
- **TensorFlow and Keras**: For building and training the neural network
- **NLTK**: For natural language processing (tokenization, stopwords, stemming, lemmatization)

## Data Preprocessing
The preprocessing steps include:
1. Tokenization using NLTK's `word_tokenize`.
2. Removal of stopwords from the NLTK corpus.
3. Stemming using `PorterStemmer` and lemmatization with `WordNetLemmatizer`.
4. Text vectorization using Keras's `Tokenizer` and padding sequences using `pad_sequences`.

## Model Training and Evaluation
### Support Vector Machine (SVM)
- The dataset is split into training and testing sets using `train_test_split`.
- An SVM model is trained on the training data.
- The model achieved an accuracy of 90.22% on the test data.

### Neural Network with LSTM
- A Sequential model is built with the following layers:
  - Embedding
  - SpatialDropout1D
  - LSTM
  - Dense with ReLU activation
  - Dropout
  - Dense with sigmoid activation
- The model is compiled and trained on the preprocessed data.
- The neural network achieved a test accuracy of 99.64%.

## Results
- **SVM Accuracy**: 90.22%
- **Neural Network Accuracy**: 99.64%
