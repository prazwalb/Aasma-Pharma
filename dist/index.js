"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const routes_1 = __importDefault(require("./routes"));
const path_1 = __importDefault(require("path"));
const app = (0, express_1.default)();
const port = 5001;
// Middleware
app.use(express_1.default.json());
const uploadsPath = path_1.default.join(__dirname, "..", "uploads");
app.use("/uploads", express_1.default.static(uploadsPath));
// Routes
app.use(routes_1.default);
// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
