package com.ecom.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.List;

import com.ecom.service.impl.OrderServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ecom.model.Category;
import com.ecom.model.Product;
import com.ecom.model.UserDtls;
import com.ecom.service.CategoryService;
import com.ecom.service.ProductService;
import com.ecom.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private OrderServiceImpl productOrderService;

    @ModelAttribute
    public void getUserDetails(Principal p, Model m) {
        if (p != null) {
            String email = p.getName();
            UserDtls userDtls = userService.getUserByEmail(email);
            m.addAttribute("user", userDtls);
        }
    }

    @GetMapping("/")
    public String index() {
        return "admin/index";
    }

    @GetMapping("/loadAddProduct")
    public String loadAddProduct(Model m) {
        List<Category> categories = categoryService.getAllCategory();
        m.addAttribute("categories", categories);
        return "admin/add_product";
    }

    @GetMapping("/category")
    public String category(Model m) {
        m.addAttribute("categorys", categoryService.getAllCategory());
        return "admin/category";
    }

    @PostMapping("/saveCategory")
    public String saveCategory(@ModelAttribute Category category, HttpSession session) {

        Boolean existCategory = categoryService.existCategory(category.getName());

        if (existCategory) {
            session.setAttribute("errorMsg", "Category Name already exists");
        } else {

            Category saveCategory = categoryService.saveCategory(category);

            if (ObjectUtils.isEmpty(saveCategory)) {
                session.setAttribute("errorMsg", "Not saved ! internal server error");
            } else {
                session.setAttribute("succMsg", "Saved successfully");
            }
        }

        return "redirect:/admin/category";
    }

    @GetMapping("/deleteCategory/{id}")
    public String deleteCategory(@PathVariable int id, HttpSession session) {
        Boolean deleteCategory = categoryService.deleteCategory(id);

        if (deleteCategory) {
            session.setAttribute("succMsg", "category delete success");
        } else {
            session.setAttribute("errorMsg", "something wrong on server");
        }

        return "redirect:/admin/category";
    }

    @GetMapping("/loadEditCategory/{id}")
    public String loadEditCategory(@PathVariable int id, Model m) {
        m.addAttribute("category", categoryService.getCategoryById(id));
        return "admin/edit_category";
    }

    @PostMapping("/updateCategory")
    public String updateCategory(@ModelAttribute Category category, HttpSession session){

        Category oldCategory = categoryService.getCategoryById(category.getId());

        if (!ObjectUtils.isEmpty(category)) {
            oldCategory.setName(category.getName());
            oldCategory.setIsActive(category.getIsActive());
        }

        Category updateCategory = categoryService.saveCategory(oldCategory);

        if (!ObjectUtils.isEmpty(updateCategory)) {
            session.setAttribute("succMsg", "Category update success");
        } else {
            session.setAttribute("errorMsg", "something wrong on server");
        }

        return "redirect:/admin/loadEditCategory/" + category.getId();
    }

    @PostMapping("/saveProduct")
    public String saveProduct(@ModelAttribute Product product, @RequestParam("file") MultipartFile image,
                              HttpSession session) throws IOException {

        String imageName = image.isEmpty() ? "default.jpg" : image.getOriginalFilename();

        product.setImage(imageName);
        Product saveProduct = productService.saveProduct(product);

        if (!ObjectUtils.isEmpty(saveProduct)) {

            File saveFile = new ClassPathResource("static/img").getFile();

            Path path = Paths.get(saveFile.getAbsolutePath() + File.separator + "product_img" + File.separator
                    + image.getOriginalFilename());

            // System.out.println(path);
            Files.copy(image.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

            session.setAttribute("succMsg", "Product Saved Success");
        } else {
            session.setAttribute("errorMsg", "something wrong on server");
        }

        return "redirect:/admin/loadAddProduct";
    }

    @GetMapping("/products")
    public String loadViewProduct(Model m) {
        m.addAttribute("products", productService.getAllProducts());
        return "admin/products";
    }

    @GetMapping("/deleteProduct/{id}")
    public String deleteProduct(@PathVariable int id, HttpSession session) {
        Boolean deleteProduct = productService.deleteProduct(id);
        if (deleteProduct) {
            session.setAttribute("succMsg", "Product delete success");
        } else {
            session.setAttribute("errorMsg", "Something wrong on server");
        }
        return "redirect:/admin/products";
    }

    @GetMapping("/editProduct/{id}")
    public String editProduct(@PathVariable int id, Model m) {
        m.addAttribute("product", productService.getProductById(id));
        m.addAttribute("categories", categoryService.getAllCategory());
        return "admin/edit_product";
    }

    @PostMapping("/updateProduct")
    public String updateProduct(@ModelAttribute Product product, @RequestParam("file") MultipartFile image,
                                HttpSession session, Model m) {

        Product oldProduct = productService.getProductById(product.getId());

        if (!ObjectUtils.isEmpty(oldProduct)) {
            oldProduct.setIsActive(product.getIsActive());
        }

        if (product.getPrice()  < 0) {
            session.setAttribute("errorMsg", "invalid Discount");
        } else {
            Product updateProduct = productService.updateProduct(product, image);
            if (!ObjectUtils.isEmpty(updateProduct)) {
                session.setAttribute("succMsg", "Product update success");
            } else {
                session.setAttribute("errorMsg", "Something wrong on server");
            }
        }
        return "redirect:/admin/editProduct/" + product.getId();
    }

    @GetMapping("/admins")
    public String listAdminUsers(Model model) {
        List<UserDtls> adminUsers = userService.getUsers("ROLE_ADMIN");
        model.addAttribute("users", adminUsers);
        return "admin/admin-list"; // Trả về view danh sách tài khoản admin
    }

    @GetMapping("/add")
    public String showAddUserForm(Model model) {
        model.addAttribute("user", new UserDtls());
        return "admin/add-user";
    }

    @PostMapping("/add")
    public String addUser(@ModelAttribute UserDtls user) {
        userService.saveUser(user);
        return "redirect:/admin/admins"; // Redirect to a list page after adding
    }

    @GetMapping("/edit/{id}")
    public String showEditUserForm(@PathVariable Integer id, Model model) {
        UserDtls user = userService.findUserById(id);
        model.addAttribute("user", user);
        return "/admin/edit-user";
    }

    @PostMapping("/edit/{id}")
    public String editUser(@PathVariable Integer id, @ModelAttribute UserDtls user) {
        user.setId(id); // Set the ID to ensure we're updating the correct user
        userService.saveUser(user);
        return "/admin/edit-user"; // Redirect to a list page after editing
    }

    @GetMapping("/list")
    public String listUsers(Model model) {
        List<UserDtls> users = userService.getUsers("ROLE_USER");
        System.out.println(users);// Lấy danh sách người dùng
        model.addAttribute("users", users);
        return "/admin/user-list"; // Return a view name for user list
    }

    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable Integer id) {
        userService.deleteUser(id); // Gọi phương thức xóa trong service
        return "/admin/user-list"; // Redirect to the list page after deletion
    }

    @GetMapping("/deleteAdmin/{id}")
    public String deleteAdmin(@PathVariable Integer id) {
        userService.deleteUser(id); // Gọi phương thức xóa trong service
        return "/admin/admin-list"; // Redirect to the list page after deletion
    }

//    @GetMapping("/users")
//    public String getAllUsers(Model m) {
//        List<UserDtls> users = userService.getUsers("ROLE_USER");
//        m.addAttribute("users", users);
//        return "/admin/users";
//    }

    @GetMapping("/orders")
    public String listOrders(Model model) {
        model.addAttribute("orders", productOrderService.getAllOrders());
        return "admin/OrderList"; // Tên file Thymeleaf
    }

    @GetMapping("/delete-order")
    public String deleteOrder(@RequestParam Integer id) {
        productOrderService.deleteOrder(id);
        return "admin/OrderList";
    }
}
