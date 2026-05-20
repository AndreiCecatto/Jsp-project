package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

// Utilitario simples para salvar imagens enviadas por multipart/form-data.
public class UploadUtil {

    public static String salvarImagem(HttpServletRequest req, String nomeCampo, String pasta) throws IOException {
        try {
            Part arquivo = req.getPart(nomeCampo);

            // Se o usuario nao selecionou arquivo, o caminho fica vazio no banco.
            if (arquivo == null || arquivo.getSize() == 0) {
                return null;
            }

            String nomeOriginal = Paths.get(arquivo.getSubmittedFileName()).getFileName().toString();
            String extensao = "";
            int ponto = nomeOriginal.lastIndexOf('.');
            if (ponto >= 0) {
                extensao = nomeOriginal.substring(ponto);
            }

            // UUID evita conflito quando dois uploads possuem o mesmo nome.
            String nomeArquivo = UUID.randomUUID() + extensao;
            String caminhoRelativo = "uploads/" + pasta + "/" + nomeArquivo;
            String caminhoReal = req.getServletContext().getRealPath("/") + caminhoRelativo;

            File destino = new File(caminhoReal);
            File diretorio = destino.getParentFile();
            if (!diretorio.exists()) {
                diretorio.mkdirs();
            }

            arquivo.write(caminhoReal);
            return caminhoRelativo.replace("\\", "/");
        } catch (Exception e) {
            throw new IOException("Nao foi possivel salvar a imagem enviada.", e);
        }
    }

    public static String manterImagemAtualSeNaoEnviarNova(String novaImagem, String imagemAtual) {
        if (novaImagem == null || novaImagem.isBlank()) {
            return imagemAtual;
        }
        return novaImagem;
    }
}
