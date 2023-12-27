import Foundation

/// Describes Swift AssociatedType
#if canImport(ObjectiveC)
@objcMembers
#endif
public final class AssociatedType: NSObject, SourceryModel {
    /// Associated type name
    public let name: String

    /// Associated type type constraint name, if specified
    public let typeName: TypeName?

    // sourcery: skipEquality, skipDescription
    /// Associated type constrained type, if known, i.e. if the type is declared in the scanned sources.
    public var type: Type?
    
    public var genericRequirements: [GenericRequirement]

    /// :nodoc:
    public init(name: String, typeName: TypeName? = nil, type: Type? = nil, genericRequirements: [GenericRequirement] = []) {
        self.name = name
        self.typeName = typeName
        self.type = type
        self.genericRequirements = genericRequirements
    }

    /// :nodoc:
    override public var description: String {
        var string = "\(Swift.type(of: self)): "
        string += "name = \(String(describing: self.name)), "
        string += "typeName = \(String(describing: self.typeName)), "
        string += "genericRequirements = \(String(describing: self.genericRequirements))"
        return string
    }

    public func diffAgainst(_ object: Any?) -> DiffableResult {
        let results = DiffableResult()
        guard let castObject = object as? AssociatedType else {
            results.append("Incorrect type <expected: AssociatedType, received: \(Swift.type(of: object))>")
            return results
        }
        results.append(contentsOf: DiffableResult(identifier: "name").trackDifference(actual: self.name, expected: castObject.name))
        results.append(contentsOf: DiffableResult(identifier: "typeName").trackDifference(actual: self.typeName, expected: castObject.typeName))
        results.append(contentsOf: DiffableResult(identifier: "genericRequirements").trackDifference(actual: self.genericRequirements, expected: castObject.genericRequirements))
        return results
    }

    public override var hash: Int {
        var hasher = Hasher()
        hasher.combine(self.name)
        hasher.combine(self.typeName)
        hasher.combine(self.genericRequirements)
        return hasher.finalize()
    }

    /// :nodoc:
    public override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? AssociatedType else { return false }
        if self.name != rhs.name { return false }
        if self.typeName != rhs.typeName { return false }
        return true
    }

// sourcery:inline:AssociatedType.AutoCoding

        /// :nodoc:
        required public init?(coder aDecoder: NSCoder) {
            guard let name: String = aDecoder.decode(forKey: "name") else { 
                withVaList(["name"]) { arguments in
                    NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: arguments)
                }
                fatalError()
             }; self.name = name
            self.typeName = aDecoder.decode(forKey: "typeName")
            self.type = aDecoder.decode(forKey: "type")
            guard let genericRequirements: [GenericRequirement] = aDecoder.decode(forKey: "genericRequirements") else {
                withVaList(["genericRequirements"]) { arguments in
                    NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: arguments)
                }
                fatalError()
             }; self.genericRequirements = genericRequirements
        }

        /// :nodoc:
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(self.name, forKey: "name")
            aCoder.encode(self.typeName, forKey: "typeName")
            aCoder.encode(self.type, forKey: "type")
            aCoder.encode(self.genericRequirements, forKey: "genericRequirements")
        }
// sourcery:end
}
