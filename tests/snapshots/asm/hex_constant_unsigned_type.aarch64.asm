
hex_constant_unsigned_type.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	sxtw	x14, w15
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	eor	x13, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x13, x17
               	cmp	x14, #0x0
               	b.eq	0x400274 <.text+0x54>
               	mov	x0, #0x1                // =1
               	ret
               	sxtw	x13, w15
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	eor	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	cmp	x13, #0x0
               	b.eq	0x4002a4 <.text+0x84>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ret
               	sxtw	x0, w15
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x13, ne
               	cmp	x13, #0x0
               	b.ne	0x4002cc <.text+0xac>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	ret
               	mov	x0, #0x0                // =0
               	ret
