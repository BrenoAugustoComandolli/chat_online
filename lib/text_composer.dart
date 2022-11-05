import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  const TextComposer(this.sendMensssage, {Key? key}) : super(key: key);

  final Function({String text, File image}) sendMensssage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  
  bool _isComposing = false;

  void _reset(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () async {
              final XFile? image = await _picker.pickImage(source: ImageSource.camera);

              if(image == null){
                return;
              }
              widget.sendMensssage(image: File(image.path));
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(hintText: 'Enviar uma mensagem'),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMensssage(text: text);
                _reset();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isComposing ? () {
              widget.sendMensssage(text: _controller.text);
              _reset();
            } : null,
          ),
        ],
      ),
    );
  }
}
