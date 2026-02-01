# 📊 Chatbot Analytics Dashboard

> Projet portfolio démontrant une pipeline data complète : de l'ingestion à la visualisation.

![BigQuery](https://img.shields.io/badge/Google%20BigQuery-4285F4?style=flat&logo=google-cloud&logoColor=white)
![Looker Studio](https://img.shields.io/badge/Looker%20Studio-4285F4?style=flat&logo=google&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)

## 🎯 Objectif

Construire un dashboard d'analyse de conversations chatbot pour comprendre :
- Les **catégories** de demandes les plus fréquentes
- Les **intentions** utilisateur détectées
- La **qualité** des messages (formulations, fautes, politesse)

Ce projet simule le travail d'un Data Analyst sur un assistant virtuel de service client.

## 🏗️ Architecture

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Source        │     │   Stockage      │     │   Visualisation │
│   Kaggle        │────▶│   BigQuery      │────▶│   Looker Studio │
│   (CSV)         │     │   (Data Warehouse)    │   (Dashboard)   │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

## 📁 Structure du projet

```
chatbot-analytics/
├── README.md                 # Ce fichier
├── data/                     # Données brutes (non versionnées)
├── sql/
│   ├── 01_create_schema.sql  # Création du dataset BigQuery
│   ├── 02_analysis.sql       # Requêtes d'analyse exploratoire
│   └── 03_kpis.sql           # Requêtes pour les KPIs du dashboard
└── docs/
    └── insights.md           # Insights et conclusions
```

## 🔧 Technologies utilisées

| Technologie | Usage |
|-------------|-------|
| **Google Cloud Platform** | Infrastructure cloud |
| **BigQuery** | Data warehouse serverless |
| **Looker Studio** | Visualisation et dashboard |
| **Python + Kaggle API** | Récupération des données |
| **SQL** | Analyse et transformation |

## 📊 Dataset

**Source** : [Bitext - Customer Service Training Dataset](https://www.kaggle.com/datasets/bitext/training-dataset-for-chatbotsvirtual-assistants)

| Champ | Description |
|-------|-------------|
| `flags` | Indicateurs de formulation (B=Base, I=Informal, M=Misspell, P=Polite) |
| `utterance` | Message de l'utilisateur |
| `category` | Catégorie générale (ACCOUNT, ORDER, REFUND...) |
| `intent` | Intention spécifique (cancel_order, track_refund...) |

**Volume** : 8 175 messages répartis en 11 catégories et 27 intentions.

## 📈 Insights clés

### Répartition des demandes
- **ACCOUNT** (22%) : Gestion de compte (création, suppression, mot de passe)
- **ORDER** (15%) : Commandes (suivi, annulation, modification)
- **REFUND** (11%) : Remboursements

### Top 5 des intentions
1. `get_invoice` - 324 occurrences
2. `check_invoice` - 324 occurrences
3. `payment_issue` - 323 occurrences
4. `review` - 315 occurrences
5. `track_refund` - 308 occurrences

### Qualité des messages
- **29%** des messages sont en formulation de base (B)
- **13%** contiennent du langage informel (BI)
- **10%** contiennent des fautes d'orthographe (BM)

## 🚀 Reproduire le projet

### Prérequis
- Compte Google Cloud Platform
- Python 3.x
- Kaggle API configurée

### Étapes

```bash
# 1. Cloner le repository
git clone https://github.com/TON_USERNAME/chatbot-analytics.git
cd chatbot-analytics

# 2. Configurer GCP
gcloud auth login
gcloud projects create chatbot-analytics-TONNOM
gcloud config set project chatbot-analytics-TONNOM

# 3. Créer le dataset BigQuery
gcloud services enable bigquery.googleapis.com
bq mk --dataset --location=EU chatbot_analytics

# 4. Télécharger les données
kaggle datasets download bitext/training-dataset-for-chatbotsvirtual-assistants -p data/ --unzip

# 5. Charger dans BigQuery
bq load \
  --source_format=CSV \
  --skip_leading_rows=1 \
  --schema="flags:STRING,utterance:STRING,category:STRING,intent:STRING" \
  chatbot_analytics.customer_service_utterances \
  data/Bitext_Sample_Customer_Service_Training_Dataset/Training/Bitext_Sample_Customer_Service_Training_Dataset.csv
```

## 🔗 Liens

- **Dashboard Looker Studio** : [Voir le dashboard](LIEN_A_AJOUTER)
- **Dataset Kaggle** : [Bitext Customer Service](https://www.kaggle.com/datasets/bitext/training-dataset-for-chatbotsvirtual-assistants)

## 👤 Auteur

**Alexis de Sousa**  
Data Analyst | Passionné par l'analyse conversationnelle et les chatbots

---

*Projet réalisé dans le cadre d'un portfolio data analytics.*
