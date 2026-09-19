
thread_local_address_init.aarch64:	file format elf64-littleaarch64

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

<fn>:
               	mov	x0, #0x4                // =4
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldr	x0, [x0]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldr	x1, [x0]
               	ldrb	w1, [x1, #0x1]
               	mov	x17, #0x69              // =105
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0x2]
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x20
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x28
               	ldr	x2, [x1]
               	add	x3, x0, #0x4
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x30
               	ldr	x2, [x1]
               	add	x0, x0, #0x8
               	cmp	x2, x0
               	b.ne	<addr>
               	ldr	x0, [x1]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x38
               	ldr	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x4
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x40
               	ldr	x2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x2, x1
               	b.ne	<addr>
               	ldr	x2, [x0]
               	ldrsw	x2, [x2]
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x3, TPIDR_EL0
               	add	x3, x3, #0x0, lsl #12   // =0x0
               	add	x3, x3, #0x48
               	ldr	x4, [x3]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x4, x2
               	b.ne	<addr>
               	ldr	x3, [x3]
               	ldrsw	x3, [x3]
               	cmp	w3, #0x8
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x3, TPIDR_EL0
               	add	x3, x3, #0x0, lsl #12   // =0x0
               	add	x3, x3, #0x50
               	ldr	x3, [x3]
               	cmp	x3, x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x3, TPIDR_EL0
               	add	x3, x3, #0x0, lsl #12   // =0x0
               	add	x3, x3, #0x58
               	ldr	x3, [x3]
               	cbz	x3, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x3, TPIDR_EL0
               	add	x3, x3, #0x0, lsl #12   // =0x0
               	add	x3, x3, #0x60
               	ldr	x3, [x3]
               	cmp	x3, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x2, [x0]
               	ldrsw	x0, [x2]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	ldrsw	x0, [x1]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
