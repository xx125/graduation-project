const router = require('koa-router')({
  prefix: '/yhl'
})

const controllers = require('../controllers/index')

// 首页相关接口
router.get('/index/index', controllers.home.index)

// 搜索相关接口
router.get('/search/indexaction', controllers.search.index.indexAction)
router.post('/search/addhistoryaction', controllers.search.index.addHistoryAction)
router.post('/search/clearhistoryAction', controllers.search.index.clearHistoryAction)
router.get('/search/helperaction', controllers.search.index.helperAction)    // 搜索提示

// 商品详情
router.get('/goods/detailaction', controllers.goods.index.detailAction)

// 收藏相关的接口
router.post('/collect/addcollect', controllers.collect.index.addCollect)

// 订单相关接口
// router.post('/order/submitAction', controllers.order.index.submitAction)
router.get('/order/detailAction', controllers.order.index.detailAction)
router.post('/order/orderDown', controllers.order.index.orderDown)


// 购物车相关接口
router.get('/cart/detailaction', controllers.cart.index.detailAction)
router.post('/cart/addCart', controllers.cart.index.addCart)
router.post('/cart/reduceCart', controllers.cart.index.reduceCart)
router.post('/cart/addAction', controllers.cart.index.addAction)
router.post('/cart/reduceAction', controllers.cart.index.reduceAction)
router.post('/cart/deletecart', controllers.cart.index.deleteCart)
// router.get('/cart/cartList', controllers.cart.index.cartList)

// 食物相关接口
router.get('/food/index', controllers.food.index.foodDetail)

// 地址相关接口
router.get('/address/getListAction', controllers.address.index.getListAction)
router.get('/address/detailAction', controllers.address.index.detailAction)
router.post('/address/saveAction', controllers.address.index.saveAction)

module.exports = router