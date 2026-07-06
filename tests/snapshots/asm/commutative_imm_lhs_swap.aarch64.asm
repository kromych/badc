
commutative_imm_lhs_swap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x7                // =7
               	lsl	x1, x0, #2
               	sxtw	x1, w1
               	cmp	x1, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x1, x0, #0x3
               	sxtw	x1, w1
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x17, #0xf0              // =240
               	and	x1, x0, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x17, #0x10              // =16
               	orr	x1, x0, x17
               	cmp	x1, #0x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x17, #0xff              // =255
               	eor	x1, x0, x17
               	cmp	x1, #0xf8
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	cmp	x0, #0x1
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	x0, #0x1
               	cset	x1, ne
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x1, #0xa                // =10
               	sub	x1, x1, x0
               	sxtw	x1, w1
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	cmp	x0, #0x8
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
