-- ============================================
-- 01_create_schema.sql
-- Création du dataset et de la table BigQuery
-- ============================================

-- Création du dataset (exécuté via CLI)
-- bq mk --dataset --location=EU chatbot_analytics

-- Schéma de la table customer_service_utterances
-- J'ai défini explicitement les types pour éviter l'autodetect
-- qui ne prenait pas les en-têtes comme noms de colonnes

CREATE TABLE IF NOT EXISTS chatbot_analytics.customer_service_utterances (
    flags STRING,        -- Indicateurs de formulation du message
                         -- B=Base, I=Informal, M=Misspell, P=Polite, L=Long, E=Expanded
    
    utterance STRING,    -- Le message brut de l'utilisateur
    
    category STRING,     -- Catégorie générale de la demande
                         -- Ex: ACCOUNT, ORDER, REFUND, INVOICE, PAYMENT...
    
    intent STRING        -- Intention spécifique détectée
                         -- Ex: cancel_order, track_refund, get_invoice...
);

-- Note : En production, j'ajouterais :
-- - Un champ timestamp pour la date du message
-- - Un champ session_id pour regrouper les conversations
-- - Un champ user_id pour l'analyse par utilisateur
-- - Un champ sentiment_score pour l'analyse de sentiment
