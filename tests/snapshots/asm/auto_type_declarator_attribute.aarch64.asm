
auto_type_declarator_attribute.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x1, <page>
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x20]
               	add	x2, x2, #0x1
               	str	w2, [x1, #0x20]
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x2, [x0, #0x20]
               	cbz	w2, <addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	add	x2, x2, #0x1
               	str	w2, [x0, #0x20]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x1, #0xc]
               	cmp	w2, #0x2a
               	b.eq	<addr>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x0, #0x20]
               	add	x2, x2, #0x1
               	str	w2, [x0, #0x20]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x1, #0xc]
               	cmp	w1, #0x2a
               	b.eq	<addr>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x0, x1
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
