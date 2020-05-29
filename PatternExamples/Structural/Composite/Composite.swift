import Foundation


// MARK: - Theory
/*
 Паттерн Composite (компоновщик) — структурный шаблон проектирования. Он представляет объекты в виде древовидной структуры и обеспечивает к ним доступ через единый интерфейс.
  Есть протокол Component (название условное) — в нем описан общий интерфейс для каждого из объектов, участвующих в паттерне. Может быть сколько угодно классов, которые реализуют протокол, но их можно разделить на две части: композитные объекты и листья. Композитные объекты ( class Composite на схеме) содержат другие объекты типа Component, обычно в виде массива. Листья ( class Leaf на схеме) не содержат других компонентов — так что являются конечными объектами в структуре.

 Паттерн Компоновщик позволяет сгруппировать объекты в древовидные структуры и работать с ними, как с одним объектом. Другими словами, компоновщик применяется для создания некоторой иерархической структуры, которая схожа с древовидной, где каждый элемент структуры может быть доступен и используется стандартным образом.

 Когда применять Компоновщик?
 ● Имеется необходимость представления древовидной структуры объектов.
 ● Клиенты должны единообразно трактовать простые и составные объекты.
 Как применять Компоновщик?
 1. Необходимо убедиться, что реализуемую логику возможно представить в виде дерева.
 2. Реализовать общий интерфейс для всех компонентов.
 3. Создать конкретные классы для компонентов (листьев дерева).
 4. Компоненты должны реализовать общий интерфейс.
 5. Реализовать класс контейнера (компоновщика).
 Компоновщик позволяет упростить добавление новых видов компонентов, а также упрощает архитектуру клиента при работе с деревом. При этом компоновщик задает слишком общий дизайн.
 */
// MARK: - Test

class Composite {

    static func testExampleWithFiles() {
        let libraryFolder = Folder(name: "Lybrary")
        let bookFolder = Folder(name: "Books",
                                files: [PDFFile(name: "HarryPotter",
                                                author: "JonRouling",
                                                pageCount: 400),
                                        PDFFile(name: "Duna",
                                                author: "FrankGerbert",
                                                pageCount: 800)])
        let programmingBookFolder = Folder(name: "ProgrammingBooks",
                                           files: [PDFFile(name: "Swift",
                                                           author: "VasiliyUsov",
                                                           pageCount: 600)])
        bookFolder.addFile(file: programmingBookFolder)
        libraryFolder.addFile(file: bookFolder)
        
        let musicFolder = Folder(name: "Music",
                                 files: [MP3File(name: "DevochkaSKare",
                                                 artist: "Mukka",
                                                 duration: 180),
                                         MP3File(name: "Sansarra",
                                                 artist: "Timati",
                                                 duration: 230)])
        libraryFolder.addFile(file: musicFolder)
        
        let videoFolder = Folder(name: "Films",
                                 files: [MKVFile(name: "Mother",
                                                 rate: 7.1,
                                                 genre: "scary"),
                                         MKVFile(name: "Saw5",
                                                 rate: 7,
                                                 genre: "detective")])
        
        libraryFolder.addFile(file: videoFolder)
        
        libraryFolder.open()
        
    }

}

// MARK: - Example №1 -

/*
 нам необходимо реализовать возможность открыть все файлы в папке, в этой папке могут быть как файлы так и другие папки
 
 иерархия примера:
Library -> Books -> HarryPotter
Library -> Books -> Duna
Library -> Books -> ProgrammingBooks -> Swift
Library -> Music -> DevochkaSKare
Library -> Music -> Sansarra
Library -> Films -> Saw5
Library -> Films -> Mother
 */


// MARK: protocols

fileprivate protocol File {
    var name: String { get }
    var description: String { get }
    func open()
}

extension File {
    func open() {
        print("opening \(description)")
    }
}

extension File where Self: PDFFile {
    var description: String {
        return "ebook \(name) by \(author) with \(pageCount) pages"
    }
}

extension File where Self: Folder {
    var description: String {
        return "folder \(name) with files: \(files.compactMap { $0.description }.joined(separator: ","))"
    }
    func open() {
        print("opening \(description)")
        print("then opening files: ")
        files.forEach {$0.open()}
    }
}
extension File where Self: MP3File {
    var description: String {
        return "music \(name) by \(artist) with \(duration)sec duration"
    }
}
extension File where Self: MKVFile {
    var description: String {
        return "video \(name) by genre: \(genre), with \(rate) rate"
    }
}

// MARK: classes

fileprivate class Folder: File {
    let name: String
    
    var files: [File]
    
    init(name: String, files: [File] = []) {
        self.name = name
        self.files = files
    }
    
    func addFile(file: File) {
        files.append(file)
    }
    
}

fileprivate class PDFFile: File {
    let name: String
    let author: String
    let pageCount: Int
    
    init(name: String, author: String, pageCount: Int) {
        self.name = name
        self.author = author
        self.pageCount = pageCount
    }
    
}

fileprivate class MP3File: File {
    let name: String
    let artist: String
    let duration: Int
    
    init(name: String, artist: String, duration: Int) {
        self.name = name
        self.artist = artist
        self.duration = duration
    }
    
}

fileprivate class MKVFile: File {
    let name: String
    let rate: Double
    let genre: String
    
    init(name: String, rate: Double, genre: String) {
        self.name = name
        self.rate = rate
        self.genre = genre
    }
    
}
