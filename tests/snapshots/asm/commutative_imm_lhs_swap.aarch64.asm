
commutative_imm_lhs_swap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x7               // =7
               	sxtw	x14, w15
               	lsl	x14, x14, #2
               	sxtw	x14, w14
               	cmp	x14, #0x1c
               	b.eq	0x400258 <.text+0x38>
               	mov	x0, #0x1                // =1
               	ret
               	sxtw	x14, w15
               	add	x14, x14, #0x3
               	sxtw	x14, w14
               	cmp	x14, #0xa
               	b.eq	0x400274 <.text+0x54>
               	mov	x0, #0x2                // =2
               	ret
               	sxtw	x14, w15
               	mov	x17, #0xf0              // =240
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	0x400290 <.text+0x70>
               	mov	x0, #0x3                // =3
               	ret
               	sxtw	x14, w15
               	mov	x17, #0x10              // =16
               	orr	x14, x14, x17
               	cmp	x14, #0x17
               	b.eq	0x4002ac <.text+0x8c>
               	mov	x0, #0x4                // =4
               	ret
               	sxtw	x14, w15
               	mov	x17, #0xff              // =255
               	eor	x14, x14, x17
               	cmp	x14, #0xf8
               	b.eq	0x4002c8 <.text+0xa8>
               	mov	x0, #0x5                // =5
               	ret
               	sxtw	x14, w15
               	cmp	x14, #0x1
               	cset	x14, eq
               	cmp	x14, #0x0
               	b.eq	0x4002e4 <.text+0xc4>
               	mov	x0, #0x6                // =6
               	ret
               	sxtw	x14, w15
               	cmp	x14, #0x1
               	cset	x14, ne
               	cmp	x14, #0x1
               	b.eq	0x400300 <.text+0xe0>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x14, #0xa               // =10
               	sxtw	x0, w15
               	sub	x14, x14, x0
               	sxtw	x14, w14
               	cmp	x14, #0x3
               	b.eq	0x400320 <.text+0x100>
               	mov	x0, #0x8                // =8
               	ret
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	cset	x15, lt
               	cmp	x15, #0x0
               	b.ne	0x40033c <.text+0x11c>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
