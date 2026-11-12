
deferred_jit_thread_local.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	str	w0, [x1, #0x30]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	ldrsw	x2, [x1]
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mrs	x3, TPIDR_EL0
               	add	x3, x3, #0x0, lsl #12   // =0x0
               	add	x3, x3, #0x14
               	ldrsw	x3, [x3]
               	mov	x17, #-0x3              // =-3
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x2, x2, x3
               	str	w2, [x1]
               	mov	x1, x2
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ret
