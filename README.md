##SnapPageableArray

An implementation of a generic array that can fetch pages of information. At creation, the array must be supplied with a datatype, a capacity and a pageSize

    var array = PageableArray<LocalData>(capacity: 1000, pageSize: 40)
    
The datatype must conform to the DTOProtocol, specifying the existence of an id of type UInt64?

```
public protocol DTOProtocol: CacheableDTO {
    var id: UInt64? { get }
}
```

## Features
------

## Installation
------

## Usage
------

```
var array = PageableArray<LocalData>(capacity: 1000, pageSize: 40)

// ...

let data = array[index]
```

## License
------

Released under 3-clause BSD license
