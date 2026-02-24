# Master Script: Volcano Plot + Heatmap
if (!require("ggplot2")) install.packages("ggplot2", repos='https://cloud.r-project.org')
if (!require("ggrepel")) install.packages("ggrepel", repos='https://cloud.r-project.org')
if (!require("pheatmap")) install.packages("pheatmap", repos='https://cloud.r-project.org')

library(ggplot2)
library(ggrepel)
library(pheatmap)

# 1. Generate Data
set.seed(42)
genes <- paste0("Gene_", 1:1000)
results <- data.frame(
  gene = genes,
  log2FoldChange = rnorm(1000, mean=0, sd=1.5),
  pvalue = runif(1000, 0, 0.05)
)
results$padj <- p.adjust(results$pvalue, method="BH")
results$diffexpressed <- "NO"
results$diffexpressed[results$log2FoldChange > 1.0 & results$padj < 0.05] <- "UP"
results$diffexpressed[results$log2FoldChange < -1.0 & results$padj < 0.05] <- "DOWN"

# 2. Save Volcano Plot
p <- ggplot(data=results, aes(x=log2FoldChange, y=-log10(padj), col=diffexpressed)) +
    geom_point(alpha=0.4, size=1.5) + 
    scale_color_manual(values=c("blue", "grey", "red")) +
    theme_minimal() +
    labs(title="Volcano Plot: Viral Stimulus")
ggsave("results/plots/volcano_plot.png", p, width=7, height=5)

# 3. Save Heatmap (Top 20 Genes)
top20 <- results[order(results$padj), ][1:20, ]
exp_matrix <- matrix(rnorm(120, mean=5, sd=2), ncol=6)
rownames(exp_matrix) <- top20$gene
colnames(exp_matrix) <- c("Ctrl_1", "Ctrl_2", "Ctrl_3", "Inf_1", "Inf_2", "Inf_3")

png("results/plots/heatmap_top20.png", width=800, height=800)
pheatmap(exp_matrix, main="Top 20 DEGs Clustering", color=colorRampPalette(c("blue", "white", "red"))(100))
dev.off()

print("All plots generated in results/plots/")
