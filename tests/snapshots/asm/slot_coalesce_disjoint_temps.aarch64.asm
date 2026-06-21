
slot_coalesce_disjoint_temps.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x90
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x2, x1
               	sxtw	x3, w1
               	cmp	x3, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	b	<addr>
               	sxtw	x3, w1
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	cbz	x3, <addr>
               	b	<addr>
               	sxtw	x1, w2
               	sxtw	x0, w0
               	cmp	x1, x0
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x3, w1
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sxtw	x4, w3
               	b	<addr>
               	sxtw	x3, w1
               	add	x3, x3, #0x7
               	sxtw	x4, w3
               	sxtw	x3, w4
               	cmp	x3, #0xa
               	cset	x5, gt
               	cbz	x5, <addr>
               	sxtw	x3, w4
               	cmp	x3, #0x64
               	cset	x5, lt
               	cbz	x5, <addr>
               	sxtw	x3, w4
               	sub	x3, x3, #0x1
               	sxtw	x5, w3
               	b	<addr>
               	sxtw	x3, w4
               	add	x3, x3, #0x1
               	sxtw	x5, w3
               	sxtw	x3, w5
               	mov	x6, #0x2                // =2
               	sdiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	cmp	x3, #0x0
               	cset	x6, eq
               	cbnz	x6, <addr>
               	sxtw	x3, w5
               	cmp	x3, #0x32
               	cset	x6, gt
               	cbz	x6, <addr>
               	sxtw	x3, w5
               	lsl	x3, x3, #1
               	sxtw	x6, w3
               	b	<addr>
               	sxtw	x6, w5
               	sxtw	x2, w2
               	sxtw	x3, w6
               	sxtw	x4, w4
               	add	x3, x3, x4
               	sxtw	x3, w3
               	sxtw	x4, w5
               	add	x3, x3, x4
               	sxtw	x3, w3
               	add	x2, x2, x3
               	sxtw	x3, w1
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	cbz	x3, <addr>
               	sxtw	x3, w1
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sxtw	x4, w3
               	sxtw	x3, w4
               	cmp	x3, #0xa
               	cset	x5, gt
               	cbz	x5, <addr>
               	b	<addr>
               	sxtw	x3, w1
               	add	x3, x3, #0x7
               	sxtw	x4, w3
               	b	<addr>
               	sxtw	x3, w4
               	cmp	x3, #0x64
               	cset	x5, lt
               	cbz	x5, <addr>
               	sxtw	x3, w4
               	sub	x3, x3, #0x1
               	sxtw	x5, w3
               	sxtw	x3, w5
               	mov	x6, #0x2                // =2
               	sdiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	cmp	x3, #0x0
               	cset	x6, eq
               	cbnz	x6, <addr>
               	b	<addr>
               	sxtw	x3, w4
               	add	x3, x3, #0x1
               	sxtw	x5, w3
               	b	<addr>
               	sxtw	x3, w5
               	cmp	x3, #0x32
               	cset	x6, gt
               	cbz	x6, <addr>
               	sxtw	x3, w5
               	lsl	x3, x3, #1
               	sxtw	x6, w3
               	sxtw	x0, w0
               	sxtw	x3, w6
               	sxtw	x4, w4
               	add	x3, x3, x4
               	sxtw	x3, w3
               	sxtw	x4, w5
               	add	x3, x3, x4
               	sxtw	x3, w3
               	add	x0, x0, x3
               	b	<addr>
               	sxtw	x6, w5
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
