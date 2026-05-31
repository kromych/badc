
libc_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400810 <.text+0x150>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x178]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40074c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a6
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ad
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x401258 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x4007d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x4007d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d8
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x401264 <strlen>
               	sxtw	x0, w0
               	mov	x14, x0
               	cmp	x14, #0x5
               	b.eq	0x400894 <.text+0x1d4>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1de
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x401264 <strlen>
               	sxtw	x0, w0
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.eq	0x4008ec <.text+0x22c>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1df
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e3
               	mov	x21, x19
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x401270 <strcmp>
               	sxtw	x0, w0
               	mov	x13, x0
               	cmp	x13, #0x0
               	b.eq	0x400954 <.text+0x294>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e7
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ee
               	mov	x21, x19
               	mov	x23, #0x3               // =3
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x21
               	bl	0x40127c <strncmp>
               	sxtw	x0, w0
               	mov	x12, x0
               	cmp	x12, #0x0
               	b.eq	0x4009c4 <.text+0x304>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1f5
               	mov	x20, x19
               	mov	x23, #0x6c              // =108
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x401288 <strchr>
               	mov	x21, x0
               	cmp	x21, #0x0
               	b.ne	0x400a20 <.text+0x360>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w23, [x21]
               	mov	x17, #0x6c              // =108
               	eor	x21, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x23, #0x0
               	b.eq	0x400a74 <.text+0x3b4>
               	mov	x23, #0x6               // =6
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x24, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1fb
               	mov	x21, x19
               	mov	x0, x24
               	mov	x1, x21
               	bl	0x401294 <strcpy>
               	mov	x20, x0
               	sub	x23, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ff
               	mov	x20, x19
               	mov	x0, x23
               	mov	x1, x20
               	bl	0x4012a0 <strcat>
               	mov	x24, x0
               	sub	x21, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x203
               	mov	x24, x19
               	mov	x0, x21
               	mov	x1, x24
               	bl	0x401270 <strcmp>
               	sxtw	x0, w0
               	mov	x23, x0
               	cmp	x23, #0x0
               	b.eq	0x400b14 <.text+0x454>
               	mov	x23, #0x7               // =7
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x20a
               	mov	x24, x19
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x401294 <strcpy>
               	mov	x21, x0
               	sub	x21, x29, #0x80
               	add	x23, x21, #0x2
               	sub	x24, x29, #0x80
               	mov	x21, #0x5               // =5
               	mov	x0, x23
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x4012ac <memmove>
               	mov	x22, x0
               	sub	x22, x29, #0x80
               	add	x21, x22, #0x2
               	ldrb	w22, [x21]
               	mov	x17, #0x30              // =48
               	eor	x21, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x21, x17
               	cmp	x22, #0x0
               	b.eq	0x400bb4 <.text+0x4f4>
               	mov	x22, #0x8               // =8
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x80
               	add	x22, x21, #0x6
               	ldrb	w21, [x22]
               	mov	x17, #0x34              // =52
               	eor	x22, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x22, x17
               	cmp	x21, #0x0
               	b.eq	0x400c10 <.text+0x550>
               	mov	x21, #0x9               // =9
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x215
               	mov	x22, x19
               	mov	x21, #0x7               // =7
               	adrp	x19, 0x410000
               	add	x19, x19, #0x21e
               	mov	x24, x19
               	mov	x23, #0x2a              // =42
               	mov	x0, x20
               	mov	x4, x23
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x22
               	bl	0x4012b8 <sprintf>
               	sxtw	x0, w0
               	mov	x10, x0
               	sub	x25, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x221
               	mov	x26, x19
               	mov	x0, x25
               	mov	x1, x26
               	bl	0x401270 <strcmp>
               	sxtw	x0, w0
               	mov	x24, x0
               	cmp	x24, #0x0
               	b.eq	0x400cb4 <.text+0x5f4>
               	mov	x24, #0xa               // =10
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x23, x29, #0x80
               	mov	x26, #0x10              // =16
               	adrp	x19, 0x410000
               	add	x19, x19, #0x229
               	mov	x24, x19
               	mov	x25, #0x63              // =99
               	mov	x0, x23
               	mov	x3, x25
               	mov	x2, x24
               	mov	x1, x26
               	bl	0x4012c4 <snprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	sub	x21, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22c
               	mov	x22, x19
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x401270 <strcmp>
               	sxtw	x0, w0
               	mov	x24, x0
               	cmp	x24, #0x0
               	b.eq	0x400d48 <.text+0x688>
               	mov	x24, #0xb               // =11
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x25, #0x20              // =32
               	mov	x0, x25
               	bl	0x4012d0 <isspace>
               	sxtw	x0, w0
               	mov	x24, x0
               	cmp	x24, #0x0
               	b.ne	0x400d98 <.text+0x6d8>
               	mov	x24, #0xc               // =12
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x35              // =53
               	mov	x0, x22
               	bl	0x4012dc <isdigit>
               	sxtw	x0, w0
               	mov	x24, x0
               	cmp	x24, #0x0
               	b.ne	0x400de8 <.text+0x728>
               	mov	x24, #0xd               // =13
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x25, #0x61              // =97
               	mov	x0, x25
               	bl	0x4012dc <isdigit>
               	sxtw	x0, w0
               	mov	x24, x0
               	cbz	x24, 0x400e34 <.text+0x774>
               	mov	x25, #0xe               // =14
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x51              // =81
               	mov	x0, x22
               	bl	0x4012e8 <isalpha>
               	sxtw	x0, w0
               	mov	x25, x0
               	cmp	x25, #0x0
               	b.ne	0x400e84 <.text+0x7c4>
               	mov	x25, #0xf               // =15
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0x7a              // =122
               	mov	x0, x24
               	bl	0x4012f4 <isalnum>
               	sxtw	x0, w0
               	mov	x25, x0
               	cmp	x25, #0x0
               	b.ne	0x400ed4 <.text+0x814>
               	mov	x25, #0x10              // =16
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x61              // =97
               	mov	x0, x22
               	bl	0x401300 <toupper>
               	sxtw	x0, w0
               	mov	x25, x0
               	cmp	x25, #0x41
               	b.eq	0x400f24 <.text+0x864>
               	mov	x25, #0x11              // =17
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0x5a              // =90
               	mov	x0, x24
               	bl	0x40130c <tolower>
               	sxtw	x0, w0
               	mov	x25, x0
               	cmp	x25, #0x7a
               	b.eq	0x400f74 <.text+0x8b4>
               	mov	x25, #0x12              // =18
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x66              // =102
               	mov	x0, x22
               	bl	0x401318 <isxdigit>
               	sxtw	x0, w0
               	mov	x25, x0
               	cmp	x25, #0x0
               	b.ne	0x400fc4 <.text+0x904>
               	mov	x25, #0x13              // =19
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22f
               	mov	x24, x19
               	mov	x0, x24
               	bl	0x401324 <atoi>
               	sxtw	x0, w0
               	mov	x25, x0
               	cmp	x25, #0x2a
               	b.eq	0x40101c <.text+0x95c>
               	mov	x25, #0x14              // =20
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x232
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x401324 <atoi>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x25, x17
               	b.eq	0x401084 <.text+0x9c4>
               	mov	x25, #0x15              // =21
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0xfffb            // =65531
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	0x401330 <abs>
               	sxtw	x0, w0
               	mov	x25, x0
               	cmp	x25, #0x5
               	b.eq	0x4010e0 <.text+0xa20>
               	mov	x25, #0x16              // =22
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ed239
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x40776c <exit+0x6430>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f97fc
               	tbz	w21, #0x6, 0x3ff7c0
               	<unknown>
               	cbnz	w16, 0x46f768
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400d74 <.text+0x6b4>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
		...
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x40133c <exit>
               	uxtb	w0, w0
               	mov	x14, x0
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ed301
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x407834 <exit+0x64f8>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f98c4
               	tbz	w21, #0x6, 0x3ff888
               	<unknown>
               	cbnz	w16, 0x46f830
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400e3c <.text+0x77c>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<dlsym>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe0]
               	br	x16

<strlen>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16

<strcmp>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	br	x16

<strncmp>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf8]
               	br	x16

<strchr>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x100]
               	br	x16

<strcpy>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x108]
               	br	x16

<strcat>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x110]
               	br	x16

<memmove>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x118]
               	br	x16

<sprintf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x120]
               	br	x16

<snprintf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x128]
               	br	x16

<isspace>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x130]
               	br	x16

<isdigit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x138]
               	br	x16

<isalpha>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x140]
               	br	x16

<isalnum>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x148]
               	br	x16

<toupper>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x150]
               	br	x16

<tolower>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x158]
               	br	x16

<isxdigit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x160]
               	br	x16

<atoi>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x168]
               	br	x16

<abs>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x170]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x178]
               	br	x16
