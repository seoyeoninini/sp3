package com.sp.app.common;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

// AbstractExcelView는 spring 4.2 부터  deprecated 됨
// 높은 버전의 엑셀은 AbstractXlsxView 구현클래스로 작성(확장자는 xlsx) 
// 낮은 버전의 엑셀은 AbstractXlsView 구현클래스로 작성(확장자는 xls) 

@Service("excelView")
public class MyExcelView extends AbstractXlsxView {
	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String filename = (String) model.get("filename");
		String sheetName = (String) model.get("sheetName");
		
		List<String> columnLabels = (List<String>)model.get("columnLabels");
		List<Object[]> columnValues = (List<Object[]>)model.get("columnValues");
		
		response.setContentType("application/ms-excel");
		response.setHeader("Content-disposition", "attachment; filename=" + filename);
		
		Sheet sheet = createSheet(workbook, 0, sheetName);
		
		if(columnLabels != null) {
			createColumnLabel(sheet, columnLabels);
		}
		
		if(columnValues != null) {
			createColumnValue(sheet, columnValues);
		}
	}

	// sheet 생성
	/**
	 * @param workbook
	 * @param sheetIdx  : sheet 인덱스(0부터 시작)
	 * @param sheetName
	 * @return
	 */
	protected Sheet createSheet(Workbook workbook, int sheetIdx, String sheetName) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(sheetIdx, sheetName);
		
		return sheet;
	}

	// 제목(첫번째 row)
	protected void createColumnLabel(Sheet sheet, List<String> columnLabels) {
		Row laberRow = sheet.createRow(0);
		
		Cell cell;
		for(int idx = 0; idx < columnLabels.size(); idx++) {
			sheet.setColumnWidth(idx, 256 * 15); // 컬럼폭
			
			cell = laberRow.createCell(idx);
			cell.setCellValue(columnLabels.get(idx));
		}
	}

	// 내용(두번째 row 부터)
	protected void createColumnValue(Sheet sheet, List<Object[]> columnValues) {
		Row row;
		Cell cell;
		
		for(int idx = 0; idx < columnValues.size(); idx++) {
			row = sheet.createRow(idx+1);
			
			Object[] values = columnValues.get(idx);
			for(int col = 0; col < values.length; col++) {
				try {
					cell = row.createCell(col);
					if(values[col] instanceof Byte) {
						cell.setCellValue((Byte) values[col]);
						
					} else if(values[col] instanceof Short) {
						cell.setCellValue((Short) values[col]);
						
					} else if(values[col] instanceof Integer) {
						cell.setCellValue((Integer) values[col]);
					
					} else if(values[col] instanceof Long) {
						cell.setCellValue((Long) values[col]);
					
					} else if(values[col] instanceof Float) {
						cell.setCellValue((Float) values[col]);
					
					} else if(values[col] instanceof Double) {
						cell.setCellValue((Double) values[col]);
						
					} else if(values[col] instanceof Character) {
						cell.setCellValue((Character) values[col]);
						
					} else if(values[col] instanceof Boolean) {
						cell.setCellValue((Boolean) values[col]);
						
					} else if(values[col] instanceof String) {
						cell.setCellValue((String) values[col]);
					
					} else {
						cell.setCellValue(values[col].toString());
					}
				} catch (Exception e) {
					
				}
			}
		}
	}
}