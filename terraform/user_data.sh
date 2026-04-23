#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "===== Starting Free Tier Mock AI Setup ====="

# Cài đặt Python flask để làm API server siêu nhẹ
apt-get update -y
apt-get install -y python3-flask

# Tạo file app.py để trả về JSON giống AI thật
cat <<EOF > /home/ubuntu/app.py
from flask import Flask, request, jsonify
import datetime

app = Flask(__name__)

@app.route('/', methods=['GET'])
def health():
    return "OK", 200

@app.route('/v1/chat/completions', methods=['POST'])
def chat():
    return jsonify({
        "id": "chatcmpl-123",
        "object": "chat.completion",
        "created": int(datetime.datetime.now().timestamp()),
        "model": "mock-ai-model",
        "choices": [{
            "index": 0,
            "message": {
                "role": "assistant",
                "content": "Chào bạn! Đây là phản hồi từ AI (chạy trên hạ tầng Free Tier của bạn). Bài Lab của bạn đã thành công rực rỡ!"
            },
            "finish_reason": "stop"
        }]
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
EOF

# Chạy server ở background
nohup python3 /home/ubuntu/app.py > /home/ubuntu/app.log 2>&1 &

echo "===== Mock AI Server is running on port 8000 ====="