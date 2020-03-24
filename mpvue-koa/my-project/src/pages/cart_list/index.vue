<template>
  <div class="cart">
    <div class="address">
      <div class="item">
        <div class="list">
          <div class="addresslist">
            <div class="mess">凭手机尾号取餐哦~</div>
            <input type="text" placeholder="姓氏" class="text">
            <input type="text" placeholder="手机尾号" class="text" v-model="number">
            <div></div>
          </div>
        </div>
      </div>
    </div>
    <div class="orderbox">
      <div class="item">
        <div>商品合计</div>
        <div>¥ {{allPrice}}</div>
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
      addressId: '',
      number: ''
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
      if (this.number) {
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
      } else {
        wx.showToast({
          title: '请输入手机尾号~',
          icon: 'none',
          duration: 1500
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