PORT="${PORT:-8080}"
export ENABLE_LOGIN_FORM=True
export ENABLE_SIGNUP=False
export ENABLE_OAUTH_SIGNUP=True
export DEFAULT_USER_ROLE="user"
uvicorn open_webui.main:app --port $PORT --host 0.0.0.0 --forwarded-allow-ips '*' --reload