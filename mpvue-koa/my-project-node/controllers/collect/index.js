const { mysql } = require('../../mysql')

// 添加收藏
async function addCollect (ctx) {
  const { openId, goodsId } = ctx.request.body
  // 判断是否已经收藏
  const isCollect = await mysql('collect').where({
    'user_id': openId,
    'goods_id': goodsId
  }).select()
  if (isCollect.length == 0) {
    const goods = await mysql('food').where({
      'id': goodsId
    }).select()
    // console.log(goods)
    // 如果不存在
    const { name, price, image } = goods[0]
    await mysql('collect').insert({
      'user_id': openId,
      'goods_id': goodsId,
      name,
      price,
      image
    })
    ctx.body = {
      data: 'collect'
    }
  } else {
    await mysql('collect').where({
      'user_id': openId,
      'goods_id': goodsId
    }).del()
    ctx.body = {
      data: 'uncollect'
    }
  }
}

// 获取收藏列表
async function detailAction (ctx) {
  const openId = ctx.query.openId

  const collectList = await mysql('collect').where({
    'user_id': openId
  }).select()

  ctx.body = {
    'collectList': collectList
  }
}

module.exports = {
  addCollect,
  detailAction
}