package com.capgemini.cobigen.javaplugin.integrationtest;

import java.io.File;
import java.io.FileReader;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.SystemUtils;
import org.junit.Assert;
import org.junit.Test;

import com.capgemini.cobigen.api.CobiGen;
import com.capgemini.cobigen.api.CobiGenFactory;
import com.capgemini.cobigen.api.to.TemplateTo;
import com.capgemini.cobigen.impl.config.ContextConfiguration.ContextSetting;
import com.capgemini.cobigen.javaplugin.integrationtest.common.AbstractIntegrationTest;
import com.capgemini.cobigen.javaplugin.unittest.inputreader.testdata.TestClassWithAnnotationsContainingObjectArrays;
import com.capgemini.cobigen.javaplugin.util.JavaParserUtil;

import junit.framework.AssertionFailedError;

/**
 * Test suit for annotation retrieval from source code to be exposed in the generation model.
 */
public class AnnotationQueryingTest extends AbstractIntegrationTest {

    /**
     * Tests whether annotations with object array values are correctly accessible within the templates
     * @throws Exception
     *             test fails
     */
    @Test
    public void testAnnotationWithObjectArraysAsValues() throws Exception {
        CobiGen cobiGen = CobiGenFactory.create(cobigenConfigFolder.toURI());
        File tmpFolderCobiGen = tmpFolder.newFolder("cobigen_output");
        cobiGen.setContextSetting(ContextSetting.GenerationTargetRootPath,
            tmpFolderCobiGen.getAbsolutePath());

        String testFileRootPath = "src/test/resources/testdata/unittest/inputreader/";
        File javaSourceFile =
            new File(testFileRootPath + "TestClassWithAnnotationsContainingObjectArrays.java");
        Object[] input = new Object[] { JavaParserUtil.getFirstJavaClass(new FileReader(javaSourceFile)),
            TestClassWithAnnotationsContainingObjectArrays.class };
        List<TemplateTo> templates = cobiGen.getMatchingTemplates(input);

        boolean methodTemplateFound = false;
        for (TemplateTo template : templates) {
            if (template.getId().equals("annotationQuerying.txt")) {
                cobiGen.generate(input, template, false);
                File expectedFile = new File(tmpFolderCobiGen.getAbsoluteFile() + SystemUtils.FILE_SEPARATOR
                    + "annotationQuerying.txt");
                Assert.assertTrue(expectedFile.exists());
                Assert.assertEquals(
                    "TestClassWithAnnotationsContainingObjectArrays.class,TestClassWithAnnotations.class,",
                    FileUtils.readFileToString(expectedFile));
                methodTemplateFound = true;
                break;
            }
        }

        if (!methodTemplateFound) {
            throw new AssertionFailedError("Test template not found");
        }
    }
}
