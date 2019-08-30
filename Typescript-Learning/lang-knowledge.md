### 类型
#### 基本类型。 
any/number/string/boolean
```ts
// string to number
let num = Number('123');
parseInt("123");
parseFlot("12.12");

// number to string
let s: string = 123.toString();
let s1: string = 123.toLocalString();
```

#### 复合类型。

数组： Array<number>, Array<string>, let a: number[] = [1,2,3]; let a: string[] = ["hello", "kkkk"];

元祖： let a: [string, number] = ["hello", 34]; 索引： console.log(a[0]);

枚举： enum Status { Success, Failure }

#### Misc
void/null/undefined/never

#### 联合类型
```ts
let v: string|number|Array<string>;
val = 3;
console.log(typeof val); // number
val = "stringType";
console.log(typeof val); // string
```

### 逻辑控制和循环
```ts
if (boolean) {}

switch(expr) {
    case case1:
        ...;
    case case2:
        ...;
    default:
        ...;
}

for (let i = 0; i < 5; ++i {
    console.log(i);
}
 ```

### 函数
```ts

// general function
// function function_name() { statement }
function add(x: number, y: number): number {
    return x + y;
}
console.log(add(1,2));

// optinal params
// function funcName(param: type, param1?:type) {}
function optinalParams(firstName: string, lastName?: string): string {
    if (lastName) {
        return firstName + " " + lastName;
    } else {
        return firstName;
    }
}
console.log(optinalParams("Deng"));
console.log(optinalParams("Deng", "Jamie"));

// default params
// function funcName(param: type, param1:type=concreteInstance) {}
function defaultParams(firstName: string, lastName: string="Jamie"): string {
    return firstName + " " + lastName;
}
console.log(defaultParams("Deng"));
console.log(defaultParams("Deng", "Bob"));

// rest of params
// function funcName(param: type, ...restParam:type[]) {}
function restOfParams(firstName: string, ...rests: string[]): string {
    for (let i in rests) {
        firstName += rests[i];
    }
    return firstName;
}
console.log(restOfParams("Deng", "1", "jamie", "fafa"));

function sumOfParams(...nums: number[]): number {
    let sum: number = 0;
    for (let i in nums) {
        sum += nums[i];
    }
    return sum;
}
console.log(sumOfParams(1,2,3));

// anonymous function
// let res = function( [arguments] ) { ... }
let anoyFunc = function(x: number, y: number): number {
    return x + y;
}
console.log(anoyFunc(1,4));

// lambda function
// let func = ([param1, parma2,…param n])=>statement;
let lambdaFunc = (a: number, b: number) => a + b;
console.log(lambdaFunc(1,2));

// constructor function
// let func = new Function( [arguments] ) { ... });
let constructorFunc = new Function('a', 'b', 'return a + b');
console.log(constructorFunc(2,4));

```

### 接口
```ts
interface Hello {
    when: Date,
    where: string,
    say: (a: number) => string
}

let hello: Hello = {
    when: new Date(),
    where: "Here",
    say: (a: number): string => {
        return a.toString(); 
    }
};
```

### 类
```ts
class Animal {
    name: string;
    weight: number;
    static where: string;
    constructor(name: string, weight: number) {
        this.name = name;
        this.weight = weight;
        Animal.where = "earth";
    }
    getName(): string {
        return this.name;
    }
    static speak(): void {
        console.log('static function from class');
    }
}

class Bird extends Animal {
    hasWing: boolean;
    constructor(name: string, weight: number, wing: boolean=false) {
        super(name, weight);
        this.hasWing = wing;
    }
    fly() {
        console.log(this.name, 'is flying');
    }
}
```