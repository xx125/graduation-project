const { mysql } = require('../../mysql')

// 商品详情页数据
async function detailAction (ctx) {
  const goodsId = ctx.query.id
  const openId = ctx.query.openId

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
  console.log(badcomm)

  // 商品评论对应的图片
  // const commImg = await mysql('comment_image').where({
  //   'commentId': commentId
  // }).select()
  // console.log(commImg)

  ctx.body = {
    'info': info[0] || [],
    'allcomments': allcomments,
    'goodcomm': goodcomm,
    'badcomm': badcomm
  }
} 

module.exports = {
  detailAction
}