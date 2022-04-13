##################################################################
# Economic and Political Freedom: Its Determinants, and Outcomes #
##################################################################

# importing libraries
import numpy as np
import pandas as pd
import xlrd
from PIL import Image # converts images into arrays

#####################################
# Visualizing Data using Matplotlib #
#####################################

# importing libs
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches # required for waffle charts

mpl.style.use('ggplot')

# print('Matplotlib version: ', mpl.__version__) # >= 3.1.3

#####################
# Word Cloud: India #
#####################

# importing package
from wordcloud import WordCloud, STOPWORDS
import wget

# print('Wordcloud is installed and imported!')
'''
# opening text file and reading it into a variable called india_constitution
india_constitution = open('india_constitution.txt', 'r', encoding="utf8").read()
# print('File downloaded and saved!')

# removes redundant 'stopwords'
stopwords = set(STOPWORDS)

# preparing to generate a word cloud
# by first subsetting to the first 2000 words of the novel

# declaring a word cloud object
india_wc = WordCloud(
    background_color='white',
    max_words=2000,
    stopwords=stopwords
)

# generating the word cloud
india_wc.generate(india_constitution)


# actually plotting the cloud display, iteration 1
plt.imshow(india_wc, interpolation='bilinear')
plt.axis('off')
plt.show()

# resizing the word cloud, iteration 2
fig = plt.figure()
fig.set_figwidth(14)  # setting width
fig.set_figheight(18) # setting height

# displaying the cloud, iteration 2
plt.imshow(india_wc, interpolation='bilinear')
plt.axis('off')
plt.show()

# scrapping unnecessary words, iteration 3
# stopwords.add('person') # adding person to stopwords

# re-generating the cloud visual, iteration 3
india_wc.generate(india_constitution)

# displaying the word cloud, iteration 3
fig = plt.figure()
fig.set_figwidth(14)  # setting width
fig.set_figheight(18) # setting height

plt.imshow(india_wc, interpolation='bilinear')
plt.axis('off')
plt.show()

# using wordcloud to superimpose cloud visuals onto a mask image

# reading in and saving mask image file
india_mask = np.array(Image.open('india_mask.png'))
# print('Image downloaded and saved!')

# opening and displaying image shell
fig = plt.figure()
fig.set_figwidth(14)  # setting width
fig.set_figheight(18) # setting height

plt.imshow(india_mask, cmap=plt.cm.gray, interpolation='bilinear')
plt.axis('off')
plt.show()

# declaring a word cloud object, iteration 4
india_wc = WordCloud(background_color='white', max_words=2000, mask=india_mask, stopwords=stopwords)

# generating the word cloud, iteration 4
india_wc.generate(india_constitution)

# displaying the word cloud, iteration 4
fig = plt.figure()
fig.set_figwidth(14)  # setting width
fig.set_figheight(18) # setting height

plt.imshow(india_wc, interpolation='bilinear')
plt.axis('off')
plt.show()
'''

###################
# Word Cloud: USA #
###################
'''
# opening text file and reading it into a variable called us_constitution
us_constitution = open('us_constitution.txt', 'r', encoding="utf8").read()
# print('File downloaded and saved!')

# removes redundant 'stopwords'
stopwords = set(STOPWORDS)

# preparing to generate a word cloud
# by first subsetting to the first 2000 words of the novel

# declaring a word cloud object
us_wc = WordCloud(
    background_color='white',
    max_words=2000,
    stopwords=stopwords
)

# generating the word cloud
us_wc.generate(us_constitution)


# actually plotting the cloud display, iteration 1
plt.imshow(us_wc, interpolation='bilinear')
plt.axis('off')
plt.show()

# resizing the word cloud, iteration 2
fig = plt.figure()
fig.set_figwidth(14)  # setting width
fig.set_figheight(18) # setting height

# displaying the cloud, iteration 2
plt.imshow(us_wc, interpolation='bilinear')
plt.axis('off')
plt.show()

# scrapping unnecessary words, iteration 3
# stopwords.add('person') # adding person to stopwords

# re-generating the cloud visual, iteration 3
us_wc.generate(us_constitution)

# displaying the word cloud, iteration 3
fig = plt.figure()
fig.set_figwidth(14)  # setting width
fig.set_figheight(18) # setting height

plt.imshow(us_wc, interpolation='bilinear')
plt.axis('off')
plt.show()

# using wordcloud to superimpose cloud visuals onto a mask image

# reading in and saving mask image file
usa_mask = np.array(Image.open('usa_mask.png'))
# print('Image downloaded and saved!')


# opening and displaying image shell
fig = plt.figure()
fig.set_figwidth(14)  # setting width
fig.set_figheight(18) # setting height

plt.imshow(usa_mask, cmap=plt.cm.gray, interpolation='bilinear')
plt.axis('off')
plt.show()

# declaring a word cloud object, iteration 4
us_wc = WordCloud(background_color='white', max_words=2000, mask=usa_mask, stopwords=stopwords)

# generating the word cloud, iteration 4
us_wc.generate(us_constitution)

# displaying the word cloud, iteration 4
fig = plt.figure()
fig.set_figwidth(14)  # setting width
fig.set_figheight(18) # setting height

plt.imshow(us_wc, interpolation='bilinear')
plt.axis('off')
plt.show()
'''








































# in order to display plot within window
# plt.show()
