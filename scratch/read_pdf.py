from pypdf import PdfReader

reader = PdfReader("Pertemuan 12 auto scalling.pdf")
text = ""
for page in reader.pages:
    text += page.extract_text() + "\n"

with open("scratch/pdf_text.txt", "w", encoding="utf-8") as f:
    f.write(text)
print("Done")
