-- ============================================
-- 03_kpis.sql
-- Requêtes utilisées pour alimenter le dashboard Looker Studio
-- ============================================

-- Ces requêtes correspondent aux visualisations du dashboard
-- Looker Studio les exécute automatiquement via le connecteur BigQuery

-- ----------------------------------------
-- KPI 1 : Volume total de messages
-- ----------------------------------------
-- Visualisation : Scorecard
SELECT COUNT(*) as total_messages
FROM chatbot_analytics.customer_service_utterances;


-- ----------------------------------------
-- KPI 2 : Nombre de catégories uniques
-- ----------------------------------------
-- Visualisation : Scorecard
SELECT COUNT(DISTINCT category) as nb_categories
FROM chatbot_analytics.customer_service_utterances;


-- ----------------------------------------
-- KPI 3 : Nombre d'intentions uniques
-- ----------------------------------------
-- Visualisation : Scorecard  
SELECT COUNT(DISTINCT intent) as nb_intents
FROM chatbot_analytics.customer_service_utterances;


-- ----------------------------------------
-- Graphique 1 : Répartition par catégorie
-- ----------------------------------------
-- Visualisation : Camembert (Pie Chart)
SELECT 
    category,
    COUNT(*) as record_count
FROM chatbot_analytics.customer_service_utterances
GROUP BY category
ORDER BY record_count DESC;


-- ----------------------------------------
-- Graphique 2 : Top Intents
-- ----------------------------------------
-- Visualisation : Barres horizontales
SELECT 
    intent,
    COUNT(*) as record_count
FROM chatbot_analytics.customer_service_utterances
GROUP BY intent
ORDER BY record_count DESC
LIMIT 10;


-- ----------------------------------------
-- Tableau : Détail catégorie × intent
-- ----------------------------------------
-- Visualisation : Tableau interactif avec filtre
SELECT 
    category,
    intent,
    COUNT(*) as record_count
FROM chatbot_analytics.customer_service_utterances
GROUP BY category, intent
ORDER BY record_count DESC;


-- ----------------------------------------
-- Métriques avancées (pour évolutions futures)
-- ----------------------------------------

-- Taux de messages informels
SELECT 
    ROUND(
        COUNTIF(flags LIKE '%I%') * 100.0 / COUNT(*), 
        2
    ) as taux_informel
FROM chatbot_analytics.customer_service_utterances;

-- Taux de messages avec fautes
SELECT 
    ROUND(
        COUNTIF(flags LIKE '%M%') * 100.0 / COUNT(*), 
        2
    ) as taux_fautes
FROM chatbot_analytics.customer_service_utterances;

-- Ces métriques pourraient alimenter des KPIs supplémentaires
-- pour mesurer la qualité des interactions utilisateur
