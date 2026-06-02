
switch_break_calls.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x0, #0x64               // =100
               	ret
               	mov	x0, #0xc8               // =200
               	ret
               	mov	x0, #0x12c              // =300
               	ret
               	mov	x0, #0x190              // =400
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	ldursw	x13, [x29, #-0x8]
               	mov	x0, x13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x64              // =100
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	mov	x14, #0xc8              // =200
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	mov	x14, #0x12c             // =300
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	mov	x14, #0x190             // =400
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x14, x0
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
