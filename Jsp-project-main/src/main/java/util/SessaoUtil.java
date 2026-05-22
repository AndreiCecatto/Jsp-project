package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Usuario;

import java.io.IOException;

/*
 * Util centraliza a leitura da sessao.
 * Assim os controllers nao repetem a mesma regra em todas as telas protegidas.
 */
public class SessaoUtil {

    public static Usuario getUsuarioLogado(HttpServletRequest req) {
        HttpSession session = req.getSession(false);

        if (session == null) {
            return null;
        }

        return (Usuario) session.getAttribute("usuarioLogado");
    }

    public static boolean redirecionarSeNaoLogado(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (getUsuarioLogado(req) == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return true;
        }

        return false;
    }
}
