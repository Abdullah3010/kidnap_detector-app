from flask import Flask, request ,send_file



app = Flask(__name__)

@app.route('/api/upload', methods=['POST'])
def upload_image():
    # Check if the request contains a file
    if 'image' not in request.files:
        return 'No image file provided', 400

    image_file = request.files['image']
    image_file
    # Perform validation on the image file if required

    # Save the image file to a desired location
    image_file.save('saved_image/image.jpg')

    return 'Image uploaded successfully'


@app.route('/api/get_image', methods=['GET'])
def get_image():
    # Replace 'path/to/image.jpg' with the actual path to your image file
    image_path = 'saved_image/image.jpg'
    return send_file(image_path, mimetype='image/jpeg')

if __name__ == '__main__':
    app.run(debug=True)