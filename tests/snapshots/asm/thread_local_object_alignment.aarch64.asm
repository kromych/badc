
thread_local_object_alignment.aarch64:	file format elf64-littleaarch64

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

<block_scope_boundaries>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	mov	x17, #0x7               // =7
               	and	x1, x0, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x30
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x48
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x60
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x2, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x2
               	str	d16, [x0]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x30
               	mov	x3, #0x3                // =3
               	str	x3, [x1]
               	mov	x4, #0x4                // =4
               	str	x4, [x1, #0x8]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x48
               	mov	x5, #0x5                // =5
               	str	x5, [x1]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x60
               	mov	x6, #0x6                // =6
               	str	x6, [x1]
               	mov	x7, #0x7                // =7
               	str	x7, [x1, #0x8]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	mov	x8, #0x1                // =1
               	strb	w8, [x1]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x20
               	mov	x8, #0x2                // =2
               	strb	w8, [x1]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x40
               	strb	w3, [x1]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x50
               	strb	w4, [x1]
               	ldr	d0, [x0]
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x48
               	ldr	x0, [x0]
               	cmp	x0, #0x5
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, x5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x30
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x1, x1, x0
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x60
               	ldr	x2, [x0]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, x6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldrb	w0, [x0]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x20
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x40
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x50
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, x7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>

<wide_array_boundary>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x80
               	mov	x17, #0xf               // =15
               	and	x1, x0, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	add	x1, x0, #0x10
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x1, #0x8                // =8
               	str	x1, [x0, #0x20]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x70
               	mov	x2, #0x1                // =1
               	strb	w2, [x1]
               	ldr	x0, [x0, #0x20]
               	add	x0, x0, #0x1
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
