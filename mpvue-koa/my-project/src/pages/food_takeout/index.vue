<template>
  <div class="index">
    <div class="search">
      <div @click="toSearch">
        <input type="text" placeholder="搜索商品" />
        <span class="icon"></span>
      </div>
    </div>
    <div class="food">
      <scroll-view
        class="menu-wrapper"
        :scroll-into-view="navId"
        scroll-with-animation="true"
        scroll-y
      >
        <ul class="menu-ul">
          <li
            class="menu-item"
            v-for="(item,index) in list"
            :id="'nav_'+index"
            :class="index===currentIndex ? 'current' : ''"
            :key="index"
            @click="selectMenu(item.name, index)"
          >{{item.name}}</li>
        </ul>
      </scroll-view>
      <scroll-view
        scroll-y
        @scroll="onScroll"
        :scroll-into-view="contentId"
        scroll-with-animation="true"
        class="foods-wrapper"
        :style="{'height': '1300rpx'}"
      >
        <ul>
          <li class="food-list food-list-hook" :key="i">
            <div v-for="(item, index) in goods" :key="index" class="span">
              <span>{{item.foodType}}</span>
            </div>
            <div class="container" v-for="(item, index) in goods" :key="index">
              <div class="img" @click="goodsPage(item.id)">
                <img class="image" :src="item.image" mode="widthFix" />
              </div>
              <div class="content">
                <div @click="goodsPage(item.id)">
                  <div class="name">{{item.name}}</div>
                  <div class="desc">{{item.description}}</div>
                  <div class="extra">
                    <span class="count">月售{{item.sellCount}}份</span>
                    <span>好评率{{item.rating}}%</span>
                  </div>
                  <div class="price">
                    <span class="now">¥{{item.price}}</span>
                    <span class="old" v-if="item.oldPrice">¥{{item.oldPrice}}</span>
                  </div>
                </div>
                <div class="shopCart">
                  <transition name="fade">
                    <!-- <div @click="reduceCart" :class="[showdom ? 'text' : 'hide']">-</div> -->
                    <!-- <div :class="[showdom ? 'number' : 'hide']">{{cartnumber}}</div> -->
                    <!-- <div @click="reduceCart(item.id)" :class="[showdom ? 'text' : 'hide']">-</div> -->
                    <!-- <div class="number">0</div> -->
                    <!-- <div :class="[showdom ? 'number' : 'hide']">{{cartnumber}}</div> -->
                    <div class="text" @click="addCart(item.id)">+</div>
                  </transition>
                </div>
              </div>
            </div>
          </li>
        </ul>
      </scroll-view>
    </div>

    <!-- meituan 底部购物车代码 -->
    <div class="footer">
      <div class="footer-wrapper">
        <div class="container" @click="showType">
          <div class="price">
            ￥
            <span>{{allPrice}}</span>
          </div>
          <div class="container-con">
            <span class="container-tai">免配送费</span>
            <div class="container-ner"></div>
            <span class="container-last">支持自取</span>
          </div>
        </div>
        <div class="container-price" :class="[allnumber>0 ? '' : 'hide']">
          <span v-if="allnumber>0" @click="buy" >去结算</span>
        </div>
      </div>
      <div class="cart">
        <span v-if="allnumber>0">{{allnumber}}</span>
        <div :class="[allnumber>0 ? 'img' : 'hide']"></div>
      </div>
    </div>

    <!-- 购物车弹出层 -->
    <div class="pop" v-show="showpop" @click="showType"></div>
    <div class="attr-pop" :class="[showpop ? 'fadeup' : 'fadedown']">
      <div class="top">
        <div class="close" @click="deletecart">
          <img src="../../../static/images/del-address.png" />
          <span>清空购物车</span>
        </div>
        <div class="shopcart" v-for="(item, index) in carts" :key="index">
          <div class="left">
            <img :src="item.image" />
          </div>
          <div class="right">
            <div>
              <p>{{item.goods_name}}</p>
              <p>¥{{item.price}}</p>
              <div class="count">
                <div class="text" @click="reduce(item.id)">-</div>
                <div class="number">{{item.number}}</div>
                <div class="text" @click="add(item.id)">+</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { get, post } from "../../utils";
