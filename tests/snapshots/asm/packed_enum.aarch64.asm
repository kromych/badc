
packed_enum.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x8
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x8
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x8
               	mov	x1, #0xab               // =171
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	mov	x1, #0x100              // =256
               	strh	w1, [x0, #0x6]
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x2]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrh	w0, [x0, #0x6]
               	mov	x17, #0x100             // =256
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x8
               	ldrh	w0, [x0]
               	mov	x17, #0x1234            // =4660
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x4]
               	mov	x17, #0xab              // =171
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
