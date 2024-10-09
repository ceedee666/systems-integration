const cds = require("@sap/cds");

class SimpleERPService extends cds.ApplicationService {
  init() {
    const { Customers, Orders, OrderItems, OrderStatus, Products } = this.entities;

    this.before("CREATE", Orders, async (req) => {
      const { maxID } = await SELECT.one`max(orderID) as maxID`.from(Orders);
      req.data.orderID = maxID + 1;
    });

    this.before("UPDATE", OrderItems.drafts, async (req) => {
      const itemDraft = await SELECT.one
        .from(OrderItems.drafts)
        .where({ ID: req.data.ID });

      if (!itemDraft.itemID) {
        const { maxID } = await SELECT.one("max(itemID) as maxID")
          .from(req.query.target)
          .where({ order_ID: itemDraft.order_ID });
        req.data.itemID = maxID + 10;
      }

      let productID = req.data.product_ID
        ? req.data.product_ID
        : itemDraft.product_ID;

      let quantity = req.data.quantity ? req.data.quantity : itemDraft.quantity;
      quantity = quantity ? quantity : 0;

      const product = await SELECT.one
        .from(Products)
        .where({ ID: productID });

      req.data.itemAmount = product.price * quantity;
      req.data.currency_code = product.currency_code;
    });

    this.after("UPDATE", OrderItems.drafts, async (_, req) => {
      if (req.data.itemAmount) {
        const { order_ID } = await SELECT.one("order_ID")
          .from(req.query.target)
          .where({ ID: req.data.ID });
        return this.updateOrderAmount(order_ID, req.query.target);
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
      await this.updateOrderAmount(order_ID, req.query.target);
      return res;
    });

    this.updateOrderAmount = async function (order_ID, target) {
      const itemDrafts = await SELECT.from(target).where({
        order_ID,
      });

      let orderAmount = 0;
      let currency_code;
      itemDrafts.forEach((itemDraft) => {
        if (itemDraft.itemAmount) {
          orderAmount += itemDraft.itemAmount;
          currency_code = itemDraft.currency_code;
        }
      });
      let ID = order_ID;
      return UPDATE(Orders.drafts, ID).with({
        orderAmount,
        currency_code,
      });
    };

    this.on("pickOrder", (req) =>
      UPDATE(req.subject).with({ orderStatus_status: 20 })
    );
    this.on("shipOrder", (req) =>
      UPDATE(req.subject).with({ orderStatus_status: 30 })
    );
    this.on("completeOrder", (req) =>
      UPDATE(req.subject).with({ orderStatus_status: 40 })
    );
    this.on("cancelOrder", (req) =>
      UPDATE(req.subject).with({ orderStatus_status: -10 })
    );

    const calculateButtonAvailability = (res, req, draft = false) => {
      const status = res.orderStatus_status;
      res.pickEnabled = draft ? false : status === 10;
      res.shipEnabled = draft ? false : status === 20;
      res.completeEnabled = draft ? false : status === 30;
      res.cancelEnabled = draft ? false : status === 10;
    };

    this.after("each", Orders, (res, req) => calculateButtonAvailability(res, req));
    this.after("each", Orders.drafts, (res, req) => calculateButtonAvailability(res, req, true));


    return super.init();
  }
}

module.exports = SimpleERPService;
