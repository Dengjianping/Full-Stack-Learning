```html
<!--pass a number-->
<div id="num">
  <props-num v-bind:num="n"></props-num>
</div>

<!--pass a boolean-->
<div id='boolean'>
  <boolean-props v-bind:bools="real"></boolean-props>
</div>

<!--pass a array-->
<div id="array">
  <array-props v-bind:array="arr"></array-props>
</div>

<div id='obj'>
  <obj-props v-bind:myObj="gg"></obj-props>
</div>
```

```js
Vue.component('props-num', {
  props: ['num'],
  template: '<p>{{ num }}</p>'
});
let num = new Vue({
  el: "#num",
  data: {
    n: 10
  }
});

Vue.component('boolean-props', {
  props: ['bools'],
  template: '<p>{{ bools }}</p>'
});
let bool = new Vue({
  el: "#boolean",
  data: {
    real: false
  }
});

Vue.component('array-props', {
  props: ['array'],
  template: '<ul><li v-for="a in array">{{ a }}</li></ul>'
});
let arr = new Vue({
  el: "#array",
  data: {
    arr: ['Hi',  "Hello", 'Gangster']
  }
});
```