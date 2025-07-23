# RNA-seq Analysis of Gene Expression in Diabetic Patients With and Without Infection
This repository contains an RNA-seq differential expression analysis conducted using the DESeq2 package in R. The dataset includes gene expression count data from diabetic patients, divided into two groups: patients with infection and healthy diabetic individuals.
## Project Overview
#Goal: The purpose of this analysis is to identify differentially expressed genes (DEGs) based on the infection status in people with diabetes, visualize the expression patterns using heatmaps and volcano plots, and do pathway enrichment analysis on g:Profiler.
#Dataset Description
- Count matrix: Diabetes_infection_count.csv (raw counts)
- Phenotype metadata: Diabetes_infection_pheno.csv
- Two groups:
  - Infection: Diabetic patients with infection
  - Healthy: Diabetic patients without infection
#Tools and Packages
- DESeq2
- ggplot2
- pheatmap
- g:Profiler
# Analysis Workflow
1. Data loading and preprocessing
2. Differential gene expression analysis using DESeq2
3. Visualization:
   - Heatmap of top DEGs
   - Volcano plot
4. Functional enrichment analysis using g Profiler
# Output Files
- deseq.deg.csv: Table of significant DEGs
- normalized.count.csv: Normalized expression values
- gene_list.txt: List of top expressed genes used in g profiler
- heatmap.png: Heatmap visualization of DEGs
- volcano.png: Volcano plot of the tested genes
- gprofiler.png: Screenshot of functional enrichment results
## R Script
The entire analysis pipeline is included in this file: 
# Key Enriched Biological Themes:
| Term                     | Description                                                                 |
|--------------------------|-----------------------------------------------------------------------------|
| Cytokine-Mediated Signaling Pathway     | Involved in immune communication and inflammation. |
| Response to Stress       | Reflects cellular response to infection-induced physiological stress.  |
| Chemokine Activity       | Chemokines guide immune cells to infection sites.            |
| Receptor Regulator Activity  | Modulates immune receptor signaling to maintain balance.              |
| Positive Regulation of Immune Response | Suggests heightened immune activation in infected diabetic individuals.   |
# Conclusion
The enrichment analysis indicated important immune and inflammatory reactions engaged by diabetic patients when infected. Pathways associated with chemokine signaling, stress adaptation, and receptor-based immune recognition were significantly enriched, suggesting a strong, but potentially dysregulated host defense response. These findings provide insight into the molecular basis for increased infection susceptibility in diabetes.
# connect 
This project is part of my bioinformatics learning journey and academic portfolio.  
Feel free to explore, share feedback, or reach out for collaboration or discussion.
 [LinkedIn – Rahma Reda](http://www.linkedin.com/in/rahma-reda-2269a236b)
