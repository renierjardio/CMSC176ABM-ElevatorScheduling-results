# Results and Discussion

## 1. Preliminary Analyses

### 1.1 Descriptive Statistics

A total of 450 simulation runs were completed across the 3 × 3 fully crossed factorial design (3 scheduling policies × 3 demand levels × 50 replications per cell). All 450 runs reached the 10,800-tick endpoint. Table 1 presents the mean and standard deviation of all outcome variables per treatment cell, derived directly from the NetLogo BehaviorSpace output.

**Table 1. Descriptive Statistics by Scheduling Policy and Demand Level (n = 50 per cell)**

| Policy | Demand | Avg Wait (M ± SD) | Avg Journey (M ± SD) | Stair Rate (M ± SD) | Elev. Util. (M ± SD) | Equity S/F (M ± SD) | Equity S/S (M ± SD) |
|---|---|---|---|---|---|---|---|
| FCFS | Low | 26.59 ± 2.21 | 47.82 ± 2.72 | 0.032 ± 0.018 | 0.254 ± 0.017 | 1.536 ± 0.318 | 1.304 ± 0.180 |
| FCFS | Medium | 34.53 ± 1.74 | 62.06 ± 2.31 | 0.040 ± 0.014 | 0.332 ± 0.019 | 1.547 ± 0.180 | 1.295 ± 0.133 |
| FCFS | High | 42.09 ± 1.37 | 74.96 ± 1.78 | 0.087 ± 0.013 | 0.386 ± 0.014 | 1.753 ± 0.126 | 1.343 ± 0.095 |
| Priority-based | Low | 37.88 ± 5.18 | 59.17 ± 5.92 | 0.163 ± 0.068 | 0.222 ± 0.027 | 0.993 ± 0.221 | 1.240 ± 0.182 |
| Priority-based | Medium | 47.44 ± 5.19 | 74.76 ± 6.27 | 0.212 ± 0.086 | 0.300 ± 0.030 | 1.083 ± 0.124 | 1.115 ± 0.139 |
| Priority-based | High | 53.33 ± 4.53 | 85.22 ± 5.65 | 0.242 ± 0.092 | 0.363 ± 0.033 | 1.199 ± 0.088 | 0.949 ± 0.081 |
| Zone Batching | Low | 35.94 ± 4.84 | 56.83 ± 5.83 | 0.143 ± 0.058 | 0.230 ± 0.021 | 0.983 ± 0.211 | 1.260 ± 0.244 |
| Zone Batching | Medium | 47.80 ± 5.95 | 75.24 ± 7.29 | 0.224 ± 0.095 | 0.298 ± 0.034 | 1.064 ± 0.123 | 1.113 ± 0.141 |
| Zone Batching | High | 55.16 ± 6.01 | 87.73 ± 7.57 | 0.280 ± 0.120 | 0.357 ± 0.044 | 1.221 ± 0.091 | 0.945 ± 0.091 |

*Notes: Avg Wait and Avg Journey are in simulation ticks (1 tick = 1 second). Stair Rate is proportion of agents who defected to stairs. Elev. Util. is proportion of ticks with elevator in motion carrying passengers. Equity S/F = student-to-faculty wait ratio; Equity S/S = student-to-staff wait ratio. Values closer to 1.0 on equity ratios indicate equitable service.*

Inspection of Table 1 reveals several immediately notable patterns. FCFS consistently produced the lowest mean average wait times across all demand levels, while Priority-based and Zone Batching produced nearly identical mean wait times at medium and high demand. The standard deviations under FCFS were markedly smaller than those under the other two policies (e.g., SD = 1.37 vs. 4.53–6.01 ticks at high demand), indicating that FCFS produces more predictable outcomes run-to-run. By contrast, Priority-based and Zone Batching exhibited considerably greater stochastic variability, reflecting their sensitivity to the stochastic clustering of passenger arrivals relative to zone boundaries and priority queues. All policies saw monotonically increasing wait times as demand escalated from low to high, consistent with theoretical expectations from queuing theory.

