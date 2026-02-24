# Generate synthetic RNA-seq data for demonstration
set.seed(123)

# 1. Create Metadata
metadata <- data.frame(
  sample = paste0("Sample_", 1:6),
  condition = c(rep("control", 3), rep("infected", 3))
)
row.names(metadata) <- metadata$sample
write.csv(metadata, "data/raw/metadata.csv")

# 2. Create Count Matrix (1000 genes x 6 samples)
# We simulate higher counts in 'infected' for the first 50 genes
genes <- paste0("Gene_", 1:1000)
counts <- matrix(rnbinom(6000, mu=100, size=1), ncol=6)
counts[1:50, 4:6] <- counts[1:50, 4:6] * 5  # Simulate up-regulation

colnames(counts) <- metadata$sample
rownames(counts) <- genes
write.csv(counts, "data/raw/counts.csv")

print("Synthetic data generated in data/raw/")
