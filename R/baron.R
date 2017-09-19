### DATA
# human1
h1 <- read.csv("GSM2230757_human1_umifm_counts.csv", header = T)
rownames(h1) <- h1[,1]
labels_h1 <- as.character(h1$assigned_cluster)
h1 <- h1[,4:ncol(h1)]
h1 <- t(h1)
# human2
h2 <- read.csv("GSM2230758_human2_umifm_counts.csv", header = T)
rownames(h2) <- h2[,1]
labels_h2 <- as.character(h2$assigned_cluster)
h2 <- h2[,4:ncol(h2)]
h2 <- t(h2)
# human3
h3 <- read.csv("GSM2230759_human3_umifm_counts.csv", header = T)
rownames(h3) <- h3[,1]
labels_h3 <- as.character(h3$assigned_cluster)
h3 <- h3[,4:ncol(h3)]
h3 <- t(h3)
# human4
h4 <- read.csv("GSM2230760_human4_umifm_counts.csv", header = T)
rownames(h4) <- h4[,1]
labels_h4 <- as.character(h4$assigned_cluster)
h4 <- h4[,4:ncol(h4)]
h4 <- t(h4)
# mouse1
m1 <- read.csv("GSM2230761_mouse1_umifm_counts.csv", header = T)
rownames(m1) <- m1[,1]
labels_m1 <- as.character(m1$assigned_cluster)
m1 <- m1[,4:ncol(m1)]
m1 <- t(m1)
# mouse2
m2 <- read.csv("GSM2230762_mouse2_umifm_counts.csv", header = T)
rownames(m2) <- m2[,1]
labels_m2 <- as.character(m2$assigned_cluster)
m2 <- m2[,4:ncol(m2)]
m2 <- t(m2)
# merge data
h <- cbind(h1, h2, h3, h4)
m <- cbind(m1, m2)

### ANNOTATIONS
# human
h_ann <- data.frame(
    human = c(
        rep(1, length(labels_h1)), 
        rep(2, length(labels_h2)), 
        rep(3, length(labels_h3)), 
        rep(4, length(labels_h4))
    ),
    cell_type1 = c(labels_h1, labels_h2, labels_h3, labels_h4))
rownames(h_ann) <- colnames(h)
# mouse
m_ann <- data.frame(
    mouse = c(
        rep(1, length(labels_m1)), 
        rep(2, length(labels_m2))
    ),
    cell_type1 = c(labels_m1, labels_m2))
rownames(m_ann) <- colnames(m)

### SINGLECELLEXPERIMENT
source("../utils/create_sce.R")
h_sceset <- create_sce_from_counts(h, h_ann)
m_sceset <- create_sce_from_counts(m, m_ann)
saveRDS(h_sceset, "baron-human.rds")
saveRDS(m_sceset, "baron-mouse.rds")
