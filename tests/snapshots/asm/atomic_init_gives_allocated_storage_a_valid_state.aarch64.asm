
atomic_init_gives_allocated_storage_a_valid_state.aarch64:	file format elf64-littleaarch64

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

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrh	w16, [x1]
               	strh	w16, [x0]
               	ldrb	w16, [x1, #0x2]
               	strb	w16, [x0, #0x2]
               	cbnz	x20, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x1, #0xff               // =255
               	mov	x2, #0xffff             // =65535
               	strh	w2, [x20]
               	strb	w1, [x20, #0x2]
               	ldrh	w16, [x0]
               	strh	w16, [x20]
               	ldrb	w16, [x0, #0x2]
               	strb	w16, [x20, #0x2]
               	sub	x2, x29, #0x10
               	mov	x0, #0x3                // =3
               	mov	x3, #0x5                // =5
               	mov	x1, x20
               	bl	<addr>
               	ldurb	w0, [x29, #-0x10]
               	ldurb	w1, [x29, #-0xe]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x18
               	ldrh	w16, [x0]
               	strh	w16, [x1]
               	ldrb	w16, [x0, #0x2]
               	strb	w16, [x1, #0x2]
               	sub	x2, x29, #0x8
               	mov	x0, #0x3                // =3
               	mov	x3, #0x5                // =5
               	bl	<addr>
               	ldurb	w0, [x29, #-0x7]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
