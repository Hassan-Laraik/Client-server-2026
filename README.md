# 🧾 Gestion des Clients – Application Lazarus

## 📘 Description

Ce projet Lazarus met en œuvre une application de **gestion des clients** connectée à une base de données **MySQL** via **ZeosLib (ZConnection, ZQuery, ZTable)**.  
L’application est composée de deux unités principales :

- `uClient.pas` → Interface utilisateur (formulaire principal)  
- `uDM.pas` → Module de données (connexion et opérations CRUD)

---

## 🧩 Modules du projet

### 🔹 1. Module `uClient.pas` – Interface utilisateur

Ce module gère toutes les interactions avec l’utilisateur à travers un formulaire Lazarus (`TFrmClient`).  
Il permet :

- 🔍 **Rechercher** des clients par nom, prénom ou ville  
- ➕ **Ajouter** un nouveau client  
- ✏️ **Éditer** et **modifier** les données existantes  
- ⚠️ Vérifier l’unicité de l’email avant insertion/modification  
- 📋 **Lister** les clients dans une grille (`DBGrid`)

#### Principales procédures

| Procédure | Description |
|------------|-------------|
| `BtnRechercherClick` | Recherche dynamique par nom, prénom, ville |
| `FormCreate` | Charge la liste complète des clients au démarrage |
| `BtnEditerClick` | Charge les infos du client sélectionné dans les champs d’édition |
| `BtnModifierClick` | Vérifie l’unicité de l’email et met à jour l’enregistrement |
| `ValiderClick` | Insère un nouveau client après vérification |
| `NouveauClick` | Réinitialise les champs du formulaire |

---

### 🔹 2. Module `uDM.pas` – Gestion des données

Le module `uDM` est un **DataModule** (`TDataModule`) contenant tous les composants de connexion et de gestion des données.

#### Composants principaux

| Composant | Description |
|------------|-------------|
| `ZNX: TZConnection` | Connexion à la base MySQL |
| `ZqryClient: TZQuery` | Requêtes SQL personnalisées |
| `ZtblClient: TZTable` | Accès direct à la table `clients` |
| `DSClient, DSZClient` | Sources de données pour le lien avec les composants visuels |

#### Méthodes du module `TDM`

| Méthode | Rôle | Description |
|----------|------|-------------|
| `Ajouter_Client()` | Insertion | Passe le `TZTable` en mode ajout (`Append`) |
| `Modifier_Client()` | Édition | Passe le `TZTable` en mode modification (`Edit`) |
| `Supprimer_Client()` | Suppression | Supprime l’enregistrement courant si non vide |
| `Annuler_Client()` | Annulation | Annule les changements en cours (`Cancel`) |
| `Valider_Client()` | Validation | Enregistre les changements (`Post`) et gère les erreurs |

Chaque méthode renvoie un **booléen** (`True` ou `False`) selon le succès de l’opération.

Exemple d’utilisation dans le code :  
```pascal
if DM.Ajouter_Client then
  ShowMessage('Nouveau client ajouté avec succès !');
```

---

## 🗃️ Structure de la base de données

**Table : `clients`**

| Champ | Type | Description |
|--------|------|--------------|
| `id` | INT, PRIMARY KEY, AUTO_INCREMENT | Identifiant unique |
| `nom` | VARCHAR(100) | Nom du client |
| `prenom` | VARCHAR(100) | Prénom du client |
| `email` | VARCHAR(150) | Adresse email |
| `adresse` | VARCHAR(255) | Adresse du client |
| `ville` | VARCHAR(100) | Ville du client |

---

## ⚙️ Pré-requis techniques

- **Lazarus IDE** (version récente)  
- **Free Pascal Compiler (FPC)**  
- **ZeosLib** installée (`ZConnection`, `ZQuery`, `ZTable`)  
- Serveur **MySQL / MariaDB** accessible

---

## 🚀 Installation & exécution

1. Ouvre le projet Lazarus.
2. Vérifie les paramètres de `ZNX` dans `uDM.pas` : hôte, utilisateur, mot de passe, base.
3. Compile et exécute le projet.
4. L’interface `TFrmClient` permet alors de :
   - Ajouter, modifier, supprimer des clients  
   - Rechercher par texte  
   - Visualiser les données via le `DBGrid`

---

## 🧠 Bonnes pratiques et améliorations possibles

- Ajouter la suppression SQL manuelle (`DELETE FROM clients WHERE id = :id`)
- Centraliser les requêtes SQL dans le DataModule
- Gérer les exceptions SQL avec `try/except` et journalisation
- Ajouter des validations de saisie (email valide, champs obligatoires)
- Utiliser des messages “toast” ou labels colorés pour les notifications

---

## 👨‍💻 Auteur

**Projet Lazarus – Gestion des Clients**  
Développé par Développé par Ait Larail Hassan Formateur Chez IPCIG : Institut Professionnel Centrale D'Informatique et Gestion : Accrédité  
© 2025
