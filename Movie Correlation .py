#!/usr/bin/env python
# coding: utf-8

# In[2]:


#Import Libraies 
import pandas as pd
import numpy as np
import seaborn as sns

import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import matplotlib
plt.style.use('ggplot')
from matplotlib.pyplot import figure

get_ipython().run_line_magic('matplotlib', 'inline')
matplotlib.rcParams['figure.figsize'] = (12,8)

pd.options.mode.chained_assignment = None




df = pd.read_csv(r'C:\Users\User\Documents\Abner The Anlyst Projects\movies.csv')


# In[17]:


df()


# In[3]:


# Let's see if there is any missing data

for col in df.columns:
    pct_missing = np.mean(df[col].isnull())
    print('{} - {}%'.format(col, round(pct_missing)))


# In[39]:


# Data types for our columns

df.dtypes


# In[8]:


# type casting on Budget and Gross to get rid of decimal point 
df ['budget'] = df ['budget'].astype('int64')
df ['gross'] = df ['gross'].astype('int64')


# In[9]:


df


# In[17]:


#Creat correct year colomn

df['yearcorrect'] = df['released'].astype(str)[:4]

df


# In[22]:


df = df.sort_values(by=['gross'], inplace=False, ascending=False)


# In[21]:


pd.set_option('display.max_rows', None)


# In[40]:


# We need to see if we have any missing data
# Let's loop through the data and see if there is anything missing

for col in df.columns:
    pct_missing = np.mean(df[col].isnull())
    print('{} - {}%'.format(col, round(pct_missing*100)))


# In[26]:


# Drop any duplicates
df['company'].drop_duplicates().sort_values(ascending=False)


# In[4]:


df.boxplot(column=['gross'])


# In[33]:


df.head()


# In[5]:


df.sort_values(by=['gross'], inplace=False, ascending=False)


# In[35]:


# Scatter plot with budget vs gross

plt.scatter(x =df['budget'], y=df['gross'])

plt.title('Budget vs Gross Earnings')

plt.xlabel('Gross Earnings')

plt.ylabel('Budget for Film')

plt.show()


# In[38]:


# Plot budget vs gross using seaborn

sns.regplot(x='budget', y='gross', data=df, scatter_kws={"color": "red"}, line_kws={"color":"blue"})


# In[40]:


df.corr(method ='pearson')


# In[41]:


df.corr(method ='kendall')


# In[42]:


df.corr(method ='spearman')


# In[43]:


# High Correlation between budget and gross


# In[44]:


correlation_matrix = df.corr()

sns.heatmap(correlation_matrix, annot = True)

plt.title("Correlation matrix for Numeric Features")

plt.xlabel("Movie features")

plt.ylabel("Movie features")

plt.show()


# In[45]:


#looks at Company

df.head()


# In[50]:


df_numerized = df

for col_name in df_numerized.columns:
    if(df_numerized[col_name].dtype == 'object'):
        df_numerized[col_name] = df_numerized[col_name].astype('category')
        df_numerized[col_name] = df_numerized[col_name].cat.codes
        
df_numerized


# In[51]:


correlation_matrix = df_numerized.corr()

sns.heatmap(correlation_matrix, annot = True)

plt.title("Correlation matrix for Numeric Features")

plt.xlabel("Movie features")

plt.ylabel("Movie features")

plt.show()


# In[52]:


df_numerized.corr()


# In[53]:


correlation_mat = df_numerized.corr()

corr_pairs = correlation_mat.unstack()

corr_pairs


# In[55]:


sorted_pairs = corr_pairs.sort_values()
sorted_pairs


# In[56]:


high_corr = sorted_pairs [(sorted_pairs) > .05]
high_corr


# In[ ]:


# Votes and budget have the highst correlation to gross earnings 

