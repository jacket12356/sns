package com.aesopsns.lucene;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.analysis.Analyzer;  
import org.apache.lucene.document.Document;  
import org.apache.lucene.queryParser.MultiFieldQueryParser;  
import org.apache.lucene.queryParser.ParseException;  
import org.apache.lucene.queryParser.QueryParser;  
import org.apache.lucene.search.IndexSearcher;  
import org.apache.lucene.search.Query;  
import org.apache.lucene.search.ScoreDoc;  
import org.apache.lucene.search.TopDocs;  
  
import jeasy.analysis.MMAnalyzer;  
  
public class IndexSearch {  
    private static Analyzer analyzer = new MMAnalyzer(); // 极易中文分词器  
    public static void main(String[] args) throws Exception {  
        IndexSearch search = new IndexSearch();  
        search.search("姓名");  
    }  
    public List<String> search(String keyWord) throws Exception {  
        IndexSearcher indexSearcher = null;  
        QueryParser queryParser = new MultiFieldQueryParser(new String[]{"colContent"}, analyzer);
        List<String> fileNameList = new ArrayList<>();
        Query query = null;  
        try {  
            // 将关键字转换成索引库可以识别的Query对象  
            query = queryParser.parse(keyWord);  
        } catch (ParseException e) {  
            System.err.println("关键词解析失败!");  
        }  
        indexSearcher = new IndexSearcher(System.getProperty("user.dir") + "/WEB-INF/index");  
          
        if (indexSearcher != null) {  
            TopDocs topDocs;  
            try {  
                topDocs = indexSearcher.search(query, null, 10);  
                ScoreDoc[] scoreDocs = topDocs.scoreDocs;  
                Document document = null;  
                for (int i = 0; i < scoreDocs.length; i++) {  
                    ScoreDoc scorDoc = scoreDocs[i];  
                    int doc = scorDoc.doc;  
                    document = indexSearcher.doc(doc);  
//                    System.out.println("文件路径:"+document.getField("path").stringValue());  
//                    System.out.println("内容:"+document.getField("colContent").stringValue());  
//                    System.out.println("++++++++++++++++++++++++++++++");  
                    fileNameList.add(document.getField("filename").stringValue());
                }  
            } catch (IOException e) {  
                System.err.println("索引库查询失败");  
                e.printStackTrace();  
            } finally {  
                try {  
                    if (indexSearcher != null) {  
                        indexSearcher.close();  
                    }  
                } catch (Exception e) {  
                    System.err.println("不能关闭indexSearcher连接");  
                }  
            }  
        }  
        return fileNameList;
    }  
}  
