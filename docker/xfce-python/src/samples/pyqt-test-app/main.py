import sys
from PyQt5.QtWidgets import QApplication, QWidget

app = QApplication(sys.argv)

root = QWidget()

root.resize(320, 240)
root.setWindowTitle("Hello, World!")
root.show()

sys.exit(app.exec_())