### 1.2 Normality Assessment

Shapiro-Wilk tests were conducted on each outcome variable within each of the nine treatment cells (n = 50 per cell). Results indicated violations of normality in multiple cells for avg_wait_time (5 of 9 cells non-normal, W ranging from 0.769 to 0.972), avg_journey_time (5 of 9 cells), stair_switch_rate (8 of 9 cells), elevator_utilization (2 of 9 cells), and equity_student_faculty (3 of 9 cells). Non-normality was concentrated in cells involving Priority-based and Zone Batching policies, particularly at medium and high demand, consistent with the high within-condition variance observed in Table 1. Equity_student_staff was the only outcome variable that was normally distributed across all nine cells.

Given these widespread departures from normality, all inferential tests comparing scheduling policies were conducted using the **Kruskal-Wallis H test** — the non-parametric equivalent of one-way ANOVA — followed by **Mann-Whitney U pairwise post-hoc tests with Bonferroni correction** (α = 0.05/3 = 0.0167 per comparison). Effect sizes are reported as η² derived from H: η² = (H − k + 1) / (n − k), where k = 3 policy groups and n is the total number of observations within a demand stratum. Levene's test for homogeneity of variance was used to supplement the normality assessment where relevant.

---

## 2. Primary Research Question: Effect of Scheduling Policy on Wait Time, Utilization, and Equity

### 2.1 Research Question 1: Scheduling Policy and Average Passenger Wait Time

The primary research question asked how scheduling policy affected average passenger wait time. Kruskal-Wallis tests revealed a statistically significant effect of scheduling policy on average wait time at all three demand levels: low demand (H = 95.04, p < .001, η² = 0.633), medium demand (H = 99.34, p < .001, η² = 0.662), and high demand (H = 100.48, p < .001, η² = 0.670). All effect sizes were large by conventional benchmarks (η² ≥ 0.14), indicating that the choice of scheduling policy was by far the dominant driver of wait time variability within each demand stratum.

**Table 2. Kruskal-Wallis Results: Effect of Policy on Average Wait Time**

| Demand Level | H statistic | p-value | η² | Interpretation |
|---|---|---|---|---|
| Low | 95.04 | < .001 | 0.633 | Large effect |
| Medium | 99.34 | < .001 | 0.662 | Large effect |
| High | 100.48 | < .001 | 0.670 | Large effect |

**Post-hoc comparisons** using Mann-Whitney U with Bonferroni correction revealed the structure of these differences. At all three demand levels, FCFS was significantly faster than both Priority-based (p_adj < .001 at low, medium, and high demand) and Zone Batching (p_adj < .001 at all levels). Critically, Priority-based and Zone Batching did not differ significantly from each other at any demand level (low: p_adj = 0.140; medium: p_adj = 1.000; high: p_adj = 0.332), indicating that these two policies perform equivalently in terms of overall average wait time despite their structural differences.

**Table 3. Pairwise Post-hoc Comparisons: Average Wait Time (Bonferroni-corrected)**

| Demand | Comparison | M₁ | M₂ | p_adj | Significant? |
|---|---|---|---|---|---|
| Low | FCFS vs Priority-based | 26.59 | 37.88 | < .001 | *** |
| Low | FCFS vs Zone Batching | 26.59 | 35.94 | < .001 | *** |
| Low | Priority-based vs Zone Batching | 37.88 | 35.94 | 0.140 | ns |
| Medium | FCFS vs Priority-based | 34.53 | 47.44 | < .001 | *** |
| Medium | FCFS vs Zone Batching | 34.53 | 47.80 | < .001 | *** |
| Medium | Priority-based vs Zone Batching | 47.44 | 47.80 | 1.000 | ns |
| High | FCFS vs Priority-based | 42.09 | 53.33 | < .001 | *** |
| High | FCFS vs Zone Batching | 42.09 | 55.16 | < .001 | *** |
| High | Priority-based vs Zone Batching | 53.33 | 55.16 | 0.332 | ns |

