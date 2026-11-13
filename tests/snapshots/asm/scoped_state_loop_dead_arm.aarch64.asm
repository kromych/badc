
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
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x30]
               	add	x0, x2, x0
               	str	x0, [x1, #0x30]
               	ret

<main>:
               	mov	x2, #0x0                // =0
               	mov	x1, #0x3                // =3
               	adrp	x5, <page>
               	ldr	x0, [x5, #0x10]
               	adrp	x4, <page>
               	mov	x3, x2
               	cbz	w1, <addr>
               	ldr	x6, [x4, #0x30]
               	add	x6, x6, x0
               	str	x6, [x4, #0x30]
               	add	x3, x3, #0x1
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x3
               	b.lo	<addr>
               	ldr	x1, [x5, #0x10]
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, x2
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
