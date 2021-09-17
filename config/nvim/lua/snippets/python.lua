local U = require'snippets.utils'
return {
    ["qt5"] = U.match_indentation [[
    import sys
    from {1:Py}.QtWidgets import QApplication, ${2:Q}
    from ${3:Ui_} import ${3}


    class ${4}(${2}):
        def __init__(self):
            super(${4}, self).__init__()
            self.ui = ${3}()
            self.ui.setupUi(self)

    if __name__ == "__main__":
        try:
            myApp = QApplication(sys.argv)
            myWidget = ${4}()
            myWidget.show()
            myApp.exec_()
            sys.exit(0)
        except NameError:
            print("Name Error:", sys.exc_info()[1])
        except SystemExit:
            print("Closing Window...")
        except Exception:
            print(sys.exc_info()[1])
    ]];
}
