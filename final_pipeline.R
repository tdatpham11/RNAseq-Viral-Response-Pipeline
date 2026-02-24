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

print("Pipeline Finished! Check your results/ folder.")
