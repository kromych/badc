
msvc_decl_decorators.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x290              // =656
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<exported>:
               	mov	x0, #0x3                // =3
               	ret

<halt>:
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	mov	x2, #0x3                // =3
               	add	x1, x1, x2
               	str	w1, [x0]
               	sxtw	x0, w1
               	cmp	x0, #0xb
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
