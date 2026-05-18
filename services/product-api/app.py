from flask import Flask, jsonify

app = Flask(__name__)

products = [
    {"id": 1, "name": "Laptop",  "price": 75000},
    {"id": 2, "name": "Phone",   "price": 25000},
    {"id": 3, "name": "Headset", "price": 3000},
]

@app.route("/products")
def get_products():
    return jsonify(products)

@app.route("/health")
def health():
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)