export default {
  data() {
    return {
      list: [],
      goods: [],
      contentId: '', // 每个food-list的id，scroll-into-view滚动到对应的id
      navId: '', // 导航模块对应的id，用来联动内容区域
      currentIndex: 0,
      navulHeight: 0, // 导航里ul高度
      navItemHeight: 0, // 每个导航高度
      listHeight: [], // foods内部块的高度
      contentHeight: [], // 内容区域scroll-view高度

      allnumber: 0,
      showpop: false,
      showdom: false,
      cartId:'',
      carts: [],
      cartnumber: 0,
      has: false,
      goodsId: '',
      price: 0,
      number: 0,
      name: '中式家常菜',
      detailData: {}
    }
  },
  mounted() {
    this.openId = wx.getStorageSync("openId") || "";
    this.getData()
    this.goodsDetail()
    this.cartDetail()
    this.selectMenu(this.name, this.nowIndex)
  },
  methods: {
    goodsPage (id) {
      wx.navigateTo({
        url: '/pages/food_detail/main?id=' + id
      })
    },
    async getData() {
      const data = await get("/food/index", {
        openId: this.openId,
      })
      // console.log(data);
      this.list = data.list;
      this.goodsId = data.goods.id;
      this.price = data.goods.price;
    },
    async selectMenu (name, index) {
      this.currentIndex = index
      const data = await get('/food/currentAction', {
        name: name
      })
      // console.log(data)
      this.goods = data.goods
      // this.detailData = data.data.currentOne
    },
    async goodsDetail () {
      const data = await get('/goods/detailaction', {
        id: this.id,
        openId: this.openId
      })
      this.cartnumber = data.cartnumber.number
      this.has = data.has
      // console.log(data)
    },
    async cartDetail () {
      const data = await get('/cart/detailaction', {
        id: this.id,
        openId: this.openId
      })
      this.carts = data.carts
      this.cartId = data.carts.id
      this.cartnumber = data.carts.number
      this.allnumber = data.allnumber
      // this.goodsId = data.goods.id
      // this.showdom = data.showdom
      // console.log(data)
    },
    toSearch() {
      wx.navigateTo({
        url: "/pages/search/main"
      })
    },
    onScroll(e) {
      this.contentId = ''
      let scrollTop = e.mp.detail.scrollTop
      // console.log(scrollTop)
      let length = this.listHeight.length
      if (scrollTop >= this.listHeight[length - 1] - this.contentHeight) {
        return
      } else if (scrollTop > 0 && scrollTop < this.listHeight[0]) {
        this.currentIndex = 0
      }
      for (let i = 0; i < length; i++) {
        if (scrollTop >= this.listHeight[i - 1] && scrollTop < this.listHeight[i]) {
          this.currentIndex = i
        }
      }
      // console.log(this.currentIndex)
    },
    getFoodHeight() {
      var query = wx.createSelectorQuery()
      let h = 0
      query.selectAll('.food-list-hook').boundingClientRect((rects) => {
        // console.log('rects'+rects)
        rects.forEach((rect) => {
          h += rect.height
          this.listHeight.push(h)
        })
        // console.log(this.listHeight)
      })
      query.select('.foods-wrapper').boundingClientRect((rect) => {
        this.contentHeight = rect.height
      })
      query.select('.menu-ul').boundingClientRect((rect) => {
        this.navulHeight = rect.height
      })
      query.select('.menu-item').boundingClientRect((rect) => {
        this.navItemHeight = rect.height
      }).exec()
    },
    buy () {
      wx.navigateTo({
        url: '/pages/cart/main'
      });      
    },
    showType() {
      this.showpop = !this.showpop;
    },
    async deletecart () {
      const data = await post('/cart/deletecart', {
        openId: this.openId
      })
      this.cartDetail()
      this.goodsDetail()
      // console.log(data)
    },
    async add (id) {
      const cartId = id
      this.cartnumber += 1
      this.cartDetail()
      this.goodsDetail()
      const data = await post('/cart/addAction', {
        cartId: cartId,
        // cartId: this.cartId,
        openId: this.openId
      })
      // console.log(data)
      const datanum = await get("/cart/detailaction", {
        openId: this.openId
      })
      this.allnumber = datanum.allnumber
      this.carts = datanum.carts
      this.cartDetail()
      this.goodsDetail()
    },
    async reduce (id) {
      const cartId = id
      this.cartnumber -= 1
      this.cartDetail()
      this.goodsDetail()
      const data = await post('/cart/reduceAction', {
        cartId: cartId,
        // cartId: this.cartId,
        openId: this.openId
      })
      // console.log(data)
      const datanum = await get("/cart/detailaction", {
        openId: this.openId
      })
      this.allnumber = datanum.allnumber
      this.carts = datanum.carts
      this.cartDetail()
      this.goodsDetail()
    },
    async addCart (id) {
      this.number = 0
      const cartId = id
      this.number += 1
      this.showdom = true
      this.cartDetail()
      this.goodsDetail()
      const data = await post('/cart/addCart', {
        openId: this.openId,
        goodsId: cartId,
        number: this.number
      })
      // console.log(data)
      const datanum = await get("/goods/detailaction", {
        id: 1,
        openId: this.openId
      })
      this.allnumber = datanum.allnumber
      this.cartDetail()
      this.goodsDetail()
    },
    async reduceCart (id) {
      const cartId = id
      if (this.number > 0) {
        this.number -= 1
      } 
      if (this.number < 1) {
        this.showdom = false
      }
      this.cartDetail()
      this.goodsDetail()
      const data = await post('/cart/reduceCart', {
        openId: this.openId,
        goodsId: cartId,
        number: this.number
      })
      // console.log(data)
      const datanum = await get('/goods/detailaction', {
        id: 1,
        openId: this.openId
      })
      this.allnumber = datanum.allnumber
      this.cartDetail()
      this.goodsDetail()
    }
  },
  watch: {
    currentIndex() {
      // console.log(this.currentIndex)
      if (this.contentHeight < this.navulHeight) {
        let h = this.currentIndex * this.navItemHeight
        if (h > this.contentHeight) {
          // 导航滑动
          this.navId = `nav_${this.currentIndex}`
        } else {
          this.navId = 'nav_0'
        }
      }
    },
    goods() {
      // 获取模块高度，即food-list
      setTimeout(() => {
        this.getFoodHeight()
      }, 60)
    }
  },
  computed: {
    allPrice () {
      let Price = 0
      for (let i = 0; i < this.carts.length; i++) {
        if (this.carts[i]) {
          // console.log(this.carts[i])
          Price += this.carts[i].price * this.carts[i].number
        }
      }
      return Price
    }
  }
}
</script>

<style lang="less" scoped>
@import "./style.less";
</style>