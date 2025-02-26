## Quick Start

### Clone the repository

```bash
git clone --recurse-submodules https://github.com/panjd123/open-webui-ruc.git
# or
git clone --recurse-submodules git@github.com:panjd123/open-webui-ruc.git
```

### Frontend (debug only)

```bash
cp -RPp .env.example .env
npm install
npm run dev
```

### Backend

```bash
cd backend
conda create --name open-webui python=3.11
conda activate open-webui
pip install -r requirements.txt -U
sh dev.sh
```

### Fake vruc oauth2 for development

```bash
conda activate open-webui
cd fake-vruc-oauth2
python main.py
```

## Known Bugs

If you deploy the frontend and backend separately, auth will not work correctly.

After login, it will redirect to `http://localhost:8080/auth#token=xxxx`, but backend(8080) will not handle this request, it is handled by frontend server (5137). 

You need to manually update the url to `http://localhost:5137/auth#token=xxxx` to login.

### How to solve

In production, run `npm run build`, then run `sh dev.sh` in backend folder.

It will serve the frontend and backend in the same port.

## Note

1. Based on v0.5.15, there are some bugs in latest version, so we use v0.5.15: https://github.com/open-webui/open-webui/discussions/10793
2. If you can't reach backend, try to restart the frontend/backend server (order matters?).
