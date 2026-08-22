
case_label_const_object.aarch64:	file format elf64-littleaarch64

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

<desig_and_static_init>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x1, x29, #0x20
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	mov	x3, #0x9                // =9
               	str	w3, [x1, #0x8]
               	mov	x2, #0x5                // =5
               	str	w2, [x1, #0x4]
               	sub	x2, x29, #0x10
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x2]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x2
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	w3, [x4]
               	mov	x3, #0x1                // =1
               	ldrsw	x1, [x1]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrsw	x1, [x2, #0x8]
               	cmp	x1, #0x7
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x3e8
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrsw	x0, [x4]
               	cmp	x0, #0x9
               	cset	x0, eq
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>

<stays_vla>:
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x10               // =16
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	mov	x1, #0x0                // =0
               	add	x2, x0, #0x0
               	str	w1, [x2]
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x4]
               	mov	x1, #0x2                // =2
               	str	w1, [x0, #0x8]
               	mov	x1, #0x3                // =3
               	str	w1, [x0, #0xc]
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x3
               	cset	x0, eq
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x6                // =6
               	mov	x0, #0x4                // =4
               	mov	x0, #0x2                // =2
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x3                // =3
               	mov	x0, #0x9                // =9
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
