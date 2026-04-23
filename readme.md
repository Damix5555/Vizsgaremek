# G-Elite Customs - Egyedi órakonfigurátor webshop

## Bláthy Ottó Titusz Informatikai Technikum Vizsgaremek

**Készítette:** Fekete Dániel - Bernáth Erik

---

# Projekt leírása

A G-Elite Customs célja egy modern, felhasználóbarát webes órakonfigurátor és webshop rendszer létrehozása, amely lehetővé teszi a felhasználók számára, hogy saját egyedi órát állítsanak össze különböző alkatrészekből.

A rendszerben a felhasználók:

* különböző alkatrészekből (tok, szíj, számlap, mutatók) konfigurálhatnak egyedi órát,
* elmenthetik saját konfigurációikat,
* előre összeállított kész órák közül választhatnak,
* kosárba helyezhetik a termékeket,
* rendelést adhatnak le,
* megtekinthetik korábbi rendeléseiket.


Az adminisztrációs felületen lehetőség van:

* alkatrészek kezelésére,
* kész órák létrehozására és módosítására,
* rendelések státuszának kezelésére,
* audit log megtekintésére.

---

# Felhasznált technológiák

## Backend

* Laravel
* PHP
* MySQL

## Frontend

* Vue 3
* Vue Router
* Pinia
* Bootstrap 5
* Axios

---

# Forrásállományok

## Backend forráskód



## Frontend forráskód


## Adatbázis dump


## API route lista


# Telepítés

## Backend indítása

```bash
cd g-elite-backend
composer install
php artisan migrate
php artisan storage:link
php artisan serve
```

## Frontend indítása

```bash
cd g-elite-frontend
npm install
npm run dev
```

---

# Funkciók

* Regisztráció / bejelentkezés
* Jogosultságkezelés
* Egyedi órakonfigurátor
* Kész órák webshop
* Kosárkezelés
* Rendelés leadás
* Saját konfigurációk mentése
* Admin termékkezelés
* Admin rendeléskezelés
* Audit log rendszer

---
