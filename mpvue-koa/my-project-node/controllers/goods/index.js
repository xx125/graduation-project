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

  // 判断是否收藏过
  const iscollect = await mysql('collect').where({
    'user_id': openId,
    'goods_id': goodsId
  }).select()
  let collected = false
  if (iscollect.length > 0) {
    collected = true
  }

  // 判断用户的购物车里是否有该商品
  const oldNumber = await mysql('cart').where({
    'user_id': openId,
  }).column('number').select()
  let allnumber = 0
  if (oldNumber.length > 0) {
    for (let i = 0; i < oldNumber.length; i++) {
      const element = oldNumber[i]    // {number: 1}
      allnumber += element.number
    }
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
    'allnumber': allnumber
  }
} 

module.exports = {
  detailAction
}