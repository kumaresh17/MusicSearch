**Basic Features:**

a. App has the capability to search for music related to Album, Track and Artist. On tap of any list item app will navigate to a detail screen which will show the Image, title and track details.
b. App supports Dark mode.

**Universal app:**

App works on both iPhone and iPad and different orientations.

Minimum iOS deployment target is **13.0**

**App shows use of:**

a. Code structure and software architecture and design - using MVVM CLEAN architecture. b. Combine used to bind VieModel to View. c. Unit test cases - Testing for Payload data, network manager and View Model with Mock Api call. d. UITest cases to validate the home and detail screen UI elements. (Important note to test :- Simulator -> I/O - > Keyboard -> unselect connect to hardware keyboard to perform UI test, else test will crash as it won't be able to find the physical keyboard KEYS. Make sure the physical keyboard comes up on the Simulator) e. XCTMetric Performance test case for XCTMemoryMetric with set baseline to cature any future regression related to leaks, heap allocations and fragmentation. f. Coding best practice - Adopting to SOLID best principles, using of Protocol, extension, codable, dependency injection for better Testability, modularity, readability and scalability. g. Support dark mode - As all the colors are by default system color.

**Future enhancements:**

a. Dynamic Type Accessibility. 
b. Write performance Unit test XCTCPUMetric and for UI hitches regresssion
c. Caching (NSCache) of search results between Album, Track and Artist for the same session. 
d. Support dark mode - As all the colors are by default system color.

**Screen shots:**

![Simulator Screen Shot - iPhone 8 Plus - 2022-03-20 at 14 16 53](https://user-images.githubusercontent.com/19665932/159167534-76ac6957-9c2a-4ffc-bb2d-48a7562d7f6a.png)

![image](https://user-images.githubusercontent.com/19665932/159167645-7e170d63-d7da-47db-bf7a-384d3a79769d.png)


