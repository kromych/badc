
struct_byval_param_followed_by_ptr.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x60]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x28]
               	sub	x1, x29, #0x28
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x2a
               	b.eq	<addr>
               	mov	x20, #0x1e              // =30
               	cbz	x20, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x21, w20
               	ldursw	x2, [x29, #-0x28]
               	ldrsw	x3, [x0]
               	mov	x0, x1
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldursw	x0, [x29, #-0x28]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x28]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x2, #0x1                // =1
               	str	w2, [x1]
               	mov	x20, x21
               	b	<addr>
