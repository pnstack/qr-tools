
import cv2
import numpy as np
from pyzbar.pyzbar import decode
from qreader import QReader

# create read qr code function
def read_qr_code(image_bytes):
    # Read the image from the uploaded file
    image_np = np.frombuffer(image_bytes, np.uint8)
    img = cv2.imdecode(image_np, cv2.COLOR_BGR2RGB)
    detector = QReader(model_size='l')

    # Decode QR codes from the image

    QRs = detector.detect_and_decode(image=img)
    # Extract QR code data
    qr_data = []
    for QR in QRs:
        qr_data.append(QR)
        
    if qr_data:
        return qr_data
    else:
        return None