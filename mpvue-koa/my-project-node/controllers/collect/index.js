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
    await mysql('collect').insert({
      'user_id': openId,
      'goods_id': goodsId
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

module.exports = {
  addCollect
}