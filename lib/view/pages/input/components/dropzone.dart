import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:waregraph/view/layout/components/dashed_rect.dart';

class DropZoneFile extends StatefulWidget {
  DropZoneFile({
    super.key,
    required this.body,
    this.onHoverDropChild,
    this.onCreatedDropzoneViewController,
    this.onLoaded,
    this.onError,
    this.onHover,
    this.onDrop,
    this.onDropMultiple,
    this.onLeave,
    this.width,
    this.height,
    this.margin,
    this.padding,
  });

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget body;
  final Widget? onHoverDropChild;
  DropzoneViewController? onCreatedDropzoneViewController;
  final Function()? onLoaded;
  final Function(String? ev)? onError;
  final Function()? onHover;
  final Function(dynamic item)? onDrop;
  final Function(List? items)? onDropMultiple;
  final Function()? onLeave;
  final double? width;
  final double? height;

  @override
  State<DropZoneFile> createState() => _DropZoneFileState();
}

class _DropZoneFileState extends State<DropZoneFile> {
  bool onHover = false;
  Widget onHoverWidget = const SizedBox();
  Widget body = const SizedBox();

  void hovered() {
    setState(() {
      onHover = true;
    });
    print('Dropzone has Hovered');
  }

  void leaved() {
    setState(() {
      onHover = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onHoverWidget = widget.onHoverDropChild ??
        Container(
          margin: widget.margin,
          width: widget.width ?? 400,
          height: widget.height ?? 400,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 4,
            //     blurRadius: 8,
            //     offset: const Offset(3, 3), // changes position of shadow
            //   ),
            // ],
          ),
          child: DashedRect(
            color: Colors.blueGrey.shade600,
            strokeWidth: 2.0,
            gap: 3.0,
            child: Center(
              child: Text('Drop Image Here'),
            ),
          ),
        );

    body = widget.body;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      width: widget.width ?? 300,
      height: widget.height ?? 300,
      child: Stack(
        children: [
          onHover ? onHoverWidget : body,
          DropzoneView(
            operation: DragOperation.copy,
            cursor: onHover ? CursorType.grab : CursorType.Default,
            // onCreated: (DropzoneViewController dvController) => controller = ctrl,
            onCreated: (DropzoneViewController dvController) =>
                widget.onCreatedDropzoneViewController != null
                    ? widget.onCreatedDropzoneViewController = dvController
                    : {},
            onLoaded: widget.onLoaded,
            onError: widget.onError,
            onHover: () {
              widget.onHover == null ? print('') : widget.onHover!();
              hovered();
            },
            onDrop: widget.onDrop ?? (dynamic ev) => print('Drop: $ev'),
            onDropMultiple: widget.onDropMultiple ??
                (List<dynamic>? ev) =>
                    print('Drop multiple: ${ev ?? 'no items'}'),
            onLeave: () {
              widget.onLeave == null ? print('') : widget.onLeave!();
              leaved();
            },
          ),
        ],
      ),
    );
  }
}
