
struct_array_elided_runtime.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<run>:
               	sxtw	x0, w0
               	add	x1, x0, #0x1
               	sxtw	x3, w1
               	add	x1, x0, #0x2
               	sxtw	x4, w1
               	add	x1, x0, #0x3
               	sxtw	x5, w1
               	sxtw	x2, w0
               	cmp	x2, x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sxtw	x3, w3
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	sxtw	x3, w4
               	add	x1, x0, #0x2
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sxtw	x3, w5
               	add	x1, x0, #0x3
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x1, x0, #0x3
               	sxtw	x3, w1
               	add	x1, x0, #0x4
               	sxtw	x4, w1
               	cmp	x2, x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	sxtw	x2, w3
               	add	x1, x0, #0x3
               	sxtw	x1, w1
               	cmp	x2, x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sxtw	x1, w4
               	add	x0, x0, #0x4
               	sxtw	x0, w0
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	x0, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x0, x20, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	b	<addr>
