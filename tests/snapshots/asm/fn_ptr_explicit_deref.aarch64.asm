
fn_ptr_explicit_deref.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<main>:
               	str	x20, [sp, #-0x70]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x28               // =40
               	ldur	x1, [x29, #-0x8]
               	mov	x9, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0x28               // =40
               	ldur	x1, [x29, #-0x8]
               	mov	x9, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	sub	x20, x29, #0x8
               	ldr	x0, [x20]
               	mov	x1, #0x28               // =40
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	ldr	x0, [x20]
               	mov	x1, #0x28               // =40
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
