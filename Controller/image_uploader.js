const express = require('express');
const multer = require('multer');
const path = require('path');
const fs = require('fs/promises');
const { v4: uuidv4 } = require('uuid');

async function upload(req,res,folder){
     try {
        const uploadDir = path.join('C:\Users\sanjay\Desktop\Project\Image',folder );
        await fs.mkdir(uploadDir, { recursive: true });

        // Temporary storage before renaming
        const storage = multer.diskStorage({
            destination: function (req, file, cb) {
                cb(null, uploadDir);
            },
            filename: function (req, file, cb) {
                cb(null, 'temp_' + file.originalname);
            }
        });

        const upload = multer({ storage }).single('image');

        const uploadPromise = () =>
            new Promise((resolve, reject) => {
                upload(req, res, function (err) {
                    if (err) reject(err);
                    else resolve(req.file);
                });
            });

        const uploadedFile = await uploadPromise();

        if (!uploadedFile) {
            // return res.status(400).send('No image uploaded');
            return 400;
        }

        // Generate unique filename with original extension
        const uniqueId = uuidv4();
        const ext = path.extname(uploadedFile.originalname);
        const newFilename = `${uniqueId}${ext}`;
        const oldPath = path.join(uploadDir, uploadedFile.filename);
        const newPath = path.join(uploadDir, newFilename);
        console.log(newFilename)
        // Rename file
        await fs.rename(oldPath, newPath);
        
        return newFilename;
    } catch (err) {
        console.error('Error:', err);
        // res.status(500).send('Server error');
        return 500;
    }
}
module.exports=upload