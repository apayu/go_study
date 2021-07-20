# README

## API route

### 用戶登入

```
POST /api/v1/login
```
#### params

- email: 用戶 email
- password: 用戶密碼

### 用戶登出

```
POST api/v1/logout
```

#### params

- auth_token: 用戶 token

### 用戶註冊

```
POST /api/v1/users
```
#### params

- email: 用戶 email
- password: 用戶密碼

### 查詢課程基本資訊

```
GET /api/v1/courses/:id
```
#### params

- id: 課程 id
- auth_token: 用戶 token

### 購買課程

```
POST /api/v1/course_inventories
```
#### params

- id: 課程 id
- auth_token: 用戶 token

### 查詢訂單

```
GET /api/v1/transactions
```
#### params

- auth_token: 用戶 token
- category_id: 課程類別 id (options)
- valid_course: 有效課程(boolean) (options)


