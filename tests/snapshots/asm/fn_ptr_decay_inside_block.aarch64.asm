
fn_ptr_decay_inside_block.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	sxtw	x0, w0
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x0               // =0
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x238
               	b	<addr>
               	adrp	x21, <page>
               	add	x21, x21, #0x238
               	mov	x0, #0x1                // =1
               	mov	x9, x21
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x0, x20, x0
               	sxtw	x20, w0
               	mov	x0, #0x2                // =2
               	mov	x9, x21
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x20, x20, x0
               	b	<addr>
               	cmp	x1, #0x0
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x20, w20
               	mov	x0, #0x3                // =3
               	mov	x9, x1
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x20, x20, x0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x238
               	stur	x0, [x29, #-0x48]
               	sxtw	x20, w20
               	sub	x0, x29, #0x48
               	ldr	x0, [x0]
               	mov	x1, #0x4                // =4
               	mov	x9, x0
               	str	x1, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x0, x20, x0
               	sxtw	x0, w0
               	cmp	x0, #0x19a
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
