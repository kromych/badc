
builtin_library_alias_macro_shadow.aarch64:	file format elf64-littleaarch64

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

<__fortify_strlen>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x1, x0]
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x1, x0]
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x3               // =-3
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x5                // =5
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x65               // =101
               	mov	x2, #0x5                // =5
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x1
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x5                // =5
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x6c               // =108
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x6c               // =108
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x3
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x1, x0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0x6f              // =111
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp], #0x10
               	ret
               	strb	wzr, [x0]
               	mov	x2, #0x3                // =3
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x1, x0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp], #0x10
               	ret
               	strb	wzr, [x0, #0x3]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x1, x0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x3]
               	eor	x1, x1, #0x78
               	cbz	w1, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	ldrb	w0, [x1, #0x4]
               	mov	x17, #0x79              // =121
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x61               // =97
               	strb	w1, [x0]
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldrb	w1, [x0]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x1d               // =29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cbz	x0, <addr>
               	ldrb	w1, [x0]
               	cbz	w1, <addr>
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
