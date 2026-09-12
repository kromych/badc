
void_return.aarch64:	file format elf64-littleaarch64

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

<bump>:
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ret

<copy_pair>:
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	ret

<clamp>:
               	ldrsw	x1, [x0]
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	ret
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ret

<forward>:
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	ret

<pick>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	ret
               	mov	x0, #0x2                // =2
               	str	w0, [x1]
               	b	<addr>

<discard>:
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	ret

<through_typedef>:
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	ret

<call_last>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x4                // =4
               	str	w1, [x0]
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<count_down>:
               	sxtw	x0, w0
               	b	<addr>
               	ldrsw	x2, [x1]
               	add	x2, x2, x0
               	str	w2, [x1]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	ldursw	x2, [x29, #-0x8]
               	cbz	x2, <addr>
               	str	w1, [x0]
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	mov	x1, #0x4                // =4
               	str	w1, [x0]
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	sub	x1, x29, #0x8
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	b	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
