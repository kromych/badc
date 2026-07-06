
bitop_common_type.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0xf000             // =61440
               	movk	x0, #0x4006, lsl #16
               	movk	x0, #0x1, lsl #32
               	mov	x1, #0x0                // =0
               	orr	x2, x0, x1
               	add	x2, x2, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mvn	x2, x1
               	and	x2, x0, x2
               	add	x2, x2, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	eor	x2, x0, x1
               	add	x2, x2, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x2, #0xf001             // =61441
               	movk	x2, #0x4006, lsl #16
               	movk	x2, #0x1, lsl #32
               	sub	x2, x2, #0x1
               	mov	x17, #0xf               // =15
               	orr	x2, x2, x17
               	add	x2, x2, #0x1
               	mov	x17, #0xf010            // =61456
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	orr	x2, x0, x1
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	orr	x2, x0, x1
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	orr	x0, x0, x1
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x0, x17
               	cset	x0, hi
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
