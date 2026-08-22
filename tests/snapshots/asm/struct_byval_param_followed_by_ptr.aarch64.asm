
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
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x22, #0x0               // =0
               	stur	w22, [x29, #-0x28]
               	sub	x1, x29, #0x28
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	cmp	x2, #0x2a
               	b.eq	<addr>
               	mov	x21, #0x1e              // =30
               	sxtw	x20, w21
               	cbz	x20, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldursw	x2, [x29, #-0x28]
               	ldrsw	x3, [x0]
               	mov	x0, x1
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldursw	x0, [x29, #-0x28]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x28]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x2, #0x1                // =1
               	str	w2, [x1]
               	mov	x21, x22
               	b	<addr>
