source: https://codeburst.io/decorate-your-code-with-typescript-decorators-5be4a4ffecb4

Types of decorators and its priority of execution are
- Class decorator — Priority 4 (Object Instance, Static)
- Method Decorator — Priority 2 (Object Instance, Static)
- Accessor or Property Decorator — Priority 3 (Object Instance, Static)
- Parameter Decorator — Priority 1 (Object Instance, Static)

## Signatures of the decorators
```ts
declare type ClassDecorator = <TFunction extends Function>(target: TFunction) => TFunction | void;
declare type PropertyDecorator = (target: Object, propertyKey: string | symbol) => void;
declare type MethodDecorator = <T>(target: Object, propertyKey: string | symbol, descriptor: TypePropertyDescriptor<T>) => TypePropertyDescriptor<T> | void;
declare type ParameterDecrator = (target: Object, propertyKey: string | symbol, parameterIndex: number) => void;
```

### Method Decorator
```ts
export function logMethod(
    target: Object,
    propertyName: string,
    propertyDesciptor: PropertyDescriptor): PropertyDescriptor {
    // target === Employee.prototype
    // propertyName === "greet"
    // propertyDesciptor === Object.getOwnPropertyDescriptor(Employee.prototype, "greet")
    const method = propertyDesciptor.value;

    propertyDesciptor.value = function (...args: any[]) {

        // convert list of greet arguments to string
        const params = args.map(a => JSON.stringify(a)).join();

        // invoke greet() and get its return value
        const result = method.apply(this, args);

        // convert result to string
        const r = JSON.stringify(result);

        // display in console the function call details
        console.log(`Call: ${propertyName}(${params}) => ${r}`);

        // return the result of invoking the method
        return result;
    }
    return propertyDesciptor;
};

class Employee {

    constructor(
        private firstName: string,
        private lastName: string
    ) {
    }

    @logMethod
    greet(message: string): string {
        return `${this.firstName} ${this.lastName} says: ${message}`;
    }

}

const emp = new Employee('Mohan Ram', 'Ratnakumar');
emp.greet('hello');
```

### Property Decorator
```ts
function logParameter(target: Object, propertyName: string) {

    // property value
    let _val = this[propertyName];

    // property getter method
    const getter = () => {
        console.log(`Get: ${propertyName} => ${_val}`);
        return _val;
    };

    // property setter method
    const setter = newVal => {
        console.log(`Set: ${propertyName} => ${newVal}`);
        _val = newVal;
    };

    // Delete property.
    if (delete this[propertyName]) {

        // Create new property with getter and setter
        Object.defineProperty(target, propertyName, {
            get: getter,
            set: setter,
            enumerable: true,
            configurable: true
        });
    }
}

class Employee {

    @logParameter
    name: string;

}

const emp = new Employee();
emp.name = 'Mohan Ram';
console.log(emp.name);
// Set: name => Mohan Ram
// Get: name => Mohan Ram
// Mohan Ram
```

### Parameter Decorator
```ts
function logParameter(target: Object, propertyName: string, index: number) {

    // generate metadatakey for the respective method
    // to hold the position of the decorated parameters
    const metadataKey = `log_${propertyName}_parameters`;
    if (Array.isArray(target[metadataKey])) {
        target[metadataKey].push(index);
    }
    else {
        target[metadataKey] = [index];
    }
}

class Employee {
    greet(@logParameter message: string): string {
        return `hello ${message}`;
    }
}
const emp = new Employee();
emp.greet('hello');
```

### Accessor Decorator
```ts
function enumerable(value: boolean) {
    return function (target: any, propertyKey: string, descriptor: PropertyDescriptor) {
        console.log('decorator - sets the enumeration part of the accessor');
        descriptor.enumerable = value;
    };
}

class Employee {
    private _salary: number;
    private _name: string;

    @enumerable(false)
    get salary() { return `Rs. ${this._salary}`; }

    set salary(salary: any) { this._salary = +salary; }

    @enumerable(true)
    get name() {
        return `Sir/Madam, ${this._name}`;
    }

    set name(name: string) {
        this._name = name;
    }

}

const emp = new Employee();
emp.salary = 1000;
for (let prop in emp) {
    console.log(`enumerable property = ${prop}`);
}
// salary property - will not be part of enumeration since we configured it to false
// output:
// decorator - sets the enumeration part of the accessor
// decorator - sets the enumeration part of the accessor
// enumerable property = _salary
// enumerable property = name
```

### Class Decorator
```ts
export function logClass(target: Function) {
    // save a reference to the original constructor
    const original = target;

    // a utility function to generate instances of a class
    function construct(constructor, args) {
        const c: any = function () {
            return constructor.apply(this, args);
        }
        c.prototype = constructor.prototype;
        return new c();
    }

    // the new constructor behaviour
    const f: any = function (...args) {
        console.log(`New: ${original['name']} is created`);
        return construct(original, args);
    }

    // copy prototype so intanceof operator still works
    f.prototype = original.prototype;

    // return new constructor (will override original)
    return f;
}

@logClass
class Employee {

}

let emp = new Employee();
console.log('emp instanceof Employee');
console.log(emp instanceof Employee);
```

### Generalize decorators with Decorator Factory
```ts
import { logClass } from './class-decorator';
import { logMethod } from './method-decorator';
import { logProperty } from './property-decorator';
import { logParameter } from './parameter-decorator';

// decorator factory - which calls the corresponding decorators based on arguments passed
export function log(...args) {
    switch (args.length) {
        case 3: // can be method or parameter decorator
            if (typeof args[2] === "number") { // if 3rd argument is number then its index so its parameter decorator
                return logParameter.apply(this, args);
            }
            return logMethod.apply(this, args);
        case 2: // property decorator
            return logProperty.apply(this, args);
        case 1: // class decorator
            return logClass.apply(this, args);
        default: // invalid size of arguments 
            throw new Error('Not a valid decorator');
    }
}

@log
class Employee {

    @log
    private name: string;

    constructor(name: string) {
        this.name = name;
    }

    @log
    greet(@log message: string): string {
        return `${this.name} says: ${message}`;
    }

}
```

### Metadata Reflection API
```ts
import "reflect-metadata";

// parameter decorator uses reflect api to store the indexes of the decorated parameter
export function logParameter(target: Object, propertyName: string, index: number) {
    // to get the metadata from the target object
    const indices = Reflect.getMetadata(`log_${propertyName}_parameters`, target, propertyName) || [];
    indices.push(index);
    // to define the metadata to the target object
    Reflect.defineMetadata(`log_${propertyName}_parameters`, indices, target, propertyName);
}

// property decorator uses reflect api to get the run time type of the property
export function logProperty(target: Object, propertyName: string): void {
    // to get the design type of the property from the object
    var t = Reflect.getMetadata("design:type", target, propertyName);
    console.log(`${propertyName} type: ${t.name}`); // name type: String
}


class Employee {
  
    @logProperty
    private name: string;
    
    constructor(name: string) {
        this.name = name;
    }

    greet(@logParameter message: string): string {
        return `${this.name} says: ${message}`;
    }

}
```