-- ============================================
-- 02_analysis.sql
-- Requêtes d'analyse exploratoire du dataset
-- ============================================

-- J'utilise ces requêtes pour comprendre la structure et 
-- la distribution des données avant de construire le dashboard

-- ----------------------------------------
-- 1. Vue d'ensemble du dataset
-- ----------------------------------------

-- Nombre total de messages
SELECT 
    COUNT(*) as total_messages
FROM chatbot_analytics.customer_service_utterances;
-- Résultat : 8 175 messages


-- ----------------------------------------
-- 2. Analyse par catégorie
-- ----------------------------------------

-- Répartition des demandes par catégorie
-- Ça me permet de voir quels sont les sujets les plus demandés
SELECT 
    category,
    COUNT(*) as nombre_messages,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as pourcentage
FROM chatbot_analytics.customer_service_utterances
GROUP BY category
ORDER BY nombre_messages DESC;

-- Insights :
-- ACCOUNT représente 22% des demandes → priorité pour le chatbot
-- ORDER arrive en 2ème position avec 15%
-- Les catégories sont assez équilibrées, pas de déséquilibre majeur


-- ----------------------------------------
-- 3. Analyse des intentions
-- ----------------------------------------

-- Top 10 des intentions les plus fréquentes
SELECT 
    intent,
    COUNT(*) as nombre_messages
FROM chatbot_analytics.customer_service_utterances
GROUP BY intent
ORDER BY nombre_messages DESC
LIMIT 10;

-- Insights :
-- get_invoice et check_invoice sont en tête
-- Les utilisateurs ont souvent besoin de leurs factures
-- → Opportunité d'améliorer l'accès aux factures dans l'interface


-- ----------------------------------------
-- 4. Analyse croisée catégorie × intent
-- ----------------------------------------

-- Voir quels intents appartiennent à quelle catégorie
-- Utile pour valider la cohérence du tagging
SELECT 
    category,
    intent,
    COUNT(*) as nombre_messages
FROM chatbot_analytics.customer_service_utterances
GROUP BY category, intent
ORDER BY category, nombre_messages DESC;


-- ----------------------------------------
-- 5. Analyse de la qualité des messages (flags)
-- ----------------------------------------

-- Distribution des flags
SELECT 
    flags,
    COUNT(*) as nombre_messages,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as pourcentage
FROM chatbot_analytics.customer_service_utterances
GROUP BY flags
ORDER BY nombre_messages DESC
LIMIT 10;

-- Décodage des flags :
-- B = Base (message standard)
-- I = Informal (langage familier)
-- M = Misspell (fautes d'orthographe)
-- P = Polite (formulation polie)
-- L = Long (message long)
-- E = Expanded (message développé)

-- Insights :
-- 29% des messages sont en formulation de base (B)
-- Les fautes d'orthographe (M) sont présentes dans 10% des cas
-- → Le chatbot doit être robuste aux fautes de frappe


-- ----------------------------------------
-- 6. Analyse de la longueur des messages
-- ----------------------------------------

-- Longueur moyenne des messages par catégorie
SELECT 
    category,
    ROUND(AVG(LENGTH(utterance)), 0) as longueur_moyenne,
    MIN(LENGTH(utterance)) as longueur_min,
    MAX(LENGTH(utterance)) as longueur_max
FROM chatbot_analytics.customer_service_utterances
GROUP BY category
ORDER BY longueur_moyenne DESC;

-- Insight : 
-- Certaines catégories génèrent des messages plus longs
-- → Peut nécessiter un traitement NLP plus poussé


-- ----------------------------------------
-- 7. Exemples de messages par intention
-- ----------------------------------------

-- Utile pour comprendre comment les utilisateurs formulent leurs demandes
SELECT 
    intent,
    utterance
FROM chatbot_analytics.customer_service_utterances
WHERE intent = 'cancel_order'
LIMIT 5;

-- Ça m'aide à comprendre les variations de formulation
-- et à améliorer la détection d'intention du chatbot
