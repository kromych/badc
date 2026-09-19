
narrow_phi_reads.aarch64:	file format elf64-littleaarch64

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

<mix>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<join_masked>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	mov	w2, w1
               	cmp	w2, #0x80
               	b.hs	<addr>
               	and	x0, x1, #0xff
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	ret

<loop_masked>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x22, x0
               	mov	x20, #0x0               // =0
               	mov	x21, x20
               	b	<addr>
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x21, x0
               	and	x21, x0, #0xff
               	add	x20, x20, #0x1
               	cmp	w20, w22
               	b.lt	<addr>
               	mov	x17, #0x2a              // =42
               	eor	x0, x21, x17
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<count_u8>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x1, x1, #0x1
               	and	x1, x1, #0xff
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<count_s8>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x1, x1, #0x3
               	mov	x3, x1
               	sxtb	x1, w3
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<join_u16>:
               	mov	x1, x0
               	mov	x0, #0x7                // =7
               	cmp	w1, #0x3e8
               	b.le	<addr>
               	and	x0, x1, #0xffff
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<join_unmasked>:
               	mov	x2, x1
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x0
               	b.le	<addr>
               	mov	x1, x2
               	and	x0, x1, #0xff
               	sxtw	x0, w0
               	ret

<join_byte_as_signed>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x0
               	b.le	<addr>
               	and	x0, x1, #0xff
               	sxtb	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2a               // =42
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x12c              // =300
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0xbb
               	b.ne	<addr>
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	cmp	x0, #0x4c
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x2a
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	bl	<addr>
               	cmp	x0, #0xff
               	b.ne	<addr>
               	mov	x0, #0x100              // =256
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x12c              // =300
               	bl	<addr>
               	cmp	x0, #0x2c
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	bl	<addr>
               	cmp	x0, #0x7e
               	b.ne	<addr>
               	mov	x0, #0x2b               // =43
               	bl	<addr>
               	mov	x17, #-0x7f             // =-127
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x8
               	b.ne	<addr>
               	mov	x0, #0x1170             // =4464
               	movk	x0, #0x1, lsl #16
               	bl	<addr>
               	mov	x17, #0x1171            // =4465
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0xffff             // =65535
               	bl	<addr>
               	mov	x17, #0x10000           // =65536
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x1234             // =4660
               	bl	<addr>
               	cmp	x0, #0x34
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1234             // =4660
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #-0x2               // =-2
               	bl	<addr>
               	cmp	x0, #0xfe
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7f               // =127
               	bl	<addr>
               	cmp	x0, #0x7f
               	b.ne	<addr>
               	mov	x0, #0x80               // =128
               	bl	<addr>
               	mov	x17, #-0x80             // =-128
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1ff              // =511
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #-0x5               // =-5
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
