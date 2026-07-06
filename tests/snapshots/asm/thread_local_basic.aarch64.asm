
thread_local_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x1, [x0]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x18
               	ldrsw	x1, [x1]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x18
               	mov	x2, #0x2a               // =42
               	str	w2, [x1]
               	ldrsw	x1, [x0]
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x18
               	ldrsw	x1, [x1]
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldrsw	x1, [x0]
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x18
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	str	w1, [x0]
               	sxtw	x0, w1
               	cmp	x0, #0x31
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
