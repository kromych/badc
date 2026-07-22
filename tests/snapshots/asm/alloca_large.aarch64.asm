
alloca_large.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x100000           // =1048576
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	mov	sp, x1
               	mov	x0, #0x1                // =1
               	strb	w0, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	add	x0, x1, x17
               	mov	x2, #0x2                // =2
               	strb	w2, [x0]
               	mov	x0, #0x1000             // =4096
               	b	<addr>
               	add	x2, x1, x0
               	mov	x3, #0x3                // =3
               	strb	w3, [x2]
               	mov	x17, #0x1000            // =4096
               	add	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	cmp	x0, x17
               	b.lt	<addr>
               	ldrb	w0, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	add	x1, x1, x17
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
