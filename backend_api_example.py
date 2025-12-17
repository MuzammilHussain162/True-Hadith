"""
Flask Backend API Example
This file shows the expected Flask endpoints that should be implemented
to work with the Flutter app's authentication flow.

Install required packages:
pip install flask flask-cors psycopg2-binary python-dotenv

Database Setup:
Make sure PostgreSQL is running and create the database with the schema provided.
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
import psycopg2
from psycopg2.extras import RealDictCursor
from datetime import datetime
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
CORS(app)  # Enable CORS for Flutter app

# Database configuration
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'database': os.getenv('DB_NAME', 'true_hadith_db'),
    'user': os.getenv('DB_USER', 'postgres'),
    'password': os.getenv('DB_PASSWORD', 'password'),
    'port': os.getenv('DB_PORT', '5432')
}


def get_db_connection():
    """Create and return a database connection"""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        return conn
    except Exception as e:
        print(f"Database connection error: {e}")
        raise


@app.route('/api/auth/register', methods=['POST'])
def register_user():
    """
    Register a new user after Firebase authentication
    
    Expected JSON body:
    {
        "firebase_uid": "string",
        "username": "string",
        "email": "string"
    }
    
    Returns:
    {
        "user_id": int,
        "username": "string",
        "created_at": "ISO datetime string"
    }
    """
    try:
        data = request.get_json()
        
        if not data:
            return jsonify({'message': 'No data provided'}), 400
        
        firebase_uid = data.get('firebase_uid')
        username = data.get('username')
        email = data.get('email')
        
        if not all([firebase_uid, username, email]):
            return jsonify({'message': 'Missing required fields'}), 400
        
        conn = get_db_connection()
        cursor = conn.cursor(cursor_factory=RealDictCursor)
        
        # Check if user already exists
        cursor.execute(
            "SELECT user_id FROM users WHERE FK_firebase_uid = %s",
            (firebase_uid,)
        )
        existing_user = cursor.fetchone()
        
        if existing_user:
            cursor.close()
            conn.close()
            return jsonify({'message': 'User already exists'}), 409
        
        # Insert new user
        cursor.execute(
            """
            INSERT INTO users (FK_firebase_uid, user_name, name_email, created_at)
            VALUES (%s, %s, %s, %s)
            RETURNING user_id, user_name, created_at
            """,
            (firebase_uid, username, email, datetime.now())
        )
        
        user = cursor.fetchone()
        conn.commit()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            'user_id': user['user_id'],
            'username': user['user_name'],
            'created_at': user['created_at'].isoformat(),
        }), 201
        
    except Exception as e:
        if conn:
            conn.rollback()
            cursor.close()
            conn.close()
        return jsonify({'message': f'Registration failed: {str(e)}'}), 500


@app.route('/api/auth/login', methods=['POST'])
def login_user():
    """
    Login user and return user data
    
    Expected JSON body:
    {
        "firebase_uid": "string"
    }
    
    Returns:
    {
        "user_id": int,
        "username": "string",
        "created_at": "ISO datetime string"
    }
    """
    try:
        data = request.get_json()
        
        if not data:
            return jsonify({'message': 'No data provided'}), 400
        
        firebase_uid = data.get('firebase_uid')
        
        if not firebase_uid:
            return jsonify({'message': 'Missing firebase_uid'}), 400
        
        conn = get_db_connection()
        cursor = conn.cursor(cursor_factory=RealDictCursor)
        
        # Find user by firebase_uid
        cursor.execute(
            """
            SELECT user_id, user_name, created_at
            FROM users
            WHERE FK_firebase_uid = %s
            """,
            (firebase_uid,)
        )
        
        user = cursor.fetchone()
        
        cursor.close()
        conn.close()
        
        if not user:
            return jsonify({'message': 'User not found'}), 404
        
        return jsonify({
            'user_id': user['user_id'],
            'username': user['user_name'],
            'created_at': user['created_at'].isoformat(),
        }), 200
        
    except Exception as e:
        if conn:
            cursor.close()
            conn.close()
        return jsonify({'message': f'Login failed: {str(e)}'}), 500


@app.route('/api/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({'status': 'ok', 'message': 'API is running'}), 200


if __name__ == '__main__':
    # Run on all interfaces, port 5000
    app.run(host='0.0.0.0', port=5000, debug=True)

