# ============================================================
#  ELEVATOR SIMULATION — STATISTICAL ANALYSIS IN R
#  NetLogo BehaviorSpace Results (450 runs)
#  Factors: demand (low/medium/high) x policy (FCFS/Priority-based/Zone batching)
#  Replicates per cell: 50
# ============================================================

# ── 0. INSTALL & LOAD PACKAGES ─────────────────────────────
# Run this block once if packages are not yet installed:
# install.packages(c("tidyverse", "car", "rstatix", "emmeans",
#                    "ggplot2", "corrplot", "ggcorrplot",
#                    "dunn.test", "lsr", "knitr"))

library(tidyverse)    # data wrangling + ggplot2
library(car)          # Levene test, Anova()
library(rstatix)      # pipe-friendly stat tests
library(emmeans)      # post-hoc comparisons
library(corrplot)     # correlation matrix plots
library(ggcorrplot)   # ggplot-style correlation plots
library(dunn.test)    # Kruskal-Wallis post-hoc (Dunn)
library(lsr)          # eta-squared effect sizes

# ── 1. LOAD DATA ───────────────────────────────────────────
# OPTION A: Use the pre-cleaned CSV (already done for you)
df <- read.csv("elevator_clean.csv")

# OPTION B: Raw NetLogo file — skip rows, parse manually
# (The CSV above is already the clean version derived from elevator_results.csv)

# Set factor levels
df$demand <- factor(df$demand, levels = c("low", "medium", "high"))
df$policy <- factor(df$policy, levels = c("FCFS", "Priority-based", "Zone batching"))

# Define outcome variables
outcomes <- c("avg_wait_time", "avg_journey_time", "stair_switch_rate",
              "elevator_utilization", "avg_student_wait", "avg_faculty_wait",
              "avg_staff_wait", "equity_student_faculty", "equity_student_staff")

cat("=== DATA OVERVIEW ===\n")
cat("Rows:", nrow(df), "| Cols:", ncol(df), "\n")
cat("Runs per demand level:\n"); print(table(df$demand))
cat("Runs per policy:\n"); print(table(df$policy))
cat("Runs per cell (demand x policy):\n"); print(table(df$demand, df$policy))


# ── 2. DESCRIPTIVE STATISTICS ──────────────────────────────
cat("\n=== DESCRIPTIVE STATISTICS ===\n")

desc_stats <- df %>%
  group_by(demand, policy) %>%
  summarise(across(all_of(outcomes),
                   list(mean = mean, sd = sd, median = median),
                   .names = "{.col}__{.fn}"),
            .groups = "drop")

# Readable table: just avg_wait_time as example
df %>%
  group_by(demand, policy) %>%
  summarise(
    n        = n(),
    mean_wait = round(mean(avg_wait_time), 2),
    sd_wait   = round(sd(avg_wait_time), 2),
    mean_util = round(mean(elevator_utilization), 3),
    mean_equity_sf = round(mean(equity_student_faculty), 3),
    .groups = "drop"
  ) %>%
  print()


# ── 3. NORMALITY CHECKS ────────────────────────────────────
# Shapiro-Wilk per group (small sample version)
# Note: with n=50 per cell, S-W is the correct choice.
cat("\n=== SHAPIRO-WILK NORMALITY TEST (per group) ===\n")
normality_results <- df %>%
  group_by(demand, policy) %>%
  summarise(
    across(all_of(outcomes),
           ~ shapiro.test(.x)$p.value,
           .names = "{.col}_p"),
    .groups = "drop"
  )
print(normality_results)
# If p > 0.05 → data is approximately normal (parametric tests OK)
# If p < 0.05 → non-normal → use Kruskal-Wallis instead of ANOVA


# ── 4. HOMOGENEITY OF VARIANCE (Levene's Test) ─────────────
cat("\n=== LEVENE'S TEST FOR HOMOGENEITY OF VARIANCES ===\n")
for (var in outcomes) {
  lev <- leveneTest(as.formula(paste(var, "~ demand * policy")), data = df)
  cat(sprintf("%-30s F=%.3f, p=%.4f %s\n",
              var, lev$`F value`[1], lev$`Pr(>F)`[1],
              ifelse(lev$`Pr(>F)`[1] < 0.05, "** VIOLATION", "OK")))
}
# If violated: use Welch's correction or non-parametric alternative


# ── 5. TWO-WAY ANOVA: demand × policy ─────────────────────
# Tests: main effect of demand, main effect of policy, interaction
cat("\n=== TWO-WAY ANOVA RESULTS ===\n")

anova_results <- list()
for (var in outcomes) {
  model <- aov(as.formula(paste(var, "~ demand * policy")), data = df)
  anova_results[[var]] <- summary(model)
  cat("\n--- Outcome:", var, "---\n")
  print(summary(model))

  # Eta-squared (effect size)
  eta <- etaSquared(model)
  cat("Eta-squared:\n"); print(round(eta, 4))
}
# INTERPRETATION:
#   p < 0.05 for 'demand'   → demand level significantly affects this outcome
#   p < 0.05 for 'policy'   → scheduling policy significantly affects this outcome
#   p < 0.05 for 'demand:policy' → the effect of policy DEPENDS on demand level (interaction)
#   Eta-squared: 0.01=small, 0.06=medium, 0.14=large effect