These results **partially refute the primary hypothesis (H₁)**, which predicted that Zone Batching would produce the lowest average wait times. Instead, FCFS was the most time-efficient policy across all demand conditions. The mechanism underlying this finding is important to interpret. Under FCFS, the elevator responds sequentially to the order of call registration, minimizing idle repositioning between requests. Zone Batching, despite reducing stops per trip in principle, introduces periodic zone-switching delays and idle time while the elevator clears one zone before servicing another — particularly penalizing passengers whose zone is not currently active. Priority-based scheduling similarly incurs overhead by holding capacity for high-priority agents even when lower-priority passengers are ready to board and the elevator has available space. These structural overhead costs appear to outweigh the per-trip efficiency gains that zone batching provides in theory, especially in a six-floor single-elevator configuration where the total floor-space available for batching is inherently limited.

Furthermore, the **30-second institutional benchmark** for average waiting time (Siikonen, 2024) reveals a starkly practical implication: FCFS was the only policy that could plausibly meet this guideline, and only under low demand (8.0% of runs exceeding 30 seconds; mean = 26.59 s). Under medium demand, 100% of FCFS runs exceeded this benchmark (mean = 34.53 s), as did all runs under both alternative policies at all demand levels. This confirms that single-elevator performance at UP Cebu systematically fails the 30-second institutional standard during any non-trivial demand period, regardless of scheduling policy.

### 2.2 Elevator Utilization

The hypothesis (H₁b) predicted that elevator utilization would be highest under Zone Batching and lowest under Priority-based scheduling. Kruskal-Wallis tests confirmed significant policy effects on elevator utilization at all demand levels (low: H = 43.45, p < .001, η² = 0.282; medium: H = 39.19, p < .001, η² = 0.253; high: H = 22.77, p < .001, η² = 0.141). However, the direction of the effect **contradicts H₁b entirely**.

FCFS consistently produced the *highest* elevator utilization across all demand conditions (low: M = 0.254; medium: M = 0.332; high: M = 0.386), while Priority-based and Zone Batching produced nearly identical, significantly lower utilization rates (low: M = 0.222 and 0.230 respectively; high: M = 0.363 and 0.357). Post-hoc comparisons confirmed that FCFS was significantly higher than both alternatives at all demand levels (all p_adj < .001 at low and medium, p_adj = 0.0001–0.0002 at high demand), while Priority-based and Zone Batching did not differ from each other (all p_adj > 0.75).

The finding that FCFS achieves higher utilization alongside lower wait times — rather than the expected trade-off — is a meaningful result. It indicates that FCFS keeps the elevator more continuously engaged in passenger service without the idle repositioning overhead or zonal hold-and-wait periods introduced by the alternative policies. Zone Batching's design logic assumes that reducing stops per trip will increase net efficiency; in this six-floor configuration, however, the delay imposed by waiting for a zone to clear before switching appears to leave the elevator stationary more often, reducing utilization without a corresponding wait-time benefit.

### 2.3 Equity of Access Across User Types

The equity analysis examined two pairwise wait-time ratios: the student-to-faculty ratio (eq_sf, primary indicator) and the student-to-staff ratio (eq_ss, secondary indicator). A ratio of 1.0 indicates equal wait times between groups; values above 1.0 indicate that students wait proportionally longer than the comparison group.

**Student-to-Faculty Ratio.** Kruskal-Wallis tests revealed significant policy effects on the student-to-faculty equity ratio at all demand levels (low: H = 75.81, p < .001, η² = 0.502; medium: H = 93.88, p < .001, η² = 0.625; high: H = 99.72, p < .001, η² = 0.665). Post-hoc comparisons showed that FCFS produced significantly higher student-to-faculty ratios than both Priority-based and Zone Batching at all demand levels (all p_adj < .001), while Priority-based and Zone Batching did not differ from each other at any level (all p_adj > 0.82).

