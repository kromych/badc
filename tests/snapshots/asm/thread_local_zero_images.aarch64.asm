
thread_local_zero_images.aarch64:	file format elf64-littleaarch64

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

<block>:
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0xe8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, x1
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x38
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x30
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0xc0
               	and	x0, x0, #0x1f
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x40
               	ldrb	w2, [x1, x0]
               	cbnz	x2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x64
               	b.lt	<addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0xa8
               	ldrsw	x1, [x0]
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x4]
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x8]
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0xc]
               	cbnz	x1, <addr>
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x40
               	mov	x2, #0x1                // =1
               	strb	w2, [x1, #0x63]
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x0, lsl #12   // =0x0
               	add	x2, x2, #0xc0
               	mov	x3, #0x2                // =2
               	strb	w3, [x2, #0x1f]
               	mrs	x3, TPIDR_EL0
               	add	x3, x3, #0x0, lsl #12   // =0x0
               	add	x3, x3, #0xe0
               	mov	x4, #0x4                // =4
               	str	w4, [x3]
               	mov	x4, #0x9                // =9
               	str	w4, [x0, #0xc]
               	mrs	x4, TPIDR_EL0
               	add	x4, x4, #0x0, lsl #12   // =0x0
               	add	x4, x4, #0x28
               	ldr	x4, [x4]
               	cmp	x4, #0x7
               	b.ne	<addr>
               	mrs	x4, TPIDR_EL0
               	add	x4, x4, #0x0, lsl #12   // =0x0
               	add	x4, x4, #0x30
               	ldrsw	x4, [x4, #0x4]
               	cmp	w4, #0x5
               	b.ne	<addr>
               	mrs	x4, TPIDR_EL0
               	add	x4, x4, #0x0, lsl #12   // =0x0
               	add	x4, x4, #0x20
               	ldr	x4, [x4]
               	ldrsw	x4, [x4]
               	cmp	w4, #0x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x1, #0x63]
               	ldrb	w2, [x2, #0x1f]
               	add	x1, x1, x2
               	ldrsw	x2, [x3]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0xc]
               	add	x0, x1, x0
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	w0, #0xc
               	b.ne	<addr>
               	bl	<addr>
               	cmp	w0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
