const cds = require("@sap/cds");
const simpleErp = require("./simpleerp");

class SimpleERPService extends cds.ApplicationService {
  init() {
    const { Orders, Products } = this.entities;

    this.before("CREATE", Orders, async (req) => {
      this.checkOrder(req);
      this.checkOrderItems(req);
      await simpleErp.calculateOrderID(req);
      this.calculateItemIDs(req);
    });

    this.on("CREATE", Orders, async (req, next) => {
      const { items } = req.data;
      await simpleErp.updateProductStock(items);
      return next();
    });

    this.before("UPDATE", Orders, async (_, req) => {
      this.checkOrder(req);
      this.checkOrderItems(req);
    });

    this.on("pickOrder", (req) => simpleErp.updateOrderStatus(req, 20));
    this.on("shipOrder", (req) => simpleErp.updateOrderStatus(req, 30));
    this.on("completeOrder", (req) => simpleErp.updateOrderStatus(req, 40));
    this.on("cancelOrder", (req) => simpleErp.updateOrderStatus(req, -10));

    this.checkOrder = function (req) {
      if (!req.data.orderAmount) {
        req.error(422, "Order amount is missing.");
      }
      if (!req.data.orderDate) {
        req.error(422, "Order date is missing.");
      }
      if (!req.data.customer_ID) {
        req.error(422, "Customer ID is missing.");
      }
      if (!req.data.orderAmount) {
        req.error(422, "Order amount is missing.");
      }

      this.checkOrderItems(req);
    };

    this.calculateItemIDs = async function (req) {
      req.data.items.forEach((item) => {
        if (!item.itemID) {
          let maxID = req.data.items.reduce(
            (max, item) => Math.max(max, item.itemID),
            0
          );
          req.data.itemID = maxID + 10;
        }
      });
    };

    this.calculateItemAmount = function (req, product, quantity) {
      req.data.itemAmount = product.price * quantity;
      req.data.currency_code = product.currency_code;
    };

    this.checkOrderItems = function (req) {
      req.data.items.forEach(async (item) => {
        if (!item.itemAmount) {
          req.error(422, "Item amount is missing.");
        }
        if (!item.product_ID) {
          req.error(
            422,
            `Product ID is missing for item #${item.itemID}`,
            "product_ID"
          );
        }
        if (!item.quantity) {
          req.error(
            422,
            `Quantity is missing for item #${item.itemID}`,
            "quantity"
          );
        }

        const product = await SELECT.one
          .from(Products)
          .where({ ID: item.product_ID });
        if (!product)
          req.error(422, "Product ${item.product_ID} not found.", "product_ID");

        simpleErp.checkProductStock(req, product, item.quantity);
      });
    };

    return super.init();
  }
}

module.exports = SimpleERPService;
