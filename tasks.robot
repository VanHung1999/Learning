*** Settings ***
Documentation    Orders robots from RobotSpareBin Industries Inc.
...              Saves the order HTML receipt as a PDF file.
...              Saves the screenshot of the ordered robot.
...              Embeds the screenshot of the robot to the PDF receipt.
...              Creates ZIP archive of the receipts and the images.
Library          RPA.Browser.Selenium
Library          RPA.HTTP
Library          RPA.Tables
Library          RPA.PDF
Library          RPA.Archive
Library          MyLibrary



*** Keywords ***
Open the robot order website
    Open Available Browser    https://robotsparebinindustries.com/#/robot-order
    Click Button    OK
*** Keywords ***
Get order for everyone
    ${table}=    Read table from CSV    orders.csv
    FOR    ${hang}    IN RANGE    0    20    1
        ${thongso}=    Get Table Row    ${table}    ${hang}
        Get order for person    ${thongso}
    END   
*** Keywords ***
Get order for person
    [Arguments]     ${thongso}
    Fill and order for everyone(head)    ${thongso}[Head]
        Fill and order for everyone(body)    ${thongso}[Body]
        Input Text    //input[@placeholder= 'Enter the part number for the legs']    ${thongso}[Legs]
        Input Text    address    ${thongso}[Address]
        Click Button    id:preview
        Wait Until Element Is Visible    id:robot-preview-image   
        Maximize Browser Window   
        Scroll Element Into View    id:robot-preview-image
        Sleep    0.5s
        Capture Element Screenshot    id:robot-preview-image    ${CURDIR}${/}output${/}image${/}robot_preview_${thongso}[Order number].png
        FOR    ${i}    IN RANGE    10
            Click Button    id:order
            ${thanhcong}=    Run Keyword And Return Status    Wait until element is visible    id:receipt    timeout=3
            Exit For Loop If    ${thanhcong}
            
        END
        
        ${receipt_html}=    Get Element Attribute    id:receipt    outerHTML
        Html To Pdf    ${receipt_html}    ${CURDIR}${/}output${/}pdf${/}hoa_don_thu_${thongso}[Order number].pdf
        #${files}=    Create List        
        #...    ${CURDIR}${/}output${/}pdf${/}hoa_don_thu_${thongso}[Order number].pdf
        #...    ${CURDIR}${/}output${/}image${/}robot_preview_${thongso}[Order number].png
        #Add Files To Pdf    ${files}    ${CURDIR}${/}output${/}pdf${/}hoa_don_thu_${thongso}[Order number].pdf
        Click Button    id:order-another
        Click button    OK
        
*** Keywords ***
Fill and order for everyone(head)
    [Arguments]    ${head}
    ${head_as_string} =    Convert To String    ${head}
    Select From List By Value    head    ${head_as_string}
*** Keywords ***
Fill and order for everyone(body)
    [Arguments]    ${body}
    IF    ${body} == 1
        Click Button    id:id-body-1
    ELSE IF    ${body} == 2
        Click Button    id:id-body-2
    ELSE IF    ${body} == 3
        Click Button    id:id-body-3
    ELSE IF    ${body} == 4
        Click Button    id:id-body-4
    ELSE IF    ${body} == 5
        Click Button    id:id-body-5
    ELSE IF    ${body} == 6
        Click Button    id:id-body-6
    END
*** Keywords ***
Download the orders file
    Download    https://robotsparebinindustries.com/orders.csv   overwrite=True
*** Keywords ***
Archive Folder
    Archive Folder With Zip
    ...    ${CURDIR}${/}output${/}pdf
    ...    pdf.zip
*** Keywords ***
Add img to pdf
    FOR    ${i}    IN RANGE    1    21    
        Add Image To Pdf    ${CURDIR}${/}output${/}pdf${/}hoa_don_thu_${i}.pdf
        ...    ${CURDIR}${/}output${/}image${/}robot_preview_${i}.png
        ...    ${i}
    END 

*** Tasks ***
Order robots from RobotSpareBin Industries Inc
    Open the robot order website
    Download the orders file
    Get order for everyone
    Add img to pdf
    Archive Folder
    






    
 


  
        
         
           
        
     
        
    
    

   
        
        
        
        
        
        
    
    
        
    
        
    
        
    
    

    
    

    

        

        
    

    



    

    
    
    

