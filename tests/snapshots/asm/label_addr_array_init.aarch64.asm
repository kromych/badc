
label_addr_array_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sxtw	x0, w0
               	stur	w0, [x29, #0x10]
               	adr	x0, <addr>
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	adr	x0, <addr>
               	sub	x1, x29, #0x18
               	str	x0, [x1, #0x8]
               	adr	x0, <addr>
               	sub	x1, x29, #0x18
               	str	x0, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x20]
               	sub	x0, x29, #0x18
               	ldursw	x1, [x29, #0x10]
               	ldr	x0, [x0, x1, lsl #3]
               	br	x0
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x20]
               	b	<addr>
               	mov	x0, #0x14               // =20
               	stur	w0, [x29, #-0x20]
               	b	<addr>
               	mov	x0, #0x1e               // =30
               	stur	w0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x20]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
