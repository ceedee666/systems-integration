const cds = require("@sap/cds");
const simpleErp = require("./simpleerp");

class SimpleERPUIService extends cds.ApplicationService {
  init() {
    const { Orders, OrderItems, Products } = this.entities;

    this.before("CREATE", Orders, async (req) => {
      await simpleErp.calculateOrderID(req);
    });
    
    this.on("CREATE", Orders, async (req, next) => {
      const { items } = req.data;
      await simpleErp.updateProductStock(items);
      return next();
    });

    this.before("UPDATE", OrderItems.drafts, async (req) => {
      const itemDraft = await SELECT.one
        .from(OrderItems.drafts)
        .where({ ID: req.data.ID });

      const productID = req.data.product_ID
        ? req.data.product_ID
        : itemDraft.product_ID;

      const product = await SELECT.one.from(Products).where({ ID: productID });
      if (!product) {
        req.error(422, "Product not found", "product_ID");
      }
      let quantity = req.data.quantity ? req.data.quantity : itemDraft.quantity;
      quantity = quantity ? quantity : 0;

      await simpleErp.calculateItemID(req, itemDraft);
      simpleErp.calculateItemAmount(req, product, quantity);
      simpleErp.checkProductStock(req, product, quantity);
    });

    this.after("UPDATE", OrderItems.drafts, async (_, req) => {
      if (req.data.itemAmount) {
        return simpleErp.updateOrderAmount(req);
      }
    });

    this.on("DELETE", OrderItems.drafts, async (req, next) => {
      // Find out which order is affected before the delete
      const { order_ID } = await SELECT.one("order_ID")
        .from(req.query.target)
        .where({ ID: req.data.ID });
      // Delete handled by generic handlers
      const res = await next();
      // After the delete, update the totals
      await simpleErp.updateOrderAmount(req, order_ID);
      return res;
    });

    this.on("pickOrder", (req) =>
      simpleErp.updateOrderStatus(req, 20)
    );
    this.on("shipOrder", (req) =>
      simpleErp.updateOrderStatus(req, 30)
    );
    this.on("completeOrder", (req) =>
      simpleErp.updateOrderStatus(req, 40)
    );
    this.on("cancelOrder", (req) =>
      simpleErp.updateOrderStatus(req, -10)
    );

    this.after("each", Orders, (res, req) =>
      simpleErp.calculateButtonAvailability(res, req)
    );
    this.after("each", Orders.drafts, (res, req) =>
      simpleErp.calculateButtonAvailability(res, req, true)
    );

    return super.init();
  }
}

module.exports = SimpleERPUIService;
