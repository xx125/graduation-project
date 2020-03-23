<template>
  <div class="cart">
    <div class="address" v-if="address.name" @click="toAddressList">
      <div class="item">
        <div class="list">
          <div class="addresslist">
            <div>
              <span>{{address.name}}</span>
              <div class="moren">默认</div>
            </div>
            <div class="info">
              <p>{{address.mobile}}</p>
              <p>{{address.address+address.address_detail}}</p>
            </div>
            <div></div>
          </div>
        </div>
      </div>
    </div>
    <div class="seladdress" v-else @click="toAdd">请选择默认地址</div>

    <div class="orderbox">
      <div class="item">
        <div>商品合计</div>
        <div>¥ {{allPrice}}</div>
      </div>
      <div class="item">
        <div>配送费</div>
        <div>免配送费</div>
      </div>
      <div class="item">
        <div>优惠券</div>
        <div>暂无</div>
      </div>
    </div>

    <div class="cartlist">
      <div class="item" v-for="(item, index) in carts" :key="index">
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
            <div class="num">✖️ {{item.number}}</div>
          </div>
        </div>
      </div>
    </div>
    <div class="fixed">
      <div class="right">
        <div>¥ {{allPrice}}</div>
        <div @click="orderDown">提交订单</div>
      </div>
    </div>
  </div>
</template>

<script>
import { get, post, getStorageOpenid } from '../../utils'

export default {
  data () {
    return {
      openId: '',
      carts: [],
      Listids:[],
      address: {},
      addressId: ''
    }
  },
  onShow () {
    if (wx.getStorageSync('addressId')) {
      this.addressId = wx.getStorageSync('addressId')
    }
    this.openId = getStorageOpenid()
    this.getListData()
    this.getDetail()
  },
  methods: {
    async getListData () {
      const data = await get('/cart/detailaction', {
        openId: this.openId
      })
      // console.log(data)
      this.carts = data.carts
    },

    async getDetail () {
      const data = await get('/order/detailAction', {
        openId: this.openId,
        addressId: this.addressId
      })
      console.log(data)
      this.address = data.address
    },

    async orderDown () {
      console.log('123')
      for (let i = 0; i < this.carts.length; i++) {
        const element = this.carts[i]
        this.Listids.push(element.goods_id)
      }
      let newgoodsid = []
      for (let i = 0; i < this.Listids.length; i++) {
        const element = this.Listids[i]
        if (element) {
          newgoodsid.push(element)
        }
      }
      let goodsId = newgoodsid.join(',')    // 把数据拼成数组，以逗号分隔开
      console.log(goodsId)
      const data = await post('/order/orderDown', {
          openId: this.openId,
          goodsId: goodsId,
          allPrice: this.allPrice,
          // goodsId: this.goodsId,
          number: this.number
      })
      console.log(data)
      if (data) {
        wx.showToast({
          icon: 'success',
          title: '下单成功',
          duration: 1500
        })
        wx.switchTab({
          url: '/pages/index/main'
        })
      }
    },

    toAdd () {
      wx.navigateTo({
        url: '/pages/addaddress/main'
      })       
    },
    toAddressList () {
      wx.navigateTo({
        url: '/pages/addressSelect/main'
      })
    }
      
  },
  computed: {
    allPrice () {
      let Price = 0
      for (let i = 0; i < this.carts.length; i++) {
        if (this.carts[i]) {
          console.log(this.carts[i])
          Price += this.carts[i].price * this.carts[i].number
        }
      }
      return Price
    }
  }
}
</script>

<style lang="less" scoped>
@import './style.less';
</style>