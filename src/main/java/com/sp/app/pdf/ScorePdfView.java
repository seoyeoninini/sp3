package com.sp.app.pdf;


import java.awt.Color;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class ScorePdfView extends AbstractPdfView {
	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String filename = (String) model.get("filename");
		
		@SuppressWarnings("unchecked")
		List<String> columnLabels = (List<String>)model.get("columnLabels");
		@SuppressWarnings("unchecked")
		List<Object[]> columnValues = (List<Object[]>) model.get("columnValues");
		
		response.setContentType("application/pdf");
		response.setHeader("Content-disposition", "attachment;filename="+ filename);
		
		BaseFont baseFont = BaseFont.createFont("c:\\windows\\fonts\\malgun.ttf", BaseFont.IDENTITY_H,
				BaseFont.EMBEDDED);
		
		Font font = new Font(baseFont);
		
		font.setSize(20);
		font.setStyle(Font.BOLD);
		
		
		//문장 표현
		Paragraph p = new Paragraph("성적 처리", font);
		p.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(p);
		
		font.setSize(10);
		font.setStyle(Font.NORMAL);
		PdfPTable table = new PdfPTable(columnLabels.size());
		table.setWidths(new int[] {50, 100, 80, 80, 80,80,80});
		table.setSpacingBefore(15);
		
		PdfPCell cell;
		for (int i = 0; i < columnLabels.size(); i++) {
			cell = new PdfPCell(new Paragraph(columnLabels.get(i), font));
			cell.setBackgroundColor(new Color(211,244,250));
			cell.setHorizontalAlignment(Cell.ALIGN_CENTER);
			cell.setFixedHeight(25);
			cell.setVerticalAlignment(Cell.ALIGN_MIDDLE);
			
			table.addCell(cell);
		}
		
		for (int i = 0; i < columnValues.size(); i++) {
			Object[] values = columnValues.get(i);
			for(int col = 0; col<values.length; col++) {
				cell = new PdfPCell(new Paragraph(values[col].toString(), font));

				cell.setHorizontalAlignment(Cell.ALIGN_CENTER);
				cell.setFixedHeight(25);
				cell.setVerticalAlignment(Cell.ALIGN_MIDDLE);
				
				table.addCell(cell);
			}
		}
		
		document.add(table);

	}
}