# ── 6. POST-HOC TESTS (if ANOVA is significant) ───────────
# Using Tukey HSD — controls familywise error rate
cat("\n=== TUKEY POST-HOC TESTS ===\n")

# Example: avg_wait_time post-hoc
model_wait <- aov(avg_wait_time ~ demand * policy, data = df)
em_demand <- emmeans(model_wait, ~ demand)
em_policy <- emmeans(model_wait, ~ policy)
em_interaction <- emmeans(model_wait, ~ demand | policy)

cat("--- avg_wait_time: demand post-hoc ---\n")
print(pairs(em_demand, adjust = "tukey"))

cat("\n--- avg_wait_time: policy post-hoc ---\n")
print(pairs(em_policy, adjust = "tukey"))

cat("\n--- avg_wait_time: policy within each demand level ---\n")
print(pairs(em_interaction, adjust = "tukey"))

# Repeat for other key outcomes:
for (var in c("avg_journey_time", "elevator_utilization",
              "equity_student_faculty", "equity_student_staff")) {
  m <- aov(as.formula(paste(var, "~ demand * policy")), data = df)
  em_p <- emmeans(m, ~ policy)
  em_d <- emmeans(m, ~ demand)
  cat(sprintf("\n--- %s: policy post-hoc ---\n", var))
  print(pairs(em_p, adjust = "tukey"))
  cat(sprintf("\n--- %s: demand post-hoc ---\n", var))
  print(pairs(em_d, adjust = "tukey"))
}


# ── 7. NON-PARAMETRIC ALTERNATIVE (if normality violated) ──
cat("\n=== KRUSKAL-WALLIS (non-parametric ANOVA alternative) ===\n")
# Test each outcome by policy and by demand separately

for (var in outcomes) {
  kw_demand <- kruskal.test(as.formula(paste(var, "~ demand")), data = df)
  kw_policy <- kruskal.test(as.formula(paste(var, "~ policy")), data = df)
  cat(sprintf("%-30s  demand: χ²=%.3f, p=%.4f | policy: χ²=%.3f, p=%.4f\n",
              var,
              kw_demand$statistic, kw_demand$p.value,
              kw_policy$statistic, kw_policy$p.value))
}

# Dunn test for pairwise comparisons after significant Kruskal-Wallis
cat("\n--- Dunn post-hoc: avg_wait_time by policy ---\n")
dunn.test(df$avg_wait_time, df$policy, method = "bonferroni")


# ── 8. CORRELATION ANALYSIS ────────────────────────────────
cat("\n=== PEARSON CORRELATION MATRIX (all runs) ===\n")
cor_data <- df[, outcomes]
cor_matrix <- cor(cor_data, method = "pearson")
print(round(cor_matrix, 3))

# Test significance of correlations
cor_test_results <- cor.mtest(cor_data, conf.level = 0.95)

# Visualize
png("correlation_matrix.png", width = 800, height = 700)
corrplot(cor_matrix,
         method = "color",
         type = "upper",
         tl.col = "black",
         tl.srt = 45,
         addCoef.col = "black",
         number.cex = 0.7,
         p.mat = cor_test_results$p,
         sig.level = 0.05,
         insig = "blank",
         title = "Correlation Matrix — Elevator Simulation Outcomes",
         mar = c(0,0,2,0))
dev.off()
cat("Saved: correlation_matrix.png\n")

# Key correlations to interpret:
# avg_wait_time ↔ elevator_utilization: does higher utilization = longer waits?
# equity_student_faculty ↔ policy: which policy produces more equitable service?
# stair_switch_rate ↔ avg_wait_time: do longer waits push people to use stairs?


# ── 9. VISUALIZATIONS ─────────────────────────────────────

# 9a. Boxplots: wait time by policy and demand
p1 <- ggplot(df, aes(x = policy, y = avg_wait_time, fill = demand)) +
  geom_boxplot(alpha = 0.7, outlier.size = 1.2) +
  scale_fill_manual(values = c("low" = "#4CAF50", "medium" = "#FF9800", "high" = "#F44336")) +
  labs(title = "Average Wait Time by Policy and Demand Level",
       x = "Scheduling Policy", y = "Average Wait Time (ticks)",
       fill = "Demand Level") +
  theme_bw(base_size = 13) +
  theme(axis.text.x = element_text(angle = 15, hjust = 1))
ggsave("boxplot_wait_time.png", p1, width = 8, height = 5, dpi = 150)
cat("Saved: boxplot_wait_time.png\n")

