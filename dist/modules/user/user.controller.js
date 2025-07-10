"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.loginUserHandler = exports.deleteUserHandler = exports.updateUserHandler = exports.getUserByIdHandler = exports.getUsersHandler = exports.createUserHandler = void 0;
const user_service_1 = require("./user.service");
// Create a new user
const createUserHandler = async (req, res) => {
    try {
        const data = req.body;
        const user = await (0, user_service_1.createUser)(data);
        res.status(201).json(user);
    }
    catch (error) {
        console.error("Error creating user:", error);
        res.status(500).json({
            message: "Failed to create user",
            error: error instanceof Error ? error.message : String(error),
        });
    }
};
exports.createUserHandler = createUserHandler;
// Get all users
const getUsersHandler = async (req, res) => {
    try {
        const users = await (0, user_service_1.getUsers)();
        res.status(200).json(users);
    }
    catch (error) {
        console.error("Error fetching users:", error);
        res.status(500).json({
            message: "Failed to fetch users",
            error: error instanceof Error ? error.message : String(error),
        });
    }
};
exports.getUsersHandler = getUsersHandler;
// Get a user by ID
const getUserByIdHandler = async (req, res) => {
    try {
        const id = parseInt(req.params.id, 10);
        const user = await (0, user_service_1.getUserById)(id);
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }
        res.status(200).json(user);
    }
    catch (error) {
        console.error(`Error fetching user with ID ${req.params.id}:`, error);
        res.status(500).json({
            message: "Failed to fetch user",
            error: error instanceof Error ? error.message : String(error),
        });
    }
};
exports.getUserByIdHandler = getUserByIdHandler;
// Update a user
const updateUserHandler = async (req, res) => {
    try {
        const id = parseInt(req.params.id, 10);
        const data = req.body;
        const user = await (0, user_service_1.updateUser)(id, data);
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }
        res.status(200).json(user);
    }
    catch (error) {
        console.error(`Error updating user with ID ${req.params.id}:`, error);
        res.status(500).json({
            message: "Failed to update user",
            error: error instanceof Error ? error.message : String(error),
        });
    }
};
exports.updateUserHandler = updateUserHandler;
// Delete a user (soft delete)
const deleteUserHandler = async (req, res) => {
    try {
        const id = parseInt(req.params.id, 10);
        const result = await (0, user_service_1.deleteUser)(id);
        if (!result) {
            return res.status(404).json({ message: "User not found" });
        }
        res.status(204).send();
    }
    catch (error) {
        console.error(`Error deleting user with ID ${req.params.id}:`, error);
        res.status(500).json({
            message: "Failed to delete user",
            error: error instanceof Error ? error.message : String(error),
        });
    }
};
exports.deleteUserHandler = deleteUserHandler;
// User login
const loginUserHandler = async (req, res) => {
    try {
        const data = req.body;
        const user = await (0, user_service_1.loginUser)(data);
        if (!user) {
            return res.status(401).json({ message: "Invalid credentials" });
        }
        res.status(200).json(user);
    }
    catch (error) {
        console.error("Error during login:", error);
        res.status(500).json({
            message: "Login failed",
            error: error instanceof Error ? error.message : String(error),
        });
    }
};
exports.loginUserHandler = loginUserHandler;
