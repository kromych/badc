
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
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	mov	x3, #0x4                // =4
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0x4]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w3, [x0, #0x8]
               	b	<addr>
               	ldrsw	x3, [x0]
               	add	x1, x1, x3
               	add	x0, x0, #0x4
               	add	x3, x2, #0xc
               	cmp	x0, x3
               	b.lo	<addr>
               	sxtw	x0, w1
               	cmp	w0, #0x7
               	b.eq	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	mov	x3, #0x4                // =4
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0x4]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w3, [x0, #0x8]
               	b	<addr>
               	ldrsw	x3, [x0]
               	add	x1, x1, x3
               	add	x0, x0, #0x4
               	add	x3, x2, #0xc
               	cmp	x0, x3
               	b.lo	<addr>
               	sxtw	x0, w1
               	mov	x1, x0
               	mov	x0, x4
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
