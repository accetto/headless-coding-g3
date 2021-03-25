import kivy

# replace with your current kivy version !
kivy.require('2.0.0')  

from kivy.app import App
from kivy.uix.button import Button


class MyApp(App):

    def build(self):
        return Button(text='Hello World')


if __name__ == '__main__':
    MyApp().run()
