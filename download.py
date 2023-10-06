from qreader import QReader
import cv2
detector = QReader(model_size='l')
# Read the image
img = cv2.cvtColor(cv2.imread('demo.png'), cv2.COLOR_BGR2RGB)
# Detect and decode the QRs within the image
QRs = detector.detect_and_decode(image=img)
# Print the results
for QR in QRs:
    print(QR)