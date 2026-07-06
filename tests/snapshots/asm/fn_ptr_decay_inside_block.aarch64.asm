
fn_ptr_decay_inside_block.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x90]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x1                // =1
               	mov	x9, x20
               	blr	x9
               	add	x21, x0, #0x0
               	mov	x0, #0x2                // =2
               	mov	x9, x20
               	blr	x9
               	add	x20, x21, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	mov	x9, x1
               	blr	x9
               	add	x20, x20, x0
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x48]
               	sub	x0, x29, #0x48
               	ldr	x0, [x0]
               	mov	x1, #0x4                // =4
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	add	x0, x20, x0
               	sxtw	x0, w0
               	cmp	x0, #0x19a
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
