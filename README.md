# barplot4GO
p-value barplot for GO/GSEA analysis. Based on ggplot2 and cowplot R packages

Input: data frame of 2 columns: First column contains the Gene Ontology / GSEA / KEGG etc. category, and the second column contains the corresponding p-value (after enrichment analysis).
The data frame should contain a header.

Example of data frame:

test.txt

GO  p-value<br>
Cell cycle  0.0004<br>
Notch1 pathway  0.00001<br>

Run as: Rscript barplot4GO.R test.txt

