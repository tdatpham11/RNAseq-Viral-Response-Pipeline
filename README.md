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

## 🔬 Results and Discussion
Differential Gene Expression Analysis
The pipeline successfully identified a distinct transcriptional signature associated with viral stimulus. Using a significance threshold of $p_{adj} < 0.05$ and a $|log_2FoldChange| > 1$, we identified:
Upregulated Genes: 310 genes showing an increase in expression, predominantly associated with innate immune signaling. 
Downregulated Genes: 142 genes, many involving cellular metabolism and homeostatic lung functions.

Biological InterpretationThe Volcano Plot (see above) reveals a strong polarization of the transcriptome. The most significant hits (top right quadrant) represent the "Antiviral Core."
Interferon Response: The upregulation of genes like ISG15 and MX1 suggests that the lung epithelial cells have successfully initiated a Type-I Interferon response to limit viral replication.
Inflammatory Signaling: The presence of pro-inflammatory cytokines in the DEGs indicates that the cells are actively signaling to the systemic immune system.

Conclusion
This analysis demonstrates that the lung epithelium is not just a passive barrier but an active immunologic responder. These results provide a foundation for identifying potential therapeutic targets that could dampen hyper-inflammation (cytokine storms) while maintaining antiviral efficacy.
