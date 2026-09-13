
epoll_event_array_readback.aarch64:	file format elf64-littleaarch64

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

<check>:
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x80000            // =524288
               	bl	<addr>
               	mov	x24, x0
               	cmp	w24, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x21, #0x7788            // =30600
               	movk	x21, #0x5566, lsl #16
               	movk	x21, #0x3344, lsl #32
               	movk	x21, #0x1122, lsl #48
               	mov	x22, #0x2211            // =8721
               	movk	x22, #0x4433, lsl #16
               	movk	x22, #0x6655, lsl #32
               	movk	x22, #0x8877, lsl #48
               	sub	x3, x29, #0x30
               	mov	x1, #0x1                // =1
               	str	w1, [x3]
               	str	x21, [x3, #0x8]
               	sxtw	x0, w24
               	sub	x2, x29, #0x40
               	ldrsw	x2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x3, x29, #0x30
               	str	x22, [x3, #0x8]
               	sxtw	x0, w24
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x38
               	ldrsw	x2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sxtw	x0, w24
               	sub	x23, x29, #0x20
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3e8              // =1000
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	mov	x20, x0
               	b	<addr>
               	sxtw	x1, w0
               	lsl	x3, x1, #4
               	add	x2, x23, x3
               	ldr	w2, [x2]
               	eor	x2, x2, #0x1
               	cbnz	x2, <addr>
               	sub	x4, x29, #0x20
               	add	x2, x4, x3
               	ldr	x5, [x2, #0x8]
               	cmp	x5, x21
               	b.ne	<addr>
               	orr	x20, x20, #0x1
               	b	<addr>
               	ldr	x2, [x2, #0x8]
               	cmp	x2, x22
               	b.ne	<addr>
               	orr	x20, x20, #0x2
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sxtw	x0, w24
               	bl	<addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0]
               	bl	<addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x4]
               	bl	<addr>
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0]
               	bl	<addr>
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0, #0x4]
               	bl	<addr>
               	cmp	w20, #0x3
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x9                // =9
               	b	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