**Table 4. Student-to-Faculty Wait Ratio (eq_sf) by Policy and Demand**

| Policy | Low Demand | Medium Demand | High Demand |
|---|---|---|---|
| FCFS | 1.536 | 1.547 | 1.753 |
| Priority-based | 0.993 | 1.083 | 1.199 |
| Zone Batching | 0.983 | 1.064 | 1.221 |

Under FCFS, students waited 53.6%–75.3% longer than faculty across demand conditions — a persistent structural disadvantage that worsened as demand increased. Under Priority-based and Zone Batching, ratios were considerably closer to 1.0 across all conditions, though the disparity still widened with demand.

An intriguing finding emerges from the per-type wait time data. Under Priority-based scheduling, the faculty wait advantage over students was not uniform across demand levels. At low demand, faculty actually waited *longer* on average than students (M_faculty = 44.41 vs. M_student = 43.37 ticks), with faculty also waiting longer than staff (M_staff = 35.25). It was only at medium demand (M_faculty = 46.06 vs. M_student = 49.74) and high demand (M_faculty = 44.43 vs. M_student = 53.12) that the Priority-based mechanism produced the intended faculty advantage. This demand-contingent behavior reflects a structural characteristic of the Priority-based implementation in this model: floor visit sequencing remains call-order based, and boarding priority only operates when the elevator arrives at a floor with mixed-type queues. Under low demand, queues are often sparse, meaning the priority mechanism rarely triggers in a way that meaningfully benefits faculty; at higher demand, mixed-priority queues at floors become common, and the boarding-order advantage materializes consistently.

**Student-to-Staff Ratio.** The student-to-staff equity pattern followed a notably different trajectory. Under FCFS, students consistently waited longer than staff across all demand conditions (ratios of 1.304, 1.295, and 1.343 at low, medium, and high demand). Under Priority-based and Zone Batching, the student-to-staff ratio decreased with rising demand: from approximately 1.24–1.26 under low demand to 0.949 and 0.945 respectively under high demand — meaning that under high demand, staff actually began waiting *longer* than students under these two policies. Kruskal-Wallis tests confirmed significant policy effects on eq_ss at medium demand (H = 40.78, p < .001, η² = 0.264) and high demand (H = 99.11, p < .001, η² = 0.661), but not at low demand (H = 2.52, p = .283). This reversal is likely attributable to the lower stair-switching threshold of students (90 seconds) relative to staff (120 seconds): as demand and queues grow, students defect to stairs at a higher rate, selectively removing themselves from the elevator queue and leaving a disproportionate share of remaining waits borne by staff.

**Does a policy achieve both low wait times AND equitable access?** The data reveal a fundamental trade-off. FCFS minimizes average wait time but consistently disadvantages students relative to faculty (eq_sf = 1.54–1.75 across demand levels). Priority-based and Zone Batching substantially improve student-faculty equity (eq_sf = 0.98–1.22) but incur a significant wait time penalty: at all demand levels, both alternative policies produced mean average wait times 9.4–13.3 ticks higher than FCFS. No policy simultaneously achieved the lowest wait times and the most equitable access distribution. This directly answers the third sub-research question: **there is an inherent trade-off between efficiency (minimizing overall wait) and equity (equalizing wait across user types)** in this single-elevator academic building system.

---

## 3. Sub-Research Questions

### 3.1 Stair-Switching Behavior and Its Interaction with Policy

The first sub-research question asked at what point stair-switching becomes prevalent and how it interacts with scheduling policy. Hypothesis H₁a predicted that stair-switching rates would be lower under Zone Batching due to more predictable cycle times.

