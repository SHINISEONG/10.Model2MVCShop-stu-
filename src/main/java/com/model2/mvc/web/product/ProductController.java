package com.model2.mvc.web.product;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
		///method for DI
		public void setProductService(ProductService productService) {
			this.productService = productService;
		}
	
	
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@Value("#{commonProperties['fileUploadPath']}")
	String fileUploadPath;
			
	///Constructor
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	///RequestMethod
	@RequestMapping("addProduct")
	public String addProduct(@ModelAttribute("product") Product product,
							 @RequestParam("file") MultipartFile file,
							 Model model) throws Exception {
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		product.setFileName(file.getOriginalFilename());
		file.transferTo(new File(fileUploadPath+product.getFileName()));
		productService.addProduct(product);
		model.addAttribute("fileName", product.getFileName());
		return "forward:/product/addProductView.jsp";
	}
	
	@RequestMapping("getProduct")
	public String getProduct(@RequestParam("prodNo") int prodNo, @RequestParam(value="menu", defaultValue="search") String menu, Model model) throws Exception {
		Product product = productService.getProduct(prodNo);
		System.out.println(product + "�a�򵤺�");
		product.setFileNames();
		
		model.addAttribute("product", product);
		model.addAttribute("menu", menu);
		return "forward:/product/getProductView.jsp";
	}
	
	@RequestMapping("listProduct")
	public String listProduct(@ModelAttribute("search") Search search , Model model,
							  @RequestParam(value="searchMinPrice", defaultValue = "0") int searchMinPrice, 
							  @RequestParam(value="searchMaxPrice", defaultValue = "0") int searchMaxPrice,
							  @RequestParam(value="searchOrderType", defaultValue = "orderByDateDESC") String searchOrderType
							  ) throws Exception {
		
		if (searchMaxPrice < searchMinPrice) {
			int tmp=0;
		
			tmp = searchMaxPrice;
			searchMaxPrice = searchMinPrice;
			searchMinPrice = tmp;
		}
		
		search.setSearchOrderType(searchOrderType);
		search.setSearchMinPrice(searchMinPrice);
		search.setSearchMaxPrice(searchMaxPrice);
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String,Object> map = productService.getProductList(search);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	
	
	
	@RequestMapping("updateProduct")
	public String updateProduct(@ModelAttribute("product") Product product , Model model,
								@RequestParam("menu") String menu,
								@RequestParam("file") MultipartFile file,
								MultipartHttpServletRequest files) throws Exception {
		
		if(files != null) {
			product.setFileName(file.getOriginalFilename());
			
			List<MultipartFile> fileList = files.getFiles("files");
			String filename = "";
		
			for(int i = 0; i<fileList.size(); i++) {
				String ext = fileList.get(i).getOriginalFilename().substring(fileList.get(i).getOriginalFilename().lastIndexOf("."));
				fileList.get(i).transferTo(new File(fileUploadPath+(UUID.randomUUID().toString()+ext)));
				filename += (i!=0)?(","+(fileList.get(i).getOriginalFilename())):(fileList.get(i).getOriginalFilename());
			}
			
			product.setFileName(filename);
		}
		
		productService.updateProduct(product);
		boolean updateChecker = true;
		model.addAttribute("updateChecker", updateChecker);
		
		return "redirect:/product/getProduct?prodNo=" + product.getProdNo() + "&menu="+menu;
	}	

}
