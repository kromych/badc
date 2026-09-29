
thread_local_block_static_shadow.aarch64:	file format elf64-littleaarch64

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

<bump_x>:
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x20
               	ldrsw	x0, [x1]
               	add	x2, x0, #0x1
               	str	w2, [x1]
               	ret

<bump_y>:
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x28
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x2
               	str	w1, [x0]
               	mov	x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldrsw	x0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	mov	x1, #0x9                // =9
               	str	w1, [x0]
               	bl	<addr>
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
