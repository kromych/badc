
static_local_shadows_file_scope.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	w1, w1
               	ldr	x0, [x0, x1, lsl #3]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x7777            // =30583
               	movk	x17, #0x7777, lsl #16
               	movk	x17, #0x7777, lsl #32
               	movk	x17, #0x7777, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
