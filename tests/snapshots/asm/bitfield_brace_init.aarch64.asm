
bitfield_brace_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x14]
               	strb	w10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x8
               	ldrb	w14, [x13]
               	mov	x17, #0x3               // =3
               	and	x13, x14, x17
               	cmp	x13, #0x1
               	b.eq	0x400298 <.text+0x78>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	ldrb	w0, [x14]
               	asr	x14, x0, #2
               	mov	x17, #0x3               // =3
               	and	x0, x14, x17
               	cmp	x0, #0x2
               	b.eq	0x4002c8 <.text+0xa8>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	ldrb	w0, [x14]
               	asr	x14, x0, #4
               	mov	x17, #0x3               // =3
               	and	x0, x14, x17
               	cmp	x0, #0x3
               	b.eq	0x4002f8 <.text+0xd8>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	ldrb	w0, [x14]
               	asr	x14, x0, #6
               	mov	x17, #0x3               // =3
               	and	x0, x14, x17
               	cmp	x0, #0x0
               	b.eq	0x400328 <.text+0x108>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd1
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x14]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x14, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x14, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x14, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x15, x14
               	sub	x15, x29, #0x10
               	ldr	w0, [x15]
               	mov	x17, #0xff              // =255
               	and	x15, x0, x17
               	cmp	x15, #0xab
               	b.eq	0x400394 <.text+0x174>
               	mov	x15, #0x15              // =21
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w15, [x0]
               	asr	x0, x15, #8
               	mov	x17, #0x1               // =1
               	and	x15, x0, x17
               	cmp	x15, #0x1
               	b.eq	0x4003c8 <.text+0x1a8>
               	mov	x15, #0x16              // =22
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w15, [x0]
               	asr	x0, x15, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x15, x0, x17
               	mov	x17, #0x2345            // =9029
               	movk	x17, #0x1, lsl #16
               	cmp	x15, x17
               	b.eq	0x400408 <.text+0x1e8>
               	mov	x15, #0x17              // =23
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd5
               	mov	x15, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x15]
               	strb	w10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x14, x0
               	sub	x14, x29, #0x18
               	ldrb	w15, [x14]
               	mov	x17, #0x7               // =7
               	and	x14, x15, x17
               	cmp	x14, #0x7
               	b.eq	0x400458 <.text+0x238>
               	mov	x0, #0x1f               // =31
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	ldrb	w0, [x15]
               	asr	x15, x0, #3
               	mov	x17, #0x7               // =7
               	and	x0, x15, x17
               	cmp	x0, #0x7
               	b.eq	0x400488 <.text+0x268>
               	mov	x0, #0x20               // =32
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	ldrb	w0, [x15]
               	asr	x15, x0, #6
               	mov	x17, #0x3               // =3
               	and	x0, x15, x17
               	cmp	x0, #0x3
               	b.eq	0x4004b8 <.text+0x298>
               	mov	x0, #0x21               // =33
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd6
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x14, x15
               	sub	x14, x29, #0x20
               	ldrb	w0, [x14]
               	mov	x17, #0x3               // =3
               	and	x14, x0, x17
               	cmp	x14, #0x1
               	b.eq	0x40050c <.text+0x2ec>
               	mov	x14, #0x29              // =41
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrb	w14, [x0]
               	asr	x0, x14, #2
               	mov	x17, #0x3               // =3
               	and	x14, x0, x17
               	cmp	x14, #0x2
               	b.eq	0x400540 <.text+0x320>
               	mov	x14, #0x2a              // =42
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrb	w14, [x0]
               	asr	x0, x14, #4
               	mov	x17, #0x3               // =3
               	and	x14, x0, x17
               	cmp	x14, #0x0
               	b.eq	0x400574 <.text+0x354>
               	mov	x14, #0x2b              // =43
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrb	w14, [x0]
               	asr	x0, x14, #6
               	mov	x17, #0x3               // =3
               	and	x14, x0, x17
               	cmp	x14, #0x0
               	b.eq	0x4005a8 <.text+0x388>
               	mov	x14, #0x2c              // =44
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
