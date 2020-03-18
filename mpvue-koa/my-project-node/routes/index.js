const router = require('koa-router')({
  prefix: '/yhl'
})

const controllers = require('../controllers/index')

// 首页相关接口
router.get('/index/index', controllers.home.index)

// 搜索相关接口
router.get('search/indexaction', controllers.search.index.indexAction)
router.post('/search/addhistoryaction', controllers.search.index.addHistoryAction)
router.post('/search/clearhistoryAction', controllers.search.index.clearHistoryAction)
router.get('/search/helperaction', controllers.search.index.helperAction)    // 搜索提示

// 商品详情
router.get('/goods/detailaction', controllers.goods.index.detailAction)

module.exports = router