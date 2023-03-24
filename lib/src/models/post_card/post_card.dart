import 'package:flutter/material.dart';

/// Card usado para os conteúdos provenientes
/// das collections do firebase.
/// Pode ser reutilizado em qualquer tela.
/// Gostei desse.
class PostCard extends StatefulWidget {
  const PostCard(
      {super.key, required this.titulo, required this.conteudo, this.imagem});

  final String titulo;
  final String conteudo;
  final String? imagem;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        color: const Color.fromARGB(255, 215, 254, 215),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        widget.titulo,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 1, 14, 31),
                            fontFamily: "PaytoneOne",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.conteudo,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 1, 14, 31),
                        fontFamily: "PaytoneOne",
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.imagem != null)
                    widget.imagem!.isNotEmpty
                        ? SizedBox(
                            width: 100,
                            height: 75,
                            child: Image.network(widget.imagem!))
                        : const SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
