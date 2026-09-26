
for_init_declaration.aarch64:	file format elf64-littleaarch64

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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x1                // =1
               	str	w0, [x2]
               	mov	x0, #0x4                // =4
               	mov	x3, #0x2                // =2
               	str	w3, [x2, #0x4]
               	str	w0, [x2, #0x8]
               	mov	x0, x2
               	add	x3, x2, #0xc
               	cmp	x0, x3
               	b.hs	<addr>
               	ldrsw	x3, [x0]
               	add	x1, x1, x3
               	add	x0, x0, #0x4
               	add	x3, x2, #0xc
               	cmp	x0, x3
               	b.lo	<addr>
               	cmp	w1, #0x7
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	str	w2, [x3]
               	mov	x2, #0x4                // =4
               	mov	x4, #0x2                // =2
               	str	w4, [x3, #0x4]
               	str	w2, [x3, #0x8]
               	mov	x2, x3
               	add	x4, x3, #0xc
               	cmp	x2, x4
               	b.hs	<addr>
               	ldrsw	x4, [x2]
               	add	x1, x1, x4
               	add	x2, x2, #0x4
               	add	x4, x3, #0xc
               	cmp	x2, x4
               	b.lo	<addr>
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
