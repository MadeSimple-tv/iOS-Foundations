import Foundation

class Person : Codable{
    let name: String
    var age: Int
    var lovesApple: Bool
    
    init(name: String, age: Int, lovesApple: Bool){
        self.name = name
        self.age = age
        self.lovesApple = lovesApple
    }
}

do{
    let amy = Person(name: "Amy", age: 23, lovesApple: true)
    let encoder = JSONEncoder()
    let data = try encoder.encode(amy)
    let jsonString = String(data: data, encoding: .utf8)!
    print("json string \(jsonString)")
} catch {
    print("error encoding person \(error.localizedDescription)")
}

do{
    let jsonString = "{\"name\":\"John\",\"age\":15,\"lovesApple\":false}"
    let decoder = JSONDecoder()
    let data = jsonString.data(using: .utf8)!
    let john = try decoder.decode(Person.self, from: data)
    john.name
    john.lovesApple
    john.age
} catch{
    print("error decoding person \(error.localizedDescription)")
}





