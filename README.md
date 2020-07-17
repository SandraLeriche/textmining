# textmining

[Data](https://github.com/SandraLeriche/textmining/tree/master/data) contains unnamed documents (corpus) to analyse and rename

[Report](https://github.com/SandraLeriche/textmining/tree/master/report) is the professional report on the analysis completed that I invite you to read

[Output](https://github.com/SandraLeriche/textmining/tree/master/output) is the final classification of the documents into subfolders and the docs itself have been renamed

[Script](https://github.com/SandraLeriche/textmining/tree/master/script) contains the R code used for this project

Below is a blog post on the use of the techniques of text analysis in the workplace: 


## Text analysis in the workplace

When the term "big data" is mentioned, it is common to immediately think of an important dataset of numerical values. While this is mostly true, datasets can also be composed mostly of text in the form of customer reviews, social media messages (tweets, posts), emails - internal and external communication. Since the late 1990's (Grimes, 2007), a variety of text analysis techniques have emerged and are now commonly used in the workplace to answer different business objectives and create data-driven companies. These techniques have since improved and this article will outline the different uses of text mining in the workplace and its implications.

## Who is analysing textual data and in what form?

Various industries are using textual data analysis, whether it is in manufacturing (competitor analysis), healthcare (disease outbreaks using social media), government (predicting crime), financial institutions (identify fraudulent operations), and companies who are interested in finding more about their customer's behavioural patterns and preferences.

Examples of data gathered by companies themselves or collected to be analysed: 
- Social media (tweets, post, hashtags) to identify trends, disease outbreaks
-  Product information: customer reviews on product or a competitor's product 
- Credit card transactions: merchant information collected, analyse behaviour for fraud detection - Health records: comments in a patient's file
 - Police records: comments in files of people who have been previously arrested
 -  All client communication received via email

## Text mining - methods and purpose

There are two ways that text mining can be applied. One of which is to look into the text that is already available within the company, in it's original form such as customer reviews by doing a sentiment or content analysis to get insights, more on this later. The second way is to first structure and clean your text data and run it through machine learning models which then also allows to use it for predictions. (St Jeor, 2020)

 **1. Content analysis**

One of the purposes of analysing text documents is to identify topics and frequent terms present in a document or corpus of document. A model can also recognise similarity between documents and words by using methods of similarity measures. To illustrate the use of content analysis in the workplace here are a few examples of its application: For research purposes by identifying the content of messages and styles of communications. Businesses and a marketing team may use content analysis to identify different type of customers based on data they have collected via survey or over the phone on an existing clientele (why did this client choose this product, what do they look for in a product before buying etc.) and look for similarities and then create clusters to identify customer personas.

 **2. Sentiment analysis**

Sentiment analysis determines the general tone of the piece of text and whether the content is rather positive, negative or neutral. The model is first trained by receiving examples of content and keywords considered positive or negative. It can then recognise and categorise reviews and other content based on sentiment. It's application is merely to analyse customer feedback on a product or service but also to do competitor analysis. Employee surveys to evaluate issues or opportunities within the company, prevent employees to leave and create an overall better environment.

 **3. Predictions**

Here are a few examples of the application of text analysis to make predictions: Police and governments collect a significant amount of data that can be analysed. "The increase in crime data recording coupled with data analytics resulted in the growth of research approaches aimed at extracting knowledge from crime records to better understand criminal behavior and ultimately prevent future crimes" (Saltos, Ginger & Haig, Ella., 2017).

In customer service for example it is common to tag customer queries ("tickets") as they come in to flag a type of issue or urgency. This can be done automatically using a machine learning operated tool to automatically tag the tickets based on keywords in an email. (MonkeyLearn, 2020)

It can be valuable to a business to use text analysis to predict customer churn - how likely is the customer to leave and when so an action can be put in place on time by the relevant team.

## Implications

Text data is unstructured by nature and requires some pre-processing before being analysed which is a similar step to other data science/analytics projects. As in any other project that involves data, there is a responsibility which comes with the collection of data, it's storage and publication and some questions need to be asked when manipulating and presenting text data as well: 

**How was the data collected?** 
Gathering data through online scraping can have some ethical and legal implications and it is always best to check the preferences of the person owning the data.

**Does the disclosure of this data cause any copyright infringement?** - Copyright Act 1968 

When mining text data that is not created nor owned by the company itself, the documents would be copied, or digitised and maybe without permission. According to the University of Queensland's research (Library Guides, 2020), "While copyright does not apply to raw data or factual information it does cover the arrangement of data within a database or the 'expression' of data eg. presentation in a table."

**Does it contain any confidential information?**
 Ensure to reflect on whether the data you are working with contains any confidential information and how to protect it while sharing insights.

## Conclusion

To sum up, there are opportunities for companies to explore more of the data they are collecting in a textual form and there is a great potential for innovation by using text analysis in the workplace. However, it is important to remain aware of the possible legal and ethical implications when manipulating, sharing, and storing the content and its findings.

## References

Grimes, S., 2007. A Brief History Of Text Analytics By Seth Grimes - Beyenetwork. [online] B-eye-network.com. Available at: <http://www.b-eye network.com/view/6311#:~:text=Text%20analytics%20first%20emerged%20in,word%20terms%20known%20as%20n%2D> [Accessed 1 June 2020]. 

Guides.library.uq.edu.au. 2020. Library Guides: Text Mining & Text Analysis: Considerations - Ethics, Copyright, Licencing, Etiquette. [online] Available at: <https://guides.library.uq.edu.au/research-techniques/text-mining-analysis/considerations> [Accessed 6 June 2020]. 

MonkeyLearn. 2020. Text Mining: The Beginner's Guide. [online] Available at: <https://monkeylearn.com/text-mining/> [Accessed 1 June 2020].

Saltos, Ginger & Haig, Ella. 2017. An Exploration of Crime Prediction Using Data Mining on Open Data. International Journal of Information Technology & Decision Making. 16. 10.1142/S0219622017500250.

St Jeor, C., 2020. 5 Real World Text Mining Examples You Can Apply To Your Data. [online] Zencos.com. Available at: <https://www.zencos.com/blog/text-mining-examples-advanced-analytics/> [Accessed 5 June 2020].