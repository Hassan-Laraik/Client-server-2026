# 🧾 Gestion des Clients – Module Lazarus (uClient)

## 📘 Description

Ce module **`uClient.pas`** est une unité de l’application Lazarus dédiée à la **gestion des clients** dans une base de données MySQL via **ZeosLib (ZQuery)**.  
Il permet d’effectuer les opérations suivantes :

- 🔍 **Rechercher** des clients par nom, prénom ou ville  
- ➕ **Ajouter** un nouveau client  
- ✏️ **Éditer** les informations d’un client  
- 🧩 **Modifier** les données existantes avec validation d’unicité de l’email  
- ❌ **Supprimer** un client (prévu via le bouton `Supprimer`)  
- 📋 **Lister** les clients dans un `DBGrid`

---

## 🧠 Fonctionnalités principales

### 1. Recherche (`BtnRechercherClick`)
Recherche dynamique sur la table `clients` :
```sql
SELECT * FROM clients 
WHERE CONCAT(nom, prenom, ville) LIKE '%<texte saisi>%';
```

### 2. Chargement initial (`FormCreate`)
Au démarrage du formulaire, la liste complète des clients est affichée :
```sql
SELECT * FROM clients;
```

### 3. Édition d’un enregistrement (`BtnEditerClick`)
Charge les informations du client sélectionné dans les champs :
```pascal
EdtNom.Text := DM.ZqryClient.FieldByName('nom').AsString;
```

### 4. Modification (`BtnModifierClick`)
- Vérifie qu’un autre client n’a pas déjà le même email.  
- Met à jour les champs `nom`, `prenom`, `email`, `ville` pour l’ID sélectionné.  
- Recharge la liste à la fin.

### 5. Validation / Insertion (`ValiderClick`)
Avant insertion, vérifie si l’email existe déjà :
```sql
SELECT email FROM clients WHERE email LIKE :email;
```
Puis insère :
```sql
INSERT INTO clients (nom, prenom, email, ville)
VALUES (:nom, :prenom, :email, :ville);
```

---

## 🏗️ Composants utilisés

| Composant | Description |
|------------|--------------|
| `TForm` | Fenêtre principale du module |
| `TButton` | Boutons d’action (Rechercher, Modifier, Valider, etc.) |
| `TEdit` | Zones de saisie pour les informations client |
| `TDBGrid` | Affichage de la liste des clients |
| `TLabel` | Étiquettes descriptives |
| `TDataModule (uDM)` | Contient la connexion et la requête Zeos (`ZConnection`, `ZQuery`) |

---

## 🗃️ Base de données

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

## ⚙️ Pré-requis

- **Lazarus IDE**
- **Free Pascal Compiler (FPC)**
- **Composants ZeosLib** (ZConnection, ZQuery)
- Base de données **MySQL / MariaDB**

---

## 🚀 Installation & Exécution

1. Ouvre le projet Lazarus.
2. Vérifie que l’unité `uDM` contient une connexion `ZConnection` valide vers ta base MySQL.
3. Compile et exécute le projet.
4. Le formulaire `TFrmClient` permet alors de :
   - Ajouter un client
   - Modifier / Rechercher
   - Afficher la liste complète

---

## 🧩 Améliorations possibles

- Ajouter la suppression (`DELETE FROM clients WHERE id = :id`)
- Gérer les exceptions SQL (try/except)
- Séparer la logique métier dans une classe ou un contrôleur
- Ajouter des validations plus avancées (email, champ vide)
- Intégrer un message toast ou un label de notification au lieu de `ShowMessage`

---

## 👨‍💻 Auteur

**Projet Lazarus – Gestion des Clients**  
Développé par [Ton Nom ou Institut]  
© 2025
