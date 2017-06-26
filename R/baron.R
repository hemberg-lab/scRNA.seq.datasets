library(scater)

# load data
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

# create scater objects
# human
ann <- data.frame(
    human = c(
        rep(1, length(labels_h1)), 
        rep(2, length(labels_h2)), 
        rep(3, length(labels_h3)), 
        rep(4, length(labels_h4))
    ),
    cell_type1 = c(labels_h1, labels_h2, labels_h3, labels_h4))
rownames(ann) <- colnames(h)
pd <- new("AnnotatedDataFrame", data = ann)
h_sceset <- newSCESet(countData = h, phenoData = pd)
h_sceset <- calculateQCMetrics(h_sceset)

# use gene names as feature symbols
fData(h_sceset)$feature_symbol <- featureNames(h_sceset)

# remove features with duplicated names
h_sceset <- h_sceset[!duplicated(fData(h_sceset)$feature_symbol), ]

# mouse
ann <- data.frame(
    mouse = c(
        rep(1, length(labels_m1)), 
        rep(2, length(labels_m2))
    ),
    cell_type1 = c(labels_m1, labels_m2))
rownames(ann) <- colnames(m)
pd <- new("AnnotatedDataFrame", data = ann)
m_sceset <- newSCESet(countData = m, phenoData = pd)
m_sceset <- calculateQCMetrics(m_sceset)

# use gene names as feature symbols
fData(m_sceset)$feature_symbol <- featureNames(m_sceset)

# remove features with duplicated names
m_sceset <- m_sceset[!duplicated(fData(m_sceset)$feature_symbol), ]

# save data
saveRDS(h_sceset, "baron-human.rds")
saveRDS(m_sceset, "baron-mouse.rds")

