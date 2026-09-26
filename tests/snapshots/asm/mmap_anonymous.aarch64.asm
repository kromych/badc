
mmap_anonymous.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x4000             // =16384
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	mov	x3, #0x22               // =34
               	mov	x4, #-0x1               // =-1
               	mov	x5, x0
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	add	x1, x0, #0x1, lsl #12   // =0x1000
               	mov	x2, #0x2                // =2
               	strb	w2, [x1]
               	add	x1, x0, #0x2, lsl #12   // =0x2000
               	mov	x2, #0x3                // =3
               	strb	w2, [x1]
               	add	x1, x0, #0x3, lsl #12   // =0x3000
               	mov	x2, #0x4                // =4
               	strb	w2, [x1]
               	mov	x1, #0x4000             // =16384
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
