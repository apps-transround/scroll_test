/*

C:/flutter/packages/flutter/lib/src/rendering/object.dart:2170

  void markNeedsPaint() {
    String id = '${objectRuntimeType(this, '<dont know>')} ${shortHash(this)} ${_needsPaint}';

    assert(owner == null || !owner!.debugDoingPaint);
    if (_needsPaint)
      return;
    _needsPaint = true;
    if (isRepaintBoundary) {
      assert(() {
        if (debugPrintMarkNeedsPaintStacks)
          debugPrintStack(label: 'markNeedsPaint() called for $this');
        return true;
      }());
      // If we always have our own layer, then we can just repaint
      // ourselves without involving any other nodes.
      assert(_layer is OffsetLayer);
      if (owner != null) {
        owner!._nodesNeedingPaint.add(this);
        owner!.requestVisualUpdate();
        PaintEventHandler.logEvent(PaintEvent(eventType: PaintEventType.markPaintBoundary, id: id));
      }
    } else if (parent is RenderObject) {
      final RenderObject parent = this.parent! as RenderObject;
      parent.markNeedsPaint();
      assert(parent == this.parent);
      PaintEventHandler.logEvent(PaintEvent(eventType: PaintEventType.markPaintUp, id: id));
    } else {
      assert(() {
        if (debugPrintMarkNeedsPaintStacks)
          debugPrintStack(label: 'markNeedsPaint() called for $this (root of render tree)');
        return true;
      }());
      // If we're the root of the render tree (probably a RenderView),
      // then we have to paint ourselves, since nobody else can paint
      // us. We don't add ourselves to _nodesNeedingPaint in this
      // case, because the root is always told to paint regardless.
      PaintEventHandler.logEvent(PaintEvent(eventType: PaintEventType.markPaintRoot, id: id));
      if (owner != null)
        owner!.requestVisualUpdate();
    }
  }


 */
