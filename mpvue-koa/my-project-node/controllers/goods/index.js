const { mysql } = require('../../mysql')

// 商品详情页数据
async function detailAction (ctx) {
  const goodsId = ctx.query.id
  const openId = ctx.query.openId
  // console.log(goodsId)

  // 商品信息
  const info = await mysql('food').where({
    'id': goodsId
  }).select()
  // console.log(info)

  // 商品评论
  const allcomments = await mysql('comments').where({
    'foodId': goodsId
  }).select()
  // console.log(comments)

  const goodcomm = await mysql('comments').where('rateType', 'like', '推荐').where({
    'foodId': goodsId
  }).select()
  // console.log(goodcomm)

  const badcomm = await mysql('comments').where('rateType', 'like', '吐槽').where({
    'foodId': goodsId
  }).select()
  // console.log(badcomm)

  // 判断是否在购物车里
  const iscart = await mysql('cart').where({
    'user_id': openId,
    'goods_id': goodsId
  }).select()
  let showdom = false
  if (iscart.length > 0) {
    showdom = true
  }

  // 购物车里该商品的数量
  const cartnumber = await mysql('cart').where({
    'user_id': openId,
    'goods_id': goodsId
  }).column('number').select()

  // 判断购物车里是否有商品
  const hasfood = await mysql('cart').where({
    'user_id': openId
  }).select()
  let has = false
  if (hasfood.length > 0) {
    has = true
  }
  // console.log(has)

  // 判断是否收藏过
  const iscollect = await mysql('collect').where({
    'user_id': openId,
    'goods_id': goodsId
  }).select()
  let collected = false
  if (iscollect.length > 0) {
    collected = true
  }


  // 商品评论对应的图片
  // const commImg = await mysql('comment_image').where({
  //   'commentId': commentId
  // }).select()
  // console.log(commImg)

  ctx.body = {
    'info': info[0] || [],
    'allcomments': allcomments,
    'goodcomm': goodcomm,
    'badcomm': badcomm,
    'collected': collected,
    'showdom': showdom,
    'cartnumber': cartnumber[0],
    'has': has
  }
} 

module.exports = {
  detailAction
}