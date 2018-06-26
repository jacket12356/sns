package com.aesopsns.lucene;
import java.io.File;  
import java.io.FileInputStream;  
import java.io.IOException;  
import java.io.InputStream;  
import java.util.Arrays;  
import java.util.List;  
  
import org.apache.lucene.analysis.Analyzer;  
import org.apache.lucene.document.Document;  
import org.apache.lucene.document.Field;  
import org.apache.lucene.document.Field.Index;  
import org.apache.lucene.document.Field.Store;  
import org.apache.lucene.index.IndexWriter;  
import org.apache.lucene.index.IndexWriter.MaxFieldLength;  
  
import jeasy.analysis.MMAnalyzer;  
  
public class CreateIndex {  
    /** 
     * 创建索引库 
     */  
    public static void initIndex() {  
        File fileDir = new File(System.getProperty("user.dir") + "/WEB-INF/index");  
        IndexWriter indexWriter = null;  
        try {  
            Analyzer analyzer = new MMAnalyzer(); // 极易中文分词器  
            //这里的true表示是否重新创建  
            indexWriter = new IndexWriter(fileDir, analyzer,true , MaxFieldLength.LIMITED);  
            List<File> fileList = getFiles();  
            int count = fileList.size();  
            for (int i = 0; i < count; i++) {  
                Document document = null;  
                document = fileToText(fileList.get(i));  
                indexWriter.addDocument(document);  
            }  
            System.out.println("创建索引库成功！");  
        } catch (Exception e) {  
            System.err.println("不能正确创建索引库");  
            fileDir.deleteOnExit(); // 如果创建索引库失败，则删除已经创建的索引目录，下次重新创建  
        } finally {  
            try {  
                if (indexWriter != null)  
                    indexWriter.close();  
            } catch (Exception e) {  
                System.err.println("不能关闭indexWriter");  
            }  
        }  
    }  
    /** 
     * 将文件内容封装成Document 
     * @param file 
     * @return 
     * @throws IOException 
     */  
    private static Document fileToText(File file) throws IOException {  
        Document document = new Document();  
        document.add(new Field("path",file.getAbsolutePath(),Store.YES,Index.NOT_ANALYZED));  
        document.add(new Field("colContent",getContent(file),Store.YES,Index.ANALYZED));  
        document.add(new Field("filename",file.getName(),Store.YES,Index.NOT_ANALYZED));
        return document;  
    }  
      
    /** 
     * 文档字符化 
     * @param file 
     * @return 
     */  
    public static String getContent(File file) {  
        byte[]buffer = new byte[1024];  
        StringBuffer sb = new StringBuffer();  
        try {  
            @SuppressWarnings("resource")
			InputStream in = new FileInputStream(file);  
            while(in.read(buffer) > 0) {  
                sb.append(new String(buffer));  
            }  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return sb.toString();  
    }  
    public static List<File> getFiles() {  
        File file = new File(System.getProperty("user.dir") + "/res/common/articlecontent");  
        return Arrays.asList(file.listFiles());  
    }  
      
//    public static void main(String[] args) {  
//        initIndex();  
//    }  
}  