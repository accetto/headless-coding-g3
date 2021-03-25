import sys

### enable the correct framework version
from PySide2 import QtCore, QtWidgets
# from PySide6 import QtCore, QtWidgets

app = QtWidgets.QApplication(sys.argv)

mywindow = QtWidgets.QWidget()
mywindow.resize(320, 240)
mywindow.setWindowTitle('Hello, World!')

mylabel = QtWidgets.QLabel(mywindow)
mylabel.setText('Hello, World!')
mylabel.setGeometry(QtCore.QRect(200, 200, 200, 200))

mywindow.show()

sys.exit(app.exec_())
