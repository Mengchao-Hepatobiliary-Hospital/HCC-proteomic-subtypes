# Updating.........

# Background

Here, we provide major supplementary code used in following paper. The code involves method of "HCC proteomic subtype identification", "Simplified panel for discriminating proteomic subtypes", and "Drug sensitivity prediction model". For more details, please refer to the method section in the paper.

**Integrated multi-omics analysis revealing the universality of proteomic subtypes for Hepatocellular carcinoma precision therapy**

# Development enviroment

-   Rstudio 1.4.1106

-   R 3.6.3

-   Windows 10 Pro

**Major R packages used in analysis**

| Package     | Version | Package              | Version |
|-------------|---------|----------------------|---------|
| factoextra  | 1.0.7   | FactoMineR           | 2.4     |
| ggalluvival | 0.12.3  | ggforce              | 0.3.3   |
| ggplot2     | 3.3.6   | magrittr             | 2.0.1   |
| survival    | 3.2-10  | survminer            | 0.4.9   |
| tidyr       | 1.1.3   | ConsensusClusterPlus | 1.50.0  |
| aplot       | 0.1.6   | GSVA                 | 1.34.0  |
| ggpubr      | 0.4.0   | caret                | 6.0-86  |
| stringr     | 1.4.0   | rmarkdown            | 2.1.4   |
| Borura      | 7.0.0   |                      |         |

# Data analysis and statistics in R

-   HCC proteomic subtype identification

    -   Consensus Clustering for HCC in Liu et al.'s Proteomic Data

    -   Pathway alterations of 3 HCC proteomic subtypes in Liu et al.'s cohort

-   **Simplified panel for discriminating proteomic subtypes**

    Our cohort (n=152) and Jiang et al.'s cohort (n=101) were used as the training set for model training and parameter tuning. And Gao et al.'s cohort was used as an external independent validation set to evaluate the model performance (n=159).

    -   Feature selection

    A random sampling method was used to screen for differentially expressed proteins in three subtypes, a total of 50 replicates were performed, 40 of which reached the threshold (p value \<0.01, fold change \>1.5) that were initially selected as differentially expressed proteins. After removing the proteins with correlations higher than 0.9 with other proteins,Boruta algorithm from the Boruta R package was used to select the subtype-specifically expressed proteins.

    In the differential analysis step, two variance analysis strategies were adopted : (1) comparison between any two of three subtypes; (2) comparison between any one subtype and the other two subtypes.

    Here, two kind of feature were selected by Boruta algorithm. One is used to distinguish SIII subtypes from other subtypes, and the other is used to distinguish SI from other subtypes.

    -   Model training and validtion

    In this step, the KNN (K-Nearest Neighbors) algorithm of the caret R package was used to construct the SI discriminating panel and SIII discriminating panel, respectively. And a five-fold cross-validation was performed to further reduce the number of signatures of the discriminating panel.
