# 部署指南

1. 环境配置

    ```bash
    # sudo apt-get install git

    # miniconda
    bash Miniconda3-latest-Linux-x86_64.sh -b
    ~/miniconda3/bin/conda init

    # nodejs/npm
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    nvm install --lts

    # repo
    git clone https://github.com/panjd123/open-webui-ruc.git
    cd open-webui-ruc

    # frontend
    npm install
    npm run build

    # backend
    cd backend
    conda env create --name webui python=3.12
    conda activate webui
    pip install -r requirements.txt
    ```


2. 修改一些参数

    1. `backend/prod.sh.example` 是启动脚本，你需要补充其中所有标注了 `TODO` 的地方，你可以参考腾讯文档。
    2. `backend/prod.sh` 的使用方法是

        ```bash
        # cp prod.sh.example prod.sh
        bash prod.sh start
        bash prod.sh stop
        bash prod.sh restart
        ```

        需要注意其中开头的参数，`WORKERS` 决定了启动的线程数，默认是 4，`BASE_PORT` 是端口的起点，默认是 8001，比如 4 个进程就会变成起在 8001, 8002, 8003, 8004 上，这需要和 nginx 的配置文件保持一致
    3. `backend/nginx.conf.example` 是 nginx 配置文件的示例，目前没有配置 ssl，所以有了证书还要改一下相关内容，现在是写在 80 端口上，你需要注意的就是开头 `upstream uvicorn_backend` 中的配置，其中的 `server` 需要和 `prod.sh` 中你启动的一致。

3. open-webui 的小细节

    - 模型他默认是不公开给 user 的，你需要在管理员界面里改一下。

4. 最后

    nginx 的配置文件一般放到 `/etc/nginx/sites-enabled/` 下就行了

    ```bash
    cp backend/nginx.conf.example /etc/nginx/sites-enabled/webui.conf
    # 修改一下：1. server_name 2. upstream 3. ssl(443)
    ```

    ```bash
    nginx -t
    nginx -s reload
    ```

    ```
    cd ~/open-webui-ruc/backend
    conda activate webui
    bash prod.sh start
    ```

5. TODO

    - 没有测试 litellm 限流后的效果
    - 没有测试 nginx 的负载均衡（能跑，但是不知道效果怎么样）
    - 没有测试 nginx 的 ssl
