from src import app
from fastapi import UploadFile
from src.utils.qr import read_qr_code

@app.post("/qr/decode")
async def qr_decode(img: UploadFile):
    try:        
        qr_data = read_qr_code(img.file.read())       
        if qr_data:
            return {"data": qr_data, "errorCode": "0", "errorMessage": None}            
        else:
            return {"data": None, "errorCode": "1", "errorMessage": "No QR code found in the image."}
    except Exception as e:
        print(e)
        return {"data": None, "errorCode": "1", "errorMessage": "No QR code found in the image."}