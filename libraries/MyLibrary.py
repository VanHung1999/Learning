from robot.api import logger
import PyPDF2
from fpdf import FPDF

def add_image_to_pdf(filepdf,fileimg,i):
    pdfFileObj = open(filepdf, 'rb')
    pdfReader = PyPDF2.PdfFileReader(pdfFileObj) 
    pageObj = pdfReader.getPage(0)
    a = pageObj.extractText()
    print(pageObj.extractText())
    pdf = FPDF()
    pdf.add_page()
    pdf.set_font('Arial', size= 14)
    pdf.write( txt=a)
    pdf.image( fileimg ,x=40,y=50 )
    pdf.output(filepdf)




        
    
