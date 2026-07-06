
socket_headers_abi.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x2                // =2
               	strh	w1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0, #0x2]
               	sub	x0, x29, #0x10
               	ldrh	w0, [x0, #0x2]
               	mov	x17, #0x1234            // =4660
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x40
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
