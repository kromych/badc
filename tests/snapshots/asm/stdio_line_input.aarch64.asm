
stdio_line_input.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	bl	<addr>
               	mov	x20, x0
               	stur	xzr, [x29, #-0x50]
               	stur	xzr, [x29, #-0x48]
               	cbnz	x20, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x6                // =6
               	mov	x3, x20
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x7                // =7
               	mov	x3, x20
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x48
               	mov	x2, x20
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x50]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x48]
               	cmp	x0, #0x5
               	b.hs	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldur	x0, [x29, #-0x50]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x50]
               	ldrb	w0, [x0, #0x4]
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x48
               	mov	x2, x20
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldur	x0, [x29, #-0x50]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x50]
               	ldrb	w0, [x0, #0x5]
               	cbz	w0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x48
               	mov	x2, x20
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x50]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x48
               	mov	x2, x20
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x20
               	bl	<addr>
               	ldur	x0, [x29, #-0x50]
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	cbnz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x48]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x48
               	mov	x2, #0x3a               // =58
               	mov	x3, x20
               	bl	<addr>
               	cmp	x0, #0x6
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	cmp	x0, #0x7
               	b.hs	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldur	x0, [x29, #-0x50]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x6                // =6
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x50]
               	ldrb	w0, [x0, #0x6]
               	cbz	w0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x48
               	mov	x2, #0x3a               // =58
               	mov	x3, x20
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x50]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldur	x0, [x29, #-0x50]
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	mov	x21, x0
               	cbnz	x21, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x21
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x2a               // =42
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	mov	x2, x1
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x1, x29, #0x40
               	mov	x2, #0x40               // =64
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x9                // =9
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
