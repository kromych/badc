
struct_byval_param_followed_by_ptr.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	ldrsw	x0, [x2, #0xc]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x20, #0x1e              // =30
               	cbz	w20, <addr>
               	ldrsw	x3, [x2, #0xc]
               	mov	x2, x1
               	mov	x1, x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	w1, #0x1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	mov	x20, x1
               	mov	x1, x0
               	b	<addr>
