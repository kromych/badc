
static_init_logical_and.aarch64:	file format elf64-littleaarch64

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

<dispatch>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	w0, [x29, #-0x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x0, x0, #0x1
               	lsl	x0, x0, #3
               	add	x1, x1, x0
               	ldr	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, x0
               	ldr	x0, [x0]
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #-0x1               // =-1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x20]
               	and	x0, x0, #0x1
               	ldr	x0, [x1, x0, lsl #3]
               	br	x0
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	add	x0, x0, #0x1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	stur	w0, [x29, #-0x8]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0xd
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
