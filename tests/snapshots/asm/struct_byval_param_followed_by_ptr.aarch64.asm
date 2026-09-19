
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
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x2a
               	b.eq	<addr>
               	mov	x20, #0x1e              // =30
               	cbz	w20, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldursw	x2, [x29, #-0x8]
               	ldrsw	x3, [x0]
               	mov	x0, x1
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x2, #0x1                // =1
               	str	w2, [x1]
               	b	<addr>
