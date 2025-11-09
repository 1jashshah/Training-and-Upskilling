from flask import Flask, jsonify
app = Flask(__name__)

users = [{"id": 1, "name": "Jash", "email": "jash@example.com"}]

@app.route("/users")
def get_users():
    return jsonify(users)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=6000)

