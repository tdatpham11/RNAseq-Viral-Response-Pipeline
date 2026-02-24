# RNA-seq Professional Pipeline: Synthetic Data & Visualization
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("ggrepel")) install.packages("ggrepel")

# 1. GENERATE SYNTHETIC DATA
set.seed(42)
genes <- paste0("Gene_", 1:1000)
results <- data.frame(
  gene = genes,
  log2FoldChange = rnorm(1000, mean=0, sd=1.5),
  pvalue = runif(1000, 0, 0.05)
)

# Create "Significance" column
results$padj <- p.adjust(results$pvalue, method="BH")
results$diffexpressed <- "NO"
results$diffexpressed[results$log2FoldChange > 1.0 & results$padj < 0.05] <- "UP"
results$diffexpressed[results$log2FoldChange < -1.0 & results$padj < 0.05] <- "DOWN"

# 2. CREATE PROFESSIONAL VOLCANO PLOT
p <- ggplot(data=results, aes(x=log2FoldChange, y=-log10(padj), col=diffexpressed)) +
    geom_point(alpha=0.4, size=1.5) + 
    theme_minimal() +
    scale_color_manual(values=c("blue", "grey", "red")) +
    geom_vline(xintercept=c(-1, 1), col="black", linetype="dashed") +
    geom_hline(yintercept=-log10(0.05), col="black", linetype="dashed") +
    labs(title="Differential Expression: Infected vs Control",
         subtitle="Human Lung Epithelial Cells (Synthetic Dataset)",
         x="log2(Fold Change)", y="-log10(adjusted p-value)") +
    theme(legend.title = element_blank())

# 3. SAVE THE OUTPUTS
dir.create("results/plots", recursive = TRUE)
dir.create("results/tables", recursive = TRUE)

ggsave("results/plots/volcano_plot.png", p, width=7, height=5, dpi=300)
write.csv(results[results$diffexpressed != "NO", ], "results/tables/top_DEGs.csv")

print("Pipeline Finished! Check your results/ folder.")# 1. Install pheatmap if not present
if (!require("pheatmap")) install.packages("pheatmap")
library(pheatmap)

# 2. Prepare data for heatmap (Top 20 genes by p-value)
# We sort by p-value and take the top 20
top20_genes <- results[order(results$padj), ][1:20, ]
exp_matrix <- matrix(rnorm(120, mean=5, sd=2), ncol=6) # Simulated expression
rownames(exp_matrix) <- top20_genes$gene
colnames(exp_matrix) <- c("Ctrl_1", "Ctrl_2", "Ctrl_3", "Inf_1", "Inf_2", "Inf_3")

# 3. Save the Heatmap
png("results/plots/heatmap_top20.png", width=800, height=800)
pheatmap(exp_matrix, 
         main="Top 20 Differentially Expressed Genes",
         color=colorRampPalette(c("blue", "white", "red"))(100),
         cluster_cols=TRUE, 
         show_colnames=TRUE)
dev.off()