Kruskal-Wallis tests confirmed significant policy effects on stair-switch rate at all demand levels (low: H = 97.34, p < .001, η² = 0.649; medium: H = 99.45, p < .001, η² = 0.663; high: H = 100.30, p < .001, η² = 0.669). However, H₁a was **not supported**. FCFS produced the lowest stair-switching rates across all demand levels (low: M = 0.032; medium: M = 0.040; high: M = 0.087), while Priority-based and Zone Batching produced stair-switching rates three to four times higher than FCFS (Priority-based: 0.163, 0.212, 0.242; Zone Batching: 0.143, 0.224, 0.280 at low, medium, and high demand, respectively). Post-hoc comparisons confirmed that FCFS was significantly different from both Priority-based (all p_adj < .001) and Zone Batching (all p_adj < .001), while Priority-based and Zone Batching did not significantly differ from each other at any demand level (all p_adj > 0.37).

The higher stair-switching rates under Priority-based and Zone Batching are a direct consequence of these policies producing longer average wait times. Since stair-switching in the model is triggered when individual wait times exceed agent-type thresholds — mediated by a logistic probability function — any policy that inflates wait times mechanically produces higher stair defection. Zone Batching's zone-holding delays are particularly likely to strand passengers in non-active zones for extended periods, exceeding their switching thresholds. The hypothesis that Zone Batching would produce *more predictable* service and thus lower stair-switching was not realized in this six-floor configuration; instead, zone-switching delays produced longer and more variable waits that elevated switching more than under FCFS's continuous-service logic.

The relationship between stair-switching and demand is also instructive. Across all policies, stair-switching rates increased with demand: FCFS saw a 2.7-fold increase from low to high demand (0.032 to 0.087), Priority-based a 1.5-fold increase (0.163 to 0.242), and Zone Batching a 1.9-fold increase (0.143 to 0.280). This confirms the model's behavioral realism: as congestion grows and elevator access becomes less reliable, more passengers seek stair alternatives, consistent with empirical findings (Eves et al., 2011).

### 3.2 Demand Severity and Amplification of Policy Differences

The second sub-research question asked how peak demand severity amplified differences between scheduling policies. The data reveal that the absolute wait-time gap between FCFS and the two alternative policies remains relatively stable across demand levels rather than widening proportionally. The FCFS-to-Priority-based gap was +11.29 ticks at low demand, +12.91 at medium, and +11.23 at high demand. The FCFS-to-Zone Batching gap was +9.36 at low, +13.26 at medium, and +13.07 at high demand.

However, demand severity interacts with stair-switching behavior in a way that indirectly amplifies policy differences. As demand rises under Priority-based and Zone Batching, stair-switching rates increase substantially (by 48% and 96% from low to high demand, respectively), meaning that the reported average wait times under these policies at high demand are already partially deflated by passenger self-selection out of the queue. The true congestion experienced by those who remain in the elevator queue at high demand under Priority-based and Zone Batching may be greater than the reported means suggest. Meanwhile, FCFS's stair-switching rate at high demand (0.087) remains comparatively modest, meaning FCFS wait-time means include a broader share of the original passenger population.

Kruskal-Wallis tests examining the effect of demand *within* each policy confirmed highly significant demand effects across all outcomes and policies (all p < .001 for avg_wait, avg_journey, stair_rate, elev_util, student_wait, and staff_wait), confirming that demand is independently a powerful moderator of all system outcomes regardless of which policy is in use. The marginal effect of moving from medium to high demand was consistent across policies, suggesting that the system does not shift qualitatively into a different congestion regime between these levels — rather, performance degrades smoothly and proportionally.

---

## 4. Summary of Hypothesis Testing

| Hypothesis | Prediction | Result | Supported? |
|---|---|---|---|
| H₁ | Zone Batching produces lowest average wait times | FCFS produced the lowest; ZB and PB did not differ | **Not supported** |
| H₁ | Priority-based minimizes faculty wait at student/staff cost | Faculty advantage only consistent at medium–high demand; not present at low demand | **Partially supported** |
| H₁ | FCFS produces most equitable but least efficient outcomes | FCFS was most efficient but *least* equitable (highest student penalty) | **Contradicted on efficiency; confirmed on equity** |
| H₁a | Stair switching lower under Zone Batching | FCFS had lowest stair switching; ZB and PB were equally high | **Not supported** |
| H₁b | Utilization highest under Zone Batching, lowest under Priority-based | FCFS had highest utilization; PB and ZB were nearly equal and lower | **Not supported** |

