# from dotenv import load_dotenv
from werkzeug.debug import DebuggedApplication
from flask import Flask,render_template,redirect,request,url_for
import random
import os

# Load environment variables from .env file
# load_dotenv()
# set some env varible
os.environ['WERKZEUG_DEBUG_PIN'] = str(random.randint(1000, 9999))

# App
app = Flask(__name__,static_folder='templates/static/')

app.wsgi_app = DebuggedApplication(
    app.wsgi_app,
    console_init_func=None,
    show_hidden_frames=False,
    pin_security=True,
    pin_logging=True
)


# Usefull functions
def evalme(me):
    try:
        return eval(me)
    except Exception as error:
        return error

# Routes
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/product')
def product():
    return render_template('product.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/contribute')
def contribute():
    return render_template('contribute.html')

@app.route('/admin/debugme/console',methods=['GET','POST'])
def console():
    result = None
    if request.method == 'POST':
        me = request.form.get('me',None)
        if me is not None:
            result = evalme(me)
    return render_template('console.html',msg=result)



# Run app
if __name__ == '__main__':
    debug = os.getenv('DEBUG', 'False').lower() in ['true', '1']
    app.run(host='0.0.0.0',port=80,debug=debug)