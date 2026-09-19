
thread_local_basic.aarch64:	file format elf64-littleaarch64

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
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldrsw	x1, [x0]
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x18
               	ldrsw	x2, [x1]
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x2, #0x7                // =7
               	str	w2, [x0]
               	mov	x2, #0x2a               // =42
               	str	w2, [x1]
               	ldrsw	x2, [x0]
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x2, [x1]
               	cmp	w2, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrsw	x2, [x0]
               	ldrsw	x1, [x1]
               	add	x1, x2, x1
               	str	w1, [x0]
               	mov	x0, x1
               	cmp	w0, #0x31
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
