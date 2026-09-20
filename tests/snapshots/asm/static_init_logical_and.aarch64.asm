
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x0, x0, #0x1
               	lsl	x1, x0, #3
               	add	x2, x2, x1
               	ldr	x3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x2, x1
               	ldr	x1, [x1]
               	cmp	x3, x1
               	b.eq	<addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	ldr	x0, [x2, x0, lsl #3]
               	br	x0
               	mov	x0, #0xa                // =10
               	add	x0, x0, #0x1
               	add	x0, x0, #0x1
               	add	x0, x0, #0x1
               	ret
               	mov	x0, #0x14               // =20
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0xd
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