# 9b. Boxplots: elevator utilization
p2 <- ggplot(df, aes(x = policy, y = elevator_utilization, fill = demand)) +
  geom_boxplot(alpha = 0.7, outlier.size = 1.2) +
  scale_fill_manual(values = c("low" = "#4CAF50", "medium" = "#FF9800", "high" = "#F44336")) +
  labs(title = "Elevator Utilization by Policy and Demand Level",
       x = "Scheduling Policy", y = "Elevator Utilization (proportion)",
       fill = "Demand Level") +
  theme_bw(base_size = 13) +
  theme(axis.text.x = element_text(angle = 15, hjust = 1))
ggsave("boxplot_utilization.png", p2, width = 8, height = 5, dpi = 150)

# 9c. Equity comparison: student vs faculty, student vs staff
df_equity <- df %>%
  pivot_longer(cols = c(equity_student_faculty, equity_student_staff),
               names_to = "equity_type", values_to = "equity_ratio") %>%
  mutate(equity_type = recode(equity_type,
                              equity_student_faculty = "Student/Faculty",
                              equity_student_staff   = "Student/Staff"))

p3 <- ggplot(df_equity, aes(x = policy, y = equity_ratio, fill = demand)) +
  geom_boxplot(alpha = 0.7, outlier.size = 1) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "red", linewidth = 0.8) +
  facet_wrap(~ equity_type) +
  scale_fill_manual(values = c("low" = "#4CAF50", "medium" = "#FF9800", "high" = "#F44336")) +
  labs(title = "Equity Ratios by Policy (red line = perfect equity)",
       x = "Scheduling Policy", y = "Wait Time Ratio (closer to 1 = more equitable)",
       fill = "Demand") +
  theme_bw(base_size = 12) +
  theme(axis.text.x = element_text(angle = 15, hjust = 1))
ggsave("boxplot_equity.png", p3, width = 10, height = 5, dpi = 150)
cat("Saved: boxplot_equity.png\n")

# 9d. Interaction plot (means)
p4 <- df %>%
  group_by(demand, policy) %>%
  summarise(mean_wait = mean(avg_wait_time), .groups = "drop") %>%
  ggplot(aes(x = demand, y = mean_wait, color = policy, group = policy)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  labs(title = "Interaction Plot: Demand × Policy → Mean Wait Time",
       x = "Demand Level", y = "Mean Average Wait Time",
       color = "Policy") +
  theme_bw(base_size = 13)
ggsave("interaction_wait.png", p4, width = 7, height = 5, dpi = 150)
cat("Saved: interaction_wait.png\n")

# 9e. All outcomes grouped by policy (mean ± SE)
p5 <- df %>%
  group_by(policy) %>%
  summarise(across(all_of(outcomes), list(mean = mean, se = ~sd(.)/sqrt(n())))) %>%
  pivot_longer(-policy, names_to = c("variable", "stat"), names_sep = "__") %>%
  pivot_wider(names_from = stat, values_from = value) %>%
  filter(variable %in% c("avg_wait_time", "avg_journey_time",
                          "stair_switch_rate", "elevator_utilization")) %>%
  ggplot(aes(x = policy, y = mean, fill = policy)) +
  geom_col(alpha = 0.8) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.3) +
  facet_wrap(~ variable, scales = "free_y") +
  labs(title = "Key Outcomes by Scheduling Policy (mean ± SE)",
       x = NULL, y = "Mean Value") +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 20, hjust = 1),
        legend.position = "none")
ggsave("outcomes_by_policy.png", p5, width = 10, height = 7, dpi = 150)
cat("Saved: outcomes_by_policy.png\n")


# ── 10. SUMMARY TABLE FOR REPORT ───────────────────────────
cat("\n=== FINAL SUMMARY: Mean outcomes per policy (all demands combined) ===\n")
df %>%
  group_by(policy) %>%
  summarise(
    n = n(),
    avg_wait      = round(mean(avg_wait_time), 2),
    avg_journey   = round(mean(avg_journey_time), 2),
    stair_rate    = round(mean(stair_switch_rate), 3),
    utilization   = round(mean(elevator_utilization), 3),
    equity_sf     = round(mean(equity_student_faculty), 3),
    equity_ss     = round(mean(equity_student_staff), 3),
    .groups = "drop"
  ) %>% print()

cat("\n=== FINAL SUMMARY: Mean outcomes per demand level (all policies combined) ===\n")
df %>%
  group_by(demand) %>%
  summarise(
    n = n(),
    avg_wait    = round(mean(avg_wait_time), 2),
    avg_journey = round(mean(avg_journey_time), 2),
    utilization = round(mean(elevator_utilization), 3),
    stair_rate  = round(mean(stair_switch_rate), 3),
    .groups = "drop"
  ) %>% print()

cat("\n=== ANALYSIS COMPLETE ===\n")
cat("Output files:\n")
cat("  correlation_matrix.png\n")
cat("  boxplot_wait_time.png\n")
cat("  boxplot_utilization.png\n")
cat("  boxplot_equity.png\n")
cat("  interaction_wait.png\n")
cat("  outcomes_by_policy.png\n")
