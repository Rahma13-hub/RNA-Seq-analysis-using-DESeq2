#needed package
library(DESeq2)
library(pheatmap)
library(RColorBrewer)
library(ggplot2)
#loading the gene expression data
count = as.matrix(read.csv("Diabetes_infection_count.csv", row.names = 1))
#loading the phenotype data
pheno = read.csv("Diabetes_infection_pheno.csv", row.names = 1)
table(pheno$CL4)
dim(count)
#visualize the data distribution using histogram plot
hist(count, col = "purple", breaks = 100)
#scaling the data using log2 transformation
hist(log2(count+1), col = "purple")
pheno = pheno[colnames(count),]
#The DESeq2 package requires the count data values to be integers
genes = row.names(count)
count = apply(count, 2,as.integer)
#restore gene names
row.names(count) = genes
head(count)
#perform the differential expression analysis using DeSeq2
#specify how many conditions do i want to compare according to the phenotypic table
con.1 = "Infection"
con.2 = "Healthy"
#create the DESeq2 object
des = DESeqDataSetFromMatrix(countData = count, colData = pheno, design = ~ CL4)
#run the DESeq2 workflow
des.run = DESeq(des)
#specify the contrast
res = results(des.run, contrast = c("CL4", "Infection", "Healthy"))
# remove nulls and convert the data set to a data frame
res = as.data.frame(res[complete.cases(res), ])
#chose the statistical significant DEGs based
#on the p adjusted value less than 0.05 and biological significance  based
#on the fold change more than 2
deseq.deg = res[res$padj < 0.05 & abs(res$log2FoldChange) > log2(2),]
#export the Degs
write.csv(as.matrix(deseq.deg), file = "deseq.deg.csv", quote = F, row.names = T)
#Extract the normalized counts
normalized.counts = counts(des.run, normalized = TRUE)
write.csv(as.data.frame(normalized.counts), file = "normalized.count.csv", quote = F)
#load the more important genes
degs = rownames(deseq.deg)
#filter the normalized counts of the important genes
degs.counts = normalized.counts[degs, ]
# visualize the data using heat map
pheno = pheno[colnames(degs.counts), ,
              drop = FALSE]
pheno$group = factor(pheno$CL4)
ann.colors = list(
  group = c("Healthy" = "steelblue", "Infection" = "firebrick3"))
pheatmap(log2(degs.counts + 1),
         annotation_col = pheno["group"],
         annotation_colors = ann.colors,
         cluster_cols = TRUE,
         cluster_rows = TRUE,
         show_colnames = FALSE,
         show_rownames = TRUE,
         fontsize_row = 6,
         main = "Heatmap of DEGs")
# Add significance label
res$significant = ifelse(res$padj < 0.05 & abs(res$log2FoldChange) > log2(2),
                         "significant", "not significant")

# Calculate -log10 adjusted p-values
res$logP = -log10(res$padj)

# Draw Volcano plot
ggplot(res, aes(x = log2FoldChange, y = logP)) +
  geom_point(aes(color = significant), alpha = 0.8) +
  scale_color_manual(values = c("significant" = "red", "not significant" = "grey")) +
  geom_vline(xintercept = c(-log2(2), log2(2)), linetype = "dashed", color = "blue") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "blue") +
  labs(title = "Volcano Plot", x = "log2 Fold Change", y = "-log10 Adjusted P-value") +
  theme_minimal()