---

## 5. Discussion

The overarching finding of this study — that FCFS outperforms both Priority-based and Zone Batching on average wait time, elevator utilization, and stair-switching rates, while being the least equitable policy toward students — has important implications for both the specific context of UP Cebu and the broader literature on single-elevator scheduling.

**Why FCFS outperforms structurally complex policies in this context.** The result is counter-intuitive given the theoretical efficiency case for zone batching (DC Elevator, 2025) and priority-based scheduling. The key explanatory factor is the six-floor constraint of the College of Science building. Zone Batching's advantages — reduced stops per trip, fewer directional reversals — are most pronounced in tall buildings with many floors, where zone consolidation meaningfully reduces travel distance. In a six-floor building partitioned into three zones of two floors each, the gain per zone-completion is small, while the zone-holding penalty (waiting for all onboard passengers in a zone to alight before switching) imposes a fixed delay that scales poorly with stochastic arrival variance. This finding aligns with Barney's (2011) observation that single-elevator architectural constraints fundamentally bound performance regardless of dispatch logic, and suggests that zone batching's documented advantages apply primarily to multi-elevator or higher-rise contexts.

**The equity–efficiency trade-off and policy implications for UP Cebu.** The study confirms that no single scheduling policy simultaneously minimizes overall wait time and equalizes access across user groups. FCFS is the clear efficiency winner but structurally disadvantages students, who wait 54–75% longer than faculty under this policy. Priority-based and Zone Batching narrow the equity gap substantially (student-to-faculty ratios of 0.98–1.22) but do so at the cost of elevating average wait times by 9–13 seconds across the board, exceeding the 30-second institutional benchmark at all demand levels. Given that UP Cebu's College of Science building is primarily a student-serving academic environment, institutional decision-makers must weigh these trade-offs explicitly. A pragmatic recommendation from these results is that FCFS remains the most practical operating policy for overall throughput — particularly during low demand, where it is the only policy that can approach the 30-second guideline — while equity concerns during high-demand transition periods may be better addressed through architectural or operational interventions (dedicated stair signage, staggered class transition times) rather than elevator scheduling logic alone.

**Demand as the binding constraint.** The results affirm that demand magnitude is ultimately the dominant system constraint. All three policies failed the 30-second benchmark at medium and high demand, and the absolute performance gaps between policies (9–13 ticks at high demand) are small relative to the baseline performance problem (all policies yield mean waits of 42–55 seconds at high demand versus the 30-second guideline). This confirms that the structural solution for UP Cebu's elevator problem — consistent with Barney's (2011) analysis — lies in adding elevator capacity rather than optimizing the scheduling of a single car. The model provides quantitative evidence to support that institutional recommendation.

**Limitations that qualify the findings.** Several model limitations moderate the strength of these conclusions. The absence of empirical calibration data means that absolute wait times are comparative rather than precisely predictive. The behavioral homogeneity within agent types — particularly the type-constant stair-switching thresholds — may underrepresent the individual variation in real passenger behavior. Stair congestion is not modeled, potentially understating the full cost of high stair-switching rates under Priority-based and Zone Batching. And the static, rule-based policy implementations cannot replicate the adaptive behavior of modern machine-learning elevator controllers (Wu & Yang, 2024), meaning the performance ceiling of Priority-based and Zone Batching in this building may be higher than these results suggest. Despite these limitations, the model's directional findings — particularly the consistent superiority of FCFS in this specific physical configuration — are robust across 50 replications per cell with large effect sizes (η² = 0.28–0.67), providing confidence that the qualitative policy rankings reported here would be replicated in a well-calibrated empirical study.
