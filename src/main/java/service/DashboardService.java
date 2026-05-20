package service;

import dao.DashboardDAO;
import model.ResumoEstoque;

import java.sql.SQLException;

// Service do dashboard. Mantem a regra de carregamento fora do controller.
public class DashboardService {

    private final DashboardDAO dashboardDAO = new DashboardDAO();

    public ResumoEstoque buscarResumo() throws SQLException {
        return dashboardDAO.buscarResumo();
    }
}
