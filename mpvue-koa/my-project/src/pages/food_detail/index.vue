<template>
  <div class="detailWrapper">
    <div>
      <img :src="info.image" class="image" />
    </div>
    <div class="info">
      <span class="collect" @click="collect" :class="[collectFlag ? 'active' : '']"></span>
      <span class="title">{{info.name}}</span>
      <div class="desc">
        <span>月售{{info.sellCount}}</span>
        <span>好评率{{info.rating}}%</span>
      </div>
      <div class="price">
        <span class="unit">￥</span>
        {{info.price}}
        <span class="oldPrice" v-show="info.oldPrice">￥{{info.oldPrice}}</span>
      </div>
      <div class="shopCart">
        <transition name="fade">
          <div @click="reduceCart" :class="[showdom ? 'text' : 'hide']">-</div>
          <div :class="[showdom ? 'number' : 'hide']">{{cartnumber}}</div>
          <div class="text" @click="addCart">+</div>
        </transition>
      </div>
    </div>
    <div class="divider"></div>
    <div class="desc">
      <div class="title">商品介绍</div>
      <div class="content">{{info.description}}</div>
    </div>
    <div class="divider"></div>

    <div class="comment-list">
      <div>商品评价</div>
      <div class="nocomment" v-if="allcomments.length==0">暂无评论~</div>
      <div class="tag" v-if="allcomments.length!==0">
        <div @click="all(index)" :class="{choose:alldisplay==1}">全部</div>
        <div @click="good(index)" :class="{choose:gooddisplay==1}">推荐</div>
        <div @click="bad(index)" :class="{choose:baddisplay==1}">吐槽</div>
      </div>

      <div v-show="gooddisplay==1">
        <div class="item-c" v-for="(item, index) in goodcomm" :key="index">
          <div class="item-l">
            <img :src="item.useravatar" />
          </div>
          <div class="item-r">
            <div class="h-r">
              <div class="r-t">
                <span class="name">{{item.username}}</span>
                <span class="date">{{item.rateTime}}</span>
              </div>
              <!-- <div class="r-b">
                  <div class="b-l">
                    <i class="icon mt-star-s" v-for="(itx, idx) in stars" :key="idx"></i>
                  </div>
              </div>-->
            </div>
            <div class="r-comtent">
              <span>{{item.text}}</span>
            </div>
            <div :class="item.commImg?'r-imgs':'hide'">
              <img :src="item.commImg"/>
              <span :class="item.rateType=='推荐' ? 'good' : 'bad'">{{item.rateType}}</span>
            </div>
          </div>
        </div>
      </div>

      <div v-show="baddisplay==1">
        <div class="item-c" v-for="(item, index) in badcomm" :key="index">
          <div class="item-l">
            <img :src="item.useravatar" />
          </div>
          <div class="item-r">
            <div class="h-r">
              <div class="r-t">
                <span class="name">{{item.username}}</span>
                <span class="date">{{item.rateTime}}</span>
              </div>
              <!-- <div class="r-b">
                  <div class="b-l">
                    <i class="icon mt-star-s" v-for="(itx, idx) in stars" :key="idx"></i>
                  </div>
              </div>-->
            </div>
            <div class="r-comtent">
              <span>{{item.text}}</span>
            </div>
            <div class="r-imgs">
              <img :src="item.commImg"/>
              <span :class="item.rateType=='推荐' ? 'good' : 'bad'">{{item.rateType}}</span>
            </div>
          </div>
        </div>
      </div>

      <div v-show="alldisplay==1">
        <div class="item-c" v-for="(item, index) in allcomments" :key="index">
          <div class="item-l">
            <img :src="item.useravatar" />
          </div>
          <div class="item-r">
            <div class="h-r">
              <div class="r-t">
                <span class="name">{{item.username}}</span>
                <span class="date">{{item.rateTime}}</span>
              </div>
              <!-- <div class="r-b">
                  <div class="b-l">
                    <i class="icon mt-star-s" v-for="(itx, idx) in stars" :key="idx"></i>
                  </div>
              </div>-->
            </div>
            <div class="r-comtent">
              <span>{{item.text}}</span>
            </div>
            <div class="r-imgs">
              <img :src="item.commImg" />
              <span :class="item.rateType=='推荐' ? 'good' : 'bad'">{{item.rateType}}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- meituan 底部购物车代码 -->
    <div class="footer" >
      <!-- <div class="footer-c" v-if="pageIndex === 0"> -->
      <!-- <div class="c-t">
          <span>{{reduceTip}}</span>
      </div>-->
      <div class="footer-wrapper">
        <div class="container" @click="showType">
          <!-- <span class="price" v-if="totalPrice > 0 || productCount > 0"> -->
          <div class="price">
            ￥
            <span>{{sumPrice}}</span>
            <!-- <span>{{totalPrice}}</span> -->
          </div>
          <div class="container-con">
            <span class="container-tai">免配送费</span>
            <div class="container-ner"></div>
            <span class="container-last">支持自取</span>
          </div>
        </div>
        <!-- <div
          class="container-price"
          :style="{'background-color': btnTitle === '去结算' ? '#F0D179' : '#2F2F2F'}"
          @click="orderClick"
        >-->
        <div class="container-price" :class="[allnumber>0 ? '' : 'hide']">
          <!-- <span :style="{color: btnTitle === '去结算' ? '#333' : '#666'}">{{btnTitle}}</span> -->
          <span v-if="allnumber>0" @click="buy" >去结算</span>
        </div>
      </div>
      <div class="cart">
        <span v-if="allnumber>0">{{allnumber}}</span>
        <div :class="[allnumber>0 ? 'img' : 'hide']"></div>
        <!-- <img src="../../../static/images/ic_menu_shoping_nor.png" /> -->
        <!-- <span v-if="productCount > 0">{{productCount}}</span> -->
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
import BScroll from "better-scroll";
import { get, post } from "../../utils";

