#### AT3 - Anatomy of document 1 ####

# Load libraries 
library(tm) 
library(SnowballC)
library(wordcloud)
library(readtext)
library(quanteda)
library(ggplot2)
library(topicmodels)
library(dplyr)
library(cluster)

# Set working directory
setwd("~/UTS/Data, Algorithms and Meaning/AT3")

# Clean environment
rm(list = ls())

# Load corpus
docs <- VCorpus(DirSource("./docs"))


##### Beginning of preprocessing ####

#Remove punctuation - replace punctuation marks with " " - (keeping punctuation only changes topic of doc 34)
docs <- tm_map(docs, removePunctuation)
#Transform to lower case
docs <- tm_map(docs,content_transformer(tolower))
#Strip digits
docs <- tm_map(docs, removeNumbers)
#Remove stopwords from standard stopword list 
docs <- tm_map(docs, removeWords, c(stopwords("english"),"can", "will", "use", "one"))
#Strip whitespace (cosmetic?)
docs <- tm_map(docs, stripWhitespace)
#inspect output
writeLines(as.character(docs[[1]]))

# Stem all docs
docs <- tm_map(docs,stemDocument)
#inspect
writeLines(as.character(docs[[1]]))

#Create document-term matrix
dtm <- DocumentTermMatrix(docs)
dtm

# Export extract of DTM
dtm_export <- inspect(dtm[1:10,3180:3190])
write.csv(dtm_export,file=paste("document_term_matrix.csv"))

##### end of preprocessing

#### Identify topics using LDA #####

# Set parameterers for LDA model, parameter tuning:
burnin <- 1000
iter <- 2000 # run 2000 iterations
thin <- 500 # Thinning is done to ensure that samples are not correlated.
nstart <- 5 # 5 different randomly chosen starting points
seed <- list(2003,5,63,100001,765) # set seed for each start for reproducibility
best <- TRUE # keep the best run (highest probability) as final result
k <- 5 #  Number of topics (tried 4 and 6, 5 seems most accurate and best split after looking at probabilities)


# LDA model + "Gibbs" sampling method 
ldaOut <- LDA(dtm,k, method="Gibbs", control=
                list(nstart=nstart, seed = seed, best=best, burnin = burnin, iter = iter, thin=thin))


# View topics for each doc (model result), save results as matrix, export matrix as csv
topics(ldaOut)

ldaOut.topics <- as.matrix(topics(ldaOut)) 
docs_corp <- corpus(docs)
write.csv(ldaOut.topics,file=paste("LDAGibbs",k,"DocsToTopics.csv"))

# View 10 most frequent terms per topic, save as matrix, export matrix as csv
terms(ldaOut,10)
ldaOut.terms <- as.matrix(terms(ldaOut,10))
write.csv(ldaOut.terms,file=paste("LDAGibbs",k,"TopicsToTerms.csv", sep="_"))

# Look up collocation for each topic and use combination of most common words to define theme using Quanteda package
textstat_collocations(docs_corp[35:41]) # Topic 1 - "Probability Distribution Completion Time"
textstat_collocations(docs_corp[11:17]) # Topic 2 - "Issue mapping"
textstat_collocations(docs_corp[c(23:29,31:33)]) # Topic 3 - "Project Management Best Practice"
textstat_collocations(docs_corp[c(18:22,42)]) # Topic 4 - "Machine learning - Text mining"
textstat_collocations(docs_corp[c(1:10, 30, 34)]) # Topic 5 - "Risk Management"

# Find probabilities associated with each topic assignment 
topicProbabilities <- as.data.frame(ldaOut@gamma) 
write.csv(file="topicProbabilities.csv",topicProbabilities)

##### Using cosine as distance measure to create clusters and plot Dendrogram ####
#### Adding this step to confirm 5 is a good amount of topics.

#convert dtm to matrix 
m <- as.matrix(dtm)

#compute distance between document vectors
d <- dist(m)

# Using cosine as distance measure
cosineSim <- function(x){
  as.dist(x%*%t(x)/(sqrt(rowSums(x^2) %*% t(rowSums(x^2)))))
}
cs <- cosineSim(m)
cd <- 1-cs

