
scoped_state_loop_dead_arm.aarch64:	file format elf64-littleaarch64

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

<work>:
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	add	x1, x2, x1
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	mov	x2, #0x0                // =0
               	mov	x0, #0x3                // =3
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x4, [x3]
               	add	x4, x4, x1
               	str	x4, [x3]
               	add	x2, x2, #0x1
               	mov	w0, w0
               	cmp	x0, #0x2
               	b.lo	<addr>
               	cmp	x0, #0x3
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x1, x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	b	<addr>
               	mov	w3, w0
               	cmp	x3, #0x0
               	b.ne	<addr>
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
