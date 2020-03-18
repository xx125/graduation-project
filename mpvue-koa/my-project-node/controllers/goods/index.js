const { mysql } = require('../../mysql')

// 商品详情页数据
async function detailAction (ctx) {
  const goodsId = ctx.query.id
  const openId = ctx.query.openId
  // 商品信息
  const info = await mysql('food').where({
    'id': goodsId
  }).select()
  ctx.body = {
    'info': info
  }
} 

module.exports = {
  detailAction
}