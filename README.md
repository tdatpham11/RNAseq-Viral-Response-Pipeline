# RNAseq-Viral-Response-Pipeline
End-to-end transcriptomic analysis of human lung epithelial cells post-viral infection. Features DESeq2 differential expression, GO/KEGG enrichment, and interactive Viral infections, such as Influenza or SARS-CoV-2, trigger a complex innate immune response in lung epithelial cells. This project utilizes bulk RNA-sequencing data to map the transcriptional landscape of this response.

By comparing infected vs. mock-infected samples, we aim to:

- Quantify gene expression changes using a Negative Binomial distribution model.

- Identify core antiviral modules, specifically focusing on the Interferon-Stimulated Gene (ISG) family.

- Visualize the biological pathways that are significantly enriched using Gene Ontology (GO) and KEGG databases.
## 📊 Quick Start (Reproducing the Analysis)
To run this pipeline with the built-in synthetic data:
1. Generate data: `Rscript scripts/generate_synthetic_data.R`
2. Run Analysis: `Rscript scripts/deseq2_analysis.R`

## 📈 Expected Output
The pipeline generates a **Volcano Plot** highlighting differentially expressed genes. 
Significant genes (p-adj < 0.05) are shown in red.

| Analysis Step | Output File |
| :--- | :--- |
| Normalization | `results/tables/normalized_counts.csv` |
| Statistical Testing | `results/tables/deseq2_results.csv` |
| Visualization | `results/plots/volcano_plot.pdf` |