export default {
  data() {
    return {
      id: '',
      openId: '',
      info: {},
      showpop: false,
      number: 0,
      gooddisplay: 0,
      baddisplay: 0,
      alldisplay:1,
      goodcomm:[],
      badcomm:[],
      allcomments: [],
      collectFlag: false,
      goodsId: '',
      allnumber: 0,
      allPrice: 0,
      showdom: false,
      cartId:'',
      carts: [],
      cartnumber: 0,
      has: false
      // cartnumber: 0
    }
  },
  computed: {
    sumPrice () {
      let Price = 0
      for (let i = 0; i < this.carts.length; i++) {
        if (this.carts[i]) {
          console.log(this.carts[i])
          Price += this.carts[i].price * this.carts[i].number
        }
      }
      return Price
    },
    totalPrice() {
      var price = 0;
      // this.foods.map(item => price += item.totalPrice)
      return parseFloat(price).toFixed(1);
    },
    productCount() {
      var count = 0;
      // this.foods.map(item => count += item.count)
      return count;
    },
    reduceTip() {
      // var content = this.shopInfo.prompt_text
      var content = "15元起送";
      var price = 0;
      // this.foods.map(item => price += item.totalPrice)
      if (price <= 0) return content;
      if (price < this.shopInfo.min_price) {
        var value = parseFloat(this.shopInfo.min_price - price).toFixed(1);
        return `还差 ${value}元 就能起送`;
      }
      var activity_info = this.shopInfo.activity_info;
      for (let i = 0; i < activity_info.length; i++) {
        const item = activity_info[i];
        if (price < item.priceLower) {
          var str = parseFloat(item.priceLower - price).toFixed(1);
          if (i === 0) {
            this.changeReduceFeeDataMut(0.0);
            return `再买 ${str}元 可减 ${item.reduce}元 [去凑单]`;
          } else {
            var perItem = activity_info[i - 1];
            this.changeReduceFeeDataMut(perItem.reduce);
            return `已减${perItem.reduce}元 再买 ${str}元 可减 ${
              item.reduce
            }元 [去凑单]`;
          }
        } else {
          continue;
        }
      }
      var lastItem = activity_info[activity_info.length - 1];
      this.changeReduceFeeDataMut(lastItem.priceLower);
      return `已满 ${lastItem.priceLower} 可减 ${lastItem.reduce}`;
    },
    btnTitle() {
      // var content = `${this.shopInfo.min_price}元起送`
      var content = "$15元起送";
      var price = 0;
      // this.foods.map(item => price += item.totalPrice)
      if (price <= 0) return content;
      if (price < this.shopInfo.min_price) {
        var value = parseFloat(this.shopInfo.min_price - price).toFixed(1);
        return `还差${value}元`;
      } else {
        return "去结算";
      }
    }
  },

  mounted() {
    this.openId = wx.getStorageSync("openId") || "";
    this.id = this.$root.$mp.query.id
    this.goodsDetail()
    this.cartDetail()
  },
  methods: {
    // 数据请求
    async goodsDetail () {
      const data = await get('/goods/detailaction', {
        id: this.id,
        openId: this.openId
      })
      this.info = data.info
      this.allcomments = data.allcomments
      this.goodcomm = data.goodcomm
      this.badcomm = data.badcomm
      this.goodsId = data.info.id
      this.collectFlag = data.collected
      this.allPrice = data.info.price
      this.showdom = data.showdom
      this.cartnumber = data.cartnumber.number
      this.has = data.has
      console.log(data)
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
    },

    showType() {
      this.showpop = !this.showpop;
    },

    _initScroll() {
      if (!this.detailWrapper) {
        this.detailWrapper = new BScroll(this.$refs.detailWrapper, {
          click: true
        });
      } else {
        this.detailWrapper.refresh();
      }
    },

    async collect () {
      this.collectFlag = !this.collectFlag
      const data = await post('/collect/addcollect', {
        openId: this.openId,
        goodsId: this.goodsId
      })
      console.log(data)
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
      console.log(data)
      const datanum = await get("/goods/detailaction", {
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
      console.log(data)
      const datanum = await get("/goods/detailaction", {
        openId: this.openId
      })
      this.allnumber = datanum.allnumber
      this.carts = datanum.carts
      this.cartDetail()
      this.goodsDetail()
    },

    all (index) {
      this.alldisplay = 1
      this.gooddisplay = 0
      this.baddisplay = 0
    },
    good (index) {
      this.gooddisplay = 1
      this.baddisplay = 0
      this.alldisplay = 0
    },
    bad (index) {
      this.baddisplay = 1
      this.gooddisplay = 0
      this.alldisplay = 0
    },
 
    async addCart () {
      this.number += 1
      this.showdom = true
      this.cartDetail()
      this.goodsDetail()
      const data = await post('/cart/addCart', {
        openId: this.openId,
        goodsId: this.goodsId,
        number: this.number
      })
      console.log(data)
      const datanum = await get("/goods/detailaction", {
        id: 1,
        openId: this.openId
      })
      this.allnumber = datanum.allnumber
      this.cartDetail()
      this.goodsDetail()
    },

    async reduceCart () {
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
        goodsId: this.goodsId,
        number: this.number
      })
      console.log(data)
      const datanum = await get('/goods/detailaction', {
        id: 1,
        openId: this.openId
      })
      this.allnumber = datanum.allnumber
      this.cartDetail()
      this.goodsDetail()
    },

    async deletecart () {
      const data = await post('/cart/deletecart', {
        openId: this.openId
      })
      this.cartDetail()
      this.goodsDetail()
      console.log(data)
    },

    buy () {
      wx.navigateTo({
        url: '/pages/cart_list/main'
      });      
    }
    // async buy () {
    //   const data = await post('/order/submitAction', {
    //     goodsId: this.goodsId,
    //     openId: this.openId,
    //     allPrice: this.allPrice
    //   })
    // }
  }
}
</script>

<style lang="less" scoped>
@import "./style.less";
</style>
