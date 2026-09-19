
thread_local_initializer.aarch64:	file format elf64-littleaarch64

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
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	ldrsw	x0, [x1]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldrsw	x2, [x0]
               	mov	x17, #-0x3              // =-3
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x0, lsl #12   // =0x0
               	add	x2, x2, #0x20
               	ldrsw	x2, [x2]
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x2, [x1]
               	ldrsw	x0, [x0]
               	add	x0, x2, x0
               	str	w0, [x1]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
