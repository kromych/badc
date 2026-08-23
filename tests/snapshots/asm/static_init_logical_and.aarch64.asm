
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
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #0x10]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x0, w0
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	lsl	x1, x0, #3
               	add	x0, x2, x1
               	ldr	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, x1
               	ldr	x1, [x1]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	ldursw	x1, [x29, #0x10]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	ldr	x0, [x0, x1, lsl #3]
               	br	x0
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, #0x1
               	add	x1, x1, #0x0
               	add	x1, x1, #0x1
               	add	x0, x1, #0x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0x14               // =20
               	stur	w0, [x29, #-0x8]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	bl	<addr>
               	cmp	x0, #0xd
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
