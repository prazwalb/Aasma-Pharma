"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteOrderHandler = exports.updateOrderHandler = exports.getOrderByIdHandler = exports.getOrderByPrescriptionIdHandler = exports.getOrdersHandler = exports.createOrderHandler = void 0;
const order_service_1 = require("./order.service");
// Create a new order
const createOrderHandler = async (req, res) => {
    try {
        const data = req.body;
        const order = await (0, order_service_1.createOrder)(data);
        res.status(201).json(order);
    }
    catch (error) {
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
};
exports.createOrderHandler = createOrderHandler;
// Get all orders
const getOrdersHandler = async (req, res) => {
    try {
        const orders = await (0, order_service_1.getOrders)();
        res.status(200).json(orders);
    }
    catch (error) {
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
};
exports.getOrdersHandler = getOrdersHandler;
// Get an order by prescription ID
const getOrderByPrescriptionIdHandler = async (req, res) => {
    try {
        const id = parseInt(req.params.id, 10);
        const orders = await (0, order_service_1.getOrderByPrescriptionId)(id);
        res.status(200).json(orders);
    }
    catch (error) {
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
};
exports.getOrderByPrescriptionIdHandler = getOrderByPrescriptionIdHandler;
// Get an order by ID
const getOrderByIdHandler = async (req, res) => {
    try {
        const id = parseInt(req.params.id, 10);
        const order = await (0, order_service_1.getOrderById)(id);
        if (!order) {
            return res.status(404).json({ message: "Order not found" });
        }
        res.status(200).json(order);
    }
    catch (error) {
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
};
exports.getOrderByIdHandler = getOrderByIdHandler;
// Update an order
const updateOrderHandler = async (req, res) => {
    try {
        const id = parseInt(req.params.id, 10);
        const data = req.body;
        const order = await (0, order_service_1.updateOrder)(id, data);
        res.status(200).json(order);
    }
    catch (error) {
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
};
exports.updateOrderHandler = updateOrderHandler;
// Delete an order (soft delete)
const deleteOrderHandler = async (req, res) => {
    try {
        const id = parseInt(req.params.id, 10);
        await (0, order_service_1.deleteOrder)(id);
        res.status(204).send();
    }
    catch (error) {
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
};
exports.deleteOrderHandler = deleteOrderHandler;
