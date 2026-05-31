
string_literal_no_room_for_nul.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	ldrb	w14, [x15]
               	mov	x17, #0x65              // =101
               	eor	x15, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	cmp	x14, #0x0
               	b.eq	0x400288 <.text+0x68>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x0, x15, #0xf
               	ldrb	w15, [x0]
               	mov	x17, #0x6b              // =107
               	eor	x0, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	cmp	x15, #0x0
               	b.eq	0x4002d0 <.text+0xb0>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x0, x19
               	ldrb	w15, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	cmp	x15, #0x0
               	b.eq	0x400314 <.text+0xf4>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x0, x19
               	add	x15, x0, #0x4
               	ldrb	w0, [x15]
               	mov	x17, #0x6f              // =111
               	eor	x15, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x15, x17
               	cmp	x0, #0x0
               	b.eq	0x400358 <.text+0x138>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	add	x0, x15, #0x5
               	ldrb	w15, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x15, x17
               	cmp	x0, #0x0
               	b.eq	0x400394 <.text+0x174>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	add	x0, x15, #0x13
               	ldrb	w15, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x15, x17
               	cmp	x0, #0x0
               	b.eq	0x4003d0 <.text+0x1b0>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x114
               	mov	x15, x19
               	ldrb	w0, [x15]
               	mov	x17, #0x77              // =119
               	eor	x15, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x15, x17
               	cmp	x0, #0x0
               	b.eq	0x400410 <.text+0x1f0>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x114
               	mov	x15, x19
               	add	x0, x15, #0x4
               	ldrb	w15, [x0]
               	mov	x17, #0x64              // =100
               	eor	x0, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	cmp	x15, #0x0
               	b.eq	0x400458 <.text+0x238>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x114
               	mov	x0, x19
               	add	x15, x0, #0x5
               	ldrb	w0, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	cmp	x15, #0x0
               	b.eq	0x400498 <.text+0x278>
               	mov	x15, #0x9               // =9
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
