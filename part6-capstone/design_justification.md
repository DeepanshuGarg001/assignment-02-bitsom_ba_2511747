# Design Justification: Hospital AI Data System

The proposed architecture for the Mid-sized Hospital Network is designed to handle the velocity of real-time patient monitoring, the complexity of semantic history retrieval, and the rigor of predictive healthcare analytics.

## Storage Systems

For each of the four core goals, the following storage systems were selected:

1. **Predict Patient Readmission Risk:** This requires historical clinical data (EHR). I have chosen a **Data Lakehouse (Delta Lake)** as the primary storage. This allows us to store years of longitudinal patient data cost-effectively while providing the ACID transactions and high-performance SQL required for feature engineering and training Machine Learning models.
2. **Natural Language Patient History Search:** For goal two, a **Vector Database (such as Milvus or Pinecone)** is integrated. Patient notes are converted into high-dimensional embeddings. Traditional SQL indexes are insufficient for queries like "Has this patient had a cardiac event before?" where the phrasing may vary. The vector store enables semantic retrieval, matching concepts rather than just keywords.
3. **Monthly Reporting & BI:** A dedicated **Cloud Data Warehouse (e.g., Snowflake or BigQuery)** is used for management reporting. While the Lakehouse handles the raw data, the Data Warehouse stores highly curated, aggregated schemas (Star Schema) tailored for executive dashboards, ensuring sub-second latency for financial and occupancy reports.
4. **Real-time Vitals Monitoring:** I have selected a **Time-Series Database or In-Memory Store (e.g., Redis or InfluxDB)** for the "Hot" data path. ICU vitals generate thousands of data points per second. This system allows for immediate threshold-based alerting (e.g., tachycardia detection) without the latency of writing to a persistent disk-based lake first.

## OLTP vs OLAP Boundary

The boundary between the transactional (OLTP) and analytical (OLAP) systems begins at the **Ingestion Layer**. The hospital's primary EHR system and billing software operate as the OLTP layer, handling day-to-day operations and single-record lookups. Data enters our AI architecture via **Change Data Capture (CDC)** or real-time event streams (Kafka). 

The moment data is replicated into the **Hospital Data Lake**, it enters the OLAP boundary. All downstream processes—from vector embedding and ML model scoring to Star Schema aggregation—are analytical. This separation ensures that complex AI workloads do not degrade the performance of critical bedside clinical systems.

## Trade-offs

One significant trade-off in this design is **Architectural Complexity**. By using a "Polyglot Persistence" approach (Vector DB + Data Warehouse + Time-Series DB), we gain specialized performance for each goal but increase the maintenance burden and the risk of "data silos" if synchronization is not handled correctly.

**Mitigation:** To mitigate this, I have implemented the **Hospital Data Lake as the Single Source of Truth (SSoT)**. All specialized databases (Vector, DW) are derived from the Data Lake via a unified orchestration layer (e.g., Apache Airflow). If any downstream system fails, it can be re-hydrated from the immutable records in the Data Lake, ensuring long-term data consistency and system resilience.
