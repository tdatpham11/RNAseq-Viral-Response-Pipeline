# Load core transcriptomics libraries
library(DESeq2)
library(ggplot2)

# Load data (assuming counts.csv and metadata.csv are in data/raw/)
counts <- read.csv("../data/raw/counts.csv", row.names=1)
coldata <- read.csv("../data/raw/metadata.csv", row.names=1)

# Initialize DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = coldata,
                              design = ~ condition)

# Run the Differential Expression analysis
dds <- DESeq(dds)
res <- results(dds)

# Generate a Volcano Plot
pdf("../results/plots/volcano_plot.pdf")
plotMA(res, main="DESeq2 Results: Viral Response", ylim=c(-5,5))
dev.off()

print("Analysis complete. Results saved to results/plots/")
