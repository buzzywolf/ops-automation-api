from flask import Flask, jsonify
import subprocess
import json

app = Flask(__name__)#משתנה זה יחזיר לנו את השרת שהרמנו
# מגדירים לאיזו כתובת הלקוח נכנס (במקרה הזה - דף הבית)
@app.route('/')
def display:
    sc_path=r"C:\Users\User\AutoLog\cs_scripts\logPerhh.ps1"
    command = ["powershell.exe", "-ExecutionPolicy", "Bypass", "-File", sc_path]
    result = subprocess.run(command, capture_output=True, text=True)
    myattacklist=json.loads(result.stdout)
    return jsonify(myattacklist)
# השורה שמפעילה את השרת
if __name__ == '__main__':
    app.run(debug=True)

