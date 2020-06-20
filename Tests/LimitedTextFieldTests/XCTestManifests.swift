import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LimitedTextFieldTests.allTests),
    ]
}
#endif
