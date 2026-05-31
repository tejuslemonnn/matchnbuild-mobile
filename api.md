# Match & Build — API Documentation

Dokumentasi REST API untuk layanan **Match & Build** (backend Go/Gin). Dokumen ini disusun dari koleksi Bruno di folder ini (`Match and Build Testing API/`) dan diverifikasi langsung terhadap route handler di [cmd/main.go](../cmd/main.go) serta seluruh `modules/*/routes.go`.

---

## Daftar Isi

1. [Informasi Umum](#1-informasi-umum)
2. [Konvensi Response & Error](#2-konvensi-response--error)
3. [Auth](#3-auth)
4. [User](#4-user)
5. [Designer](#5-designer)
6. [Design Item](#6-design-item)
7. [Features](#7-features)
8. [User Preferences](#8-user-preferences)
9. [Project Request](#9-project-request)
10. [Quotation](#10-quotation)
11. [Upload](#11-upload)
12. [Ringkasan Tabel Endpoint](#12-ringkasan-tabel-endpoint)

---

## 1. Informasi Umum

| Item | Nilai |
|------|-------|
| Base URL (Dev) | `http://localhost:8888/api/v1` |
| Format | JSON (kecuali endpoint `Upload` → `multipart/form-data`) |
| Autentikasi | Bearer JWT pada header `Authorization: Bearer <access_token>` |
| Role | `client`, `designer` |

Variabel environment Bruno (lihat [environments/Dev.yml](environments/Dev.yml)):

```
base_url            http://localhost:8888/api/v1
access_token        <jwt>
refresh_token       <jwt>
user_id             <uuid>
designer_id         <uuid>
design_item_id      <uuid>
project_request_id  <uuid>
quotation_id        <uuid>
preference_id       <uuid>
email               <string>
password            <string>
```

### Catatan & koreksi terhadap koleksi Bruno

Beberapa file Bruno berisi typo / inkonsistensi. Yang **valid** mengikuti route Go:

- `Send Password Reset.yml` menulis `{{bas_url}}` → seharusnya `{{base_url}}`.
- `Get Quotation by ID.yml` menulis `{{base_ul}}` → seharusnya `{{base_url}}`.
- `Create User Preferences.yml` (di folder `Upload/` dengan nama `Upload File. yml`) sebenarnya bukan endpoint upload — file untuk Upload tidak ada di koleksi. Endpoint upload yang benar didokumentasikan di [§11](#11-upload).
- `Create Item Design.yml` mengarah ke `/design-item` (singular) — route yang terdaftar di server hanya `/design-items`. Gunakan endpoint **Create Design Item** ([§6.4](#64-create-design-item)).
- File `Get All Design Item.yml` dan `Get All Design Items.yml` adalah duplikat dari endpoint yang sama (`GET /design-items`).

---

## 2. Konvensi Response & Error

Seluruh handler mengembalikan struktur standar (`utils.BuildResponseSuccess` / `utils.BuildResponseFailed`):

```jsonc
// Success
{
  "status": true,
  "message": "<pesan sukses>",
  "data": { /* payload */ }
}

// Failed
{
  "status": false,
  "message": "<pesan gagal>",
  "error": "<detail error>",
  "data": null
}
```

Kode HTTP yang umum dipakai:

| Code | Arti |
|------|------|
| 200 | OK (GET / PATCH / PUT) |
| 201 | Created (POST) |
| 400 | Bad Request (validasi gagal / body tidak sesuai) |
| 401 | Unauthorized (token hilang / kadaluarsa / tidak valid) |
| 403 | Forbidden (role tidak diizinkan, bukan pemilik resource) |
| 404 | Not Found |
| 500 | Internal Server Error |

---

## 3. Auth

Base path: `/auth` — lihat [modules/auth/routes.go](../modules/auth/routes.go).

### 3.1 Register

`POST /auth/register` — publik.

Request body ([auth_dto.go](../modules/auth/dto/auth_dto.go) + [user_dto.go](../modules/user/dto/user_dto.go) `UserCreateRequest`):

```json
{
  "name": "Rizal",
  "email": "user@example.com",
  "password": "password123",
  "role": "client"
}
```

Validasi:
- `name`: required, 2–100 char.
- `email`: required, format email.
- `password`: required, minimal 8 char.
- `role`: required, salah satu dari `client` | `designer`.

### 3.2 Login

`POST /auth/login` — publik.

```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

Response (sukses) — `TokenResponse`:

```json
{
  "access_token": "<jwt>",
  "refresh_token": "<jwt>",
  "role": "client"
}
```

### 3.3 Refresh Token

`POST /auth/refresh` — publik.

```json
{ "refresh_token": "<jwt>" }
```

### 3.4 Logout

`POST /auth/logout` — **butuh `Authorization`**.

Tidak ada body. Server akan invalidasi refresh token untuk user terkait.

### 3.5 Send Verification Email

`POST /auth/send-verification-email` — publik.

```json
{ "email": "user@example.com" }
```

### 3.6 Verify Email

`POST /auth/verify-email` — publik.

```json
{
  "email": "user@example.com",
  "code": "414373"
}
```

Validasi: `code` wajib 6 karakter.

### 3.7 Send Password Reset

`POST /auth/send-password-reset` — publik.

```json
{ "email": "user@example.com" }
```

### 3.8 Reset Password

`POST /auth/reset-password` — publik (butuh token reset dari email).

```json
{
  "token": "<reset_token>",
  "new_password": "password1234"
}
```

Validasi: `new_password` minimal 8 char.

---

## 4. User

Base path: `/user` — lihat [modules/user/routes.go](../modules/user/routes.go).

### 4.1 Get All Users

`GET /user` — publik.

### 4.2 Get Current User

`GET /user/me` — **butuh `Authorization`**.

Response (`UserResponse`):

```json
{
  "id": "<uuid>",
  "name": "Rizal",
  "email": "user@example.com",
  "role": "client",
  "profile_picture": null,
  "is_verified": true
}
```

### 4.3 Update User

`PATCH /user/:id` — **butuh `Authorization`**.

```json
{
  "name": "Updated Name",
  "email": "new@example.com",
  "profile_picture": "https://..."
}
```

Semua field opsional. Validasi: `name` 2–100, `email` format email.

### 4.4 Delete User

`DELETE /user/:id` — **butuh `Authorization`**.

---

## 5. Designer

Base path: `/designers` — lihat [modules/designer/routes.go](../modules/designer/routes.go).

### 5.1 Get All Designers

`GET /designers` — publik.

### 5.2 Get My Designer Profile

`GET /designers/me` — **butuh `Authorization`** (role `designer`).

### 5.3 Get Designer by ID

`GET /designers/:id` — publik.

### 5.4 Update Designer Profile

`PATCH /designers/:id` — **butuh `Authorization`** (pemilik profil).

```json
{
  "bio": "Experienced architect with 10+ years in residential design",
  "experience_years": 10,
  "is_available": true,
  "location": "Jakarta, Indonesia",
  "bank_account_number": "1234567890"
}
```

Semua field opsional. Validasi: `bio` max 1000, `experience_years` 0–50, `location` max 255, `bank_account_number` max 50.

Response (`DesignerProfileResponse`):

```json
{
  "id": "<uuid>",
  "user_id": "<uuid>",
  "name": "Rizal",
  "profile_picture": null,
  "bio": "...",
  "experience_years": 10,
  "is_verified": true,
  "is_available": true,
  "location": "Jakarta, Indonesia"
}
```

---

## 6. Design Item

Base path: `/design-items` — lihat [modules/design_item/routes.go](../modules/design_item/routes.go).

### 6.1 Get All Design Items

`GET /design-items` — publik.

### 6.2 Get My Design Items

`GET /design-items/my-items` — **butuh `Authorization`** (designer).

### 6.3 Get Recommendation (berdasarkan preferensi)

`GET /design-items/recommendations` — **butuh `Authorization`** (client, harus sudah punya preferences).

Response (`RecommendationResponse`):

```json
{
  "items": [ /* DesignItemResponse[] */ ],
  "match_type": "exact" 
}
```

### 6.4 Create Design Item

`POST /design-items` — **butuh `Authorization`** (role `designer`).

```json
{
  "title": "Modern Minimalist House",
  "description": "A beautiful modern minimalist house design",
  "style": "minimalist",
  "category": "architecture",
  "land_area_min": 100,
  "land_area_max": 200,
  "building_area": 150,
  "num_floors": 2,
  "num_bedrooms": 3,
  "room_type": "bedroom",
  "room_area": 20,
  "estimated_budget": 500000000,
  "price_start_from": 250000000,
  "image_url": "https://example.com/image.jpg",
  "location": "Bandung",
  "feature_ids": ["<uuid>"]
}
```

Validasi (lihat [design_item_dto.go](../modules/design_item/dto/design_item_dto.go)):
- `title`: required, max 200.
- `style`: required, max 50.
- `category`: required, `architecture` | `interior`.
- `estimated_budget`, `price_start_from`: required, `> 0`.
- `num_floors`: 1–10. `num_bedrooms`: 0–20.
- `image_url`: harus URL bila diisi.

### 6.5 Get Design Item by ID

`GET /design-items/:id` — publik.

### 6.6 Update Design Item

`PATCH /design-items/:id` — **butuh `Authorization`** (pemilik design item).

Semua field opsional. Contoh:

```json
{ "title": "Updated Design Item Title" }
```

### 6.7 Delete Design Item

`DELETE /design-items/:id` — **butuh `Authorization`** (pemilik design item).

---

## 7. Features

Base path: `/features` (terdaftar di [modules/design_item/routes.go](../modules/design_item/routes.go)).

### 7.1 Get All Features

`GET /features` — publik.

Response item (`FeatureResponse`):

```json
{ "id": "<uuid>", "name": "Smart Lighting" }
```

---

## 8. User Preferences

Base path: `/user-preferences` — lihat [modules/user_preferences/routes.go](../modules/user_preferences/routes.go).

### 8.1 Get My Preferences

`GET /user-preferences/me` — **butuh `Authorization`** (client).

### 8.2 Create Preferences

`POST /user-preferences` — **butuh `Authorization`** (client).

```json
{
  "preferred_style": "scandinavian",
  "budget_min": 100000000,
  "budget_max": 400000000,
  "preferred_location": "Jakarta"
}
```

Semua field required. `budget_min` dan `budget_max` harus `> 0`.

### 8.3 Update Preferences

`PATCH /user-preferences/me` — **butuh `Authorization`**.

Semua field opsional:

```json
{ "preferred_location": "Surabaya" }
```

Response (`PreferenceResponse`):

```json
{
  "id": "<uuid>",
  "preferred_style": "scandinavian",
  "budget_min": "100000000",
  "budget_max": "400000000",
  "preferred_location": "Surabaya",
  "is_onboarded": true
}
```

---

## 9. Project Request

Base path: `/project-request` — lihat [modules/project_request/routes.go](../modules/project_request/routes.go). **Semua endpoint butuh `Authorization`.**

### 9.1 Create Project Request

`POST /project-request` (role `client`).

```json
{
  "designer_id": "<uuid>",
  "description": "I want to build a modern minimalist house",
  "initial_budget": 5000000000,
  "area_size": 200,
  "location_photo_url": "https://example.com/location.jpg",
  "layout_sketch_url": "https://example.com/sketch.jpg"
}
```

Validasi:
- `designer_id`, `description`: required.
- `initial_budget`, `area_size`: required, `>= 0`.
- Client tidak boleh request ke diri sendiri (`ErrCannotRequestOwnDesign`).

### 9.2 Get Project Request by ID

`GET /project-request/:id`.

### 9.3 Get My Requests

`GET /project-request/my-requests` (role `client` — request yang Anda buat).

### 9.4 Get My Incoming Requests

`GET /project-request/incoming` (role `designer` — request yang masuk ke Anda).

Response (`ProjectRequestResponse`):

```json
{
  "id": "<uuid>",
  "client_id": "<uuid>",
  "designer_id": "<uuid>",
  "description": "...",
  "initial_budget": 5000000000,
  "area_size": 200,
  "location_photo_url": "...",
  "layout_sketch_url": "...",
  "status": "open",
  "conversation_id": "<uuid>"
}
```

---

## 10. Quotation

Base path: `/quotation` — lihat [modules/quotation/routes.go](../modules/quotation/routes.go). **Semua endpoint butuh `Authorization`.**

### 10.1 Create Quotation

`POST /quotation` (role `designer`).

```json
{
  "project_request_id": "<uuid>",
  "scope_of_work": "Complete design and construction of modern house",
  "offered_price": 750000000,
  "duration_days": 120
}
```

Validasi:
- `project_request_id`, `scope_of_work`: required.
- `offered_price`: `>= 0`.
- `duration_days`: `>= 1`.
- Project request harus masih `open` dan designer harus designer dari request tersebut.

### 10.2 Get Quotation by ID

`GET /quotation/:id`.

### 10.3 Accept Quotation

`PUT /quotation/:id/accept` (role `client`, pemilik project request).

Response (`QuotationAcceptResponse`):

```json
{
  "quotation_id": "<uuid>",
  "order_id": "<uuid>",
  "status": "accepted"
}
```

### 10.4 Reject Quotation

`PUT /quotation/:id/reject` (role `client`, pemilik project request).

---

## 11. Upload

Base path: `/upload` — lihat [modules/upload/routes.go](../modules/upload/routes.go) & [upload_controller.go](../modules/upload/controller/upload_controller.go).

### 11.1 Upload File

`POST /upload` — **butuh `Authorization`**.

Content-Type: `multipart/form-data`.

| Field | Tipe | Wajib | Keterangan |
|-------|------|-------|------------|
| `file` | file | ya | File yang akan diunggah |
| `folder` | string | tidak | Folder tujuan di ImageKit (default `general`) |

Response sukses:

```json
{
  "status": true,
  "message": "success upload file",
  "data": { "url": "https://ik.imagekit.io/.../file.jpg" }
}
```

Contoh cURL:

```bash
curl -X POST "$BASE_URL/upload" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -F "file=@./photo.jpg" \
  -F "folder=design"
```

---

## 12. Ringkasan Tabel Endpoint

| Method | Path | Auth | Deskripsi |
|--------|------|:----:|-----------|
| POST | `/auth/register` | – | Daftar user baru |
| POST | `/auth/login` | – | Login → token |
| POST | `/auth/refresh` | – | Tukar refresh token |
| POST | `/auth/logout` | ✓ | Logout |
| POST | `/auth/send-verification-email` | – | Kirim kode verifikasi |
| POST | `/auth/verify-email` | – | Verifikasi email |
| POST | `/auth/send-password-reset` | – | Kirim email reset password |
| POST | `/auth/reset-password` | – | Reset password dengan token |
| GET | `/user` | – | Daftar semua user |
| GET | `/user/me` | ✓ | Profil user saat ini |
| PATCH | `/user/:id` | ✓ | Update user |
| DELETE | `/user/:id` | ✓ | Hapus user |
| GET | `/designers` | – | Daftar designer |
| GET | `/designers/me` | ✓ | Profil designer sendiri |
| GET | `/designers/:id` | – | Detail designer |
| PATCH | `/designers/:id` | ✓ | Update profil designer |
| GET | `/design-items` | – | Daftar design item |
| GET | `/design-items/my-items` | ✓ | Design item milik designer |
| GET | `/design-items/recommendations` | ✓ | Rekomendasi berdasarkan preferensi |
| GET | `/design-items/:id` | – | Detail design item |
| POST | `/design-items` | ✓ | Buat design item |
| PATCH | `/design-items/:id` | ✓ | Update design item |
| DELETE | `/design-items/:id` | ✓ | Hapus design item |
| GET | `/features` | – | Daftar fitur (feature catalog) |
| GET | `/user-preferences/me` | ✓ | Preferensi user |
| POST | `/user-preferences` | ✓ | Buat preferensi |
| PATCH | `/user-preferences/me` | ✓ | Update preferensi |
| POST | `/project-request` | ✓ | Buat project request |
| GET | `/project-request/:id` | ✓ | Detail project request |
| GET | `/project-request/my-requests` | ✓ | Project request milik client |
| GET | `/project-request/incoming` | ✓ | Project request masuk ke designer |
| POST | `/quotation` | ✓ | Buat quotation |
| GET | `/quotation/:id` | ✓ | Detail quotation |
| PUT | `/quotation/:id/accept` | ✓ | Client menerima quotation |
| PUT | `/quotation/:id/reject` | ✓ | Client menolak quotation |
| POST | `/upload` | ✓ | Upload file (multipart) |
