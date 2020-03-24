<template>
  <div class="order">
    <div class="title">
      <span>———</span>
      <span>我的订单</span>
      <span>———</span>
    </div>

    <div class="cartlist">
      <div class="item" v-for="(item, index) in orders" :key="index">
        <div class="con">
          <div class="left">
            <div class="img">
              <img :src="item.image">
            </div>
            <div class="info">
              <p>{{item.goods_name}}</p>
              <p>¥{{item.price}}</p>
            </div>
          </div>
          <div class="right">
            <div class="num">✖️{{item.number}}</div>
            <div class="price">¥  {{allprice}}</div>
          </div>
        </div>
        <div class="bottom">
            <button class="comment">评价</button>
            <button class="again">再来一单</button>
          </div>
      </div>
    </div>

  </div>
</template>

<script>
import { get, post, getStorageOpenid } from '../../utils'

export default {
  data () {
    return {
      orders: [],
      openId: '',
      allprice: 0
    }
  },
   onShow () {
    this.openId = getStorageOpenid()
    this.getListData()
  },
  methods: {
    async getListData () {
      const data = await get('/order/detailAction', {
        openId: this.openId
      })
      console.log(data)
      this.orders = data.orders
      this.orders.map((item) => {
        this.allprice += item.price * item.number
      })
    }
  }
}
</script>

<style lang="less" scoped>
@import './style.less';
</style>