# run hierarchical clustering using cosine distance
groups <- hclust(cd,method="ward.D")

#plot
plot(groups, hang=-1)
# cut into 6 subtrees, plot cluster dendrogram
rect.hclust(groups,5)
hclusters_cosine <- cutree(groups,5)

write.csv(hclusters_cosine,"hclusters_cosine.csv")

# Clusterplot
kfit <- kmeans(cd, 5, nstart=100)
clusplot(as.matrix(cd), kfit$cluster, color=T, shade=T, labels=2, lines=0)


# Cosine method and LDA model provide almost similar results except for the classification of 5 documents: doc_5, doc_15, doc_30, doc_34, doc_36, doc_37

#### Corpus visualisations - Add weight to analyse most frequent/most important words in full corpus and produce graphs ####

#### Add weight ####
dtm_tfidf <- DocumentTermMatrix(docs,control = list(weighting = weightTfIdf))

#summary
dtm_tfidf

#inspect segment of document term matrix
inspect(dtm_tfidf[1:10,3180:3190])

#collapse matrix by summing over columns - to get total weights (over all docs) for each term
wt_tot_tfidf <- colSums(as.matrix(dtm_tfidf))

# length = total number of terms - 4318
length(wt_tot_tfidf)

#create sort order (asc)
ord_tfidf <- order(wt_tot_tfidf,decreasing=TRUE)

#inspect most frequently occurring terms
wt_tot_tfidf[head(ord_tfidf)]
# write.csv(file="wt_tot_tfidf.csv",wt_tot_tfidf[ord_tfidf])

# Create histogram
wf=data.frame(term=names(wt_tot_tfidf),weights=wt_tot_tfidf)


# Plot histogram
hist <- ggplot(subset(wf, wt_tot_tfidf>.15), aes(reorder(term,weights), weights)) + geom_bar(stat="identity") + theme(axis.text.x=element_text(angle=45, hjust=1))

hist

# Wordcloud - Set seed for reproducibiilty
set.seed(42)

# limit words by specifying min total wt
wordcloud(names(wt_tot_tfidf),wt_tot_tfidf, max.words=100, colors=brewer.pal(6,"Dark2"))

#### Explore further using Quanteda, organise and rename documents ####
# transform to corpus for Quanteda - docs is already pre-processed
docs_corp <- corpus(docs)

# Assign names to each topic to create subfolder
topicNames <- dictionary(list(
                              "1" = "Probability Distribution Completion Time",
                              "2" = "Issue mapping",
                              "3" = "Project Management Best Practice",
                              "4" = "Machine learning - Text mining",
                              "5" = "Risk Management"))

dir.create("Documents") # Create folder
for (topicNumber in  unique(ldaOut.topics[,1])) {
  dir.create(paste("Documents/", topicNames[[as.character(topicNumber)]], sep = ""))
}
docMap <- data.frame(key=rownames(ldaOut.topics), value=ldaOut.topics, row.names=NULL) # transform to dataframe to grab name of column

# Identify 4 words - 2 combinations of 2 words in each doc - to be used to rename each document. 
# Used 4 because of duplicate combinations for only 2 words (Ex. "Risk management" appeared multiple times)
# View combination of words for doc 1:
textstat_collocations(docs_corp[1]) # "risk management holt suggest"

# For loop to create a subfolder for each topic and copy doc allocated to each topic + rename using the top 4 word combinations 
for (i in 1:nrow(docMap)) {
  subdir <- paste("Documents/", topicNames[[as.character(docMap[i, "value"])]], sep = "")
  possible_names <- arrange(textstat_collocations(docs_corp[i]), desc(count))
  name <- paste(trimws(paste(possible_names[1,1], possible_names[2,1])), ".txt", sep = "")
  file.copy(from = paste("docs/", docMap[i, "key"], sep = ""), to = subdir)
  file.rename(from = file.path(subdir,  docMap[i, "key"]), to = file.path(subdir, name))
  print(paste(i, name))
}


