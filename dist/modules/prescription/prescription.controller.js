"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deletePrescriptionHandler = exports.updatePrescriptionHandler = exports.getPrescriptionByIdHandler = exports.getPrescriptionsHandler = exports.createPrescriptionHandler = exports.upload = void 0;
const prescription_service_1 = require("./prescription.service");
const multer_1 = __importDefault(require("multer"));
const path_1 = __importDefault(require("path"));
// Multer configuration for file upload
const storage = multer_1.default.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "uploads/");
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path_1.default.extname(file.originalname));
    },
});
exports.upload = (0, multer_1.default)({ storage });
// Create a new prescription
const createPrescriptionHandler = async (req, res) => {
    try {
        const data = req.body;
        const imageUrl = req.file ? `/uploads/${req.file.filename}` : undefined;
        const prescription = await (0, prescription_service_1.createPrescription)({ ...data, imageUrl });
        res.status(201).json(prescription);
    }
    catch (error) {
        console.error("Error creating prescription:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};
exports.createPrescriptionHandler = createPrescriptionHandler;
// Get all prescriptions
const getPrescriptionsHandler = async (req, res) => {
    try {
        const prescriptions = await (0, prescription_service_1.getPrescriptions)();
        res.status(200).json(prescriptions);
    }
    catch (error) {
        console.error("Error fetching prescriptions:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};
exports.getPrescriptionsHandler = getPrescriptionsHandler;
// Get a prescription by ID
const getPrescriptionByIdHandler = async (req, res) => {
    try {
        const id = parseInt(req.params.id, 10);
        const prescription = await (0, prescription_service_1.getPrescriptionById)(id);
        if (!prescription) {
            return res.status(404).json({ message: "Prescription not found" });
        }
        res.status(200).json(prescription);
    }
    catch (error) {
        console.error("Error fetching prescription by ID:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};
exports.getPrescriptionByIdHandler = getPrescriptionByIdHandler;
// Update a prescription
const updatePrescriptionHandler = async (req, res) => {
    try {
        const id = parseInt(req.params.id, 10);
        const data = req.body;
        const prescription = await (0, prescription_service_1.updatePrescription)(id, data);
        res.status(200).json(prescription);
    }
    catch (error) {
        console.error("Error updating prescription:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};
exports.updatePrescriptionHandler = updatePrescriptionHandler;
// Delete a prescription (soft delete)
const deletePrescriptionHandler = async (req, res) => {
    try {
        const id = parseInt(req.params.id, 10);
        await (0, prescription_service_1.deletePrescription)(id);
        res.status(204).send();
    }
    catch (error) {
        console.error("Error deleting prescription:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};
exports.deletePrescriptionHandler = deletePrescriptionHandler;
