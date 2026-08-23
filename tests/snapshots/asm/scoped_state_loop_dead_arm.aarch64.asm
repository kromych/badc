
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
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3                // =3
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x4, x1
               	b	<addr>
               	ldr	x7, [x5]
               	add	x7, x7, x0
               	str	x7, [x5]
               	add	x4, x4, #0x1
               	cmp	w3, #0x2
               	b.lo	<addr>
               	cmp	w3, #0x3
               	b.lo	<addr>
               	ldr	x2, [x6]
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x2, x1
               	mov	x3, x1
               	b	<addr>
               	mov	x2, #0x1                // =1
               	mov	x3, x1
               	b	<addr>
               	mov	x2, x1
               	mov	x3, x1
               	b	<addr>
               	b	<addr>
               	mov	w3, w2
               	cbnz	x3, <addr>
               	cmp	x4, #0x1
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
