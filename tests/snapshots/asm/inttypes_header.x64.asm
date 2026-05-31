
inttypes_header.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x150, %rsp            # imm = 0x150
               	movabsq	$-0x4, %r11
               	movq	%r11, -0x20(%rbp)
               	movl	$0x4, %r9d
               	movq	%r9, -0x40(%rbp)
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400278 <.text+0x58>
               	movl	$0xb, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400296 <.text+0x76>
               	movl	$0xc, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002b4 <.text+0x94>
               	movl	$0xd, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002d2 <.text+0xb2>
               	movl	$0xe, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002f0 <.text+0xd0>
               	movl	$0xf, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40030e <.text+0xee>
               	movl	$0x10, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40032c <.text+0x10c>
               	movl	$0x11, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40034a <.text+0x12a>
               	movl	$0x12, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400368 <.text+0x148>
               	movl	$0x13, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400386 <.text+0x166>
               	movl	$0x14, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4003a4 <.text+0x184>
               	movl	$0x15, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4003c2 <.text+0x1a2>
               	movl	$0x16, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xfd07(%rip), %r11      # 0x4100d0
               	movzbq	(%r11), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400439 <.text+0x219>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	0x400439 <.text+0x219>
               	movq	-0xb8(%rbp), %rax
               	movq	%rax, -0xb0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40048d <.text+0x26d>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	jmp	0x40048d <.text+0x26d>
               	movq	-0xb0(%rbp), %rax
               	movq	%rax, -0xa8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4004d7 <.text+0x2b7>
               	addq	$0x3, %r11
               	movzbq	(%r11), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xa8(%rbp)
               	jmp	0x4004d7 <.text+0x2b7>
               	movq	-0xa8(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x4004f9 <.text+0x2d9>
               	movl	$0x1e, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xfbd4(%rip), %r8       # 0x4100d4
               	movzbq	(%r8), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400570 <.text+0x350>
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd0(%rbp)
               	jmp	0x400570 <.text+0x350>
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0xc8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4005c4 <.text+0x3a4>
               	movq	%r8, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x75, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc8(%rbp)
               	jmp	0x4005c4 <.text+0x3a4>
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0xc0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40060e <.text+0x3ee>
               	addq	$0x3, %r8
               	movzbq	(%r8), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xc0(%rbp)
               	jmp	0x40060e <.text+0x3ee>
               	movq	-0xc0(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400630 <.text+0x410>
               	movl	$0x1f, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xfaa1(%rip), %r11      # 0x4100d8
               	movzbq	(%r11), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4006a7 <.text+0x487>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe8(%rbp)
               	jmp	0x4006a7 <.text+0x487>
               	movq	-0xe8(%rbp), %rax
               	movq	%rax, -0xe0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4006fb <.text+0x4db>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x78, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	jmp	0x4006fb <.text+0x4db>
               	movq	-0xe0(%rbp), %rax
               	movq	%rax, -0xd8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400745 <.text+0x525>
               	addq	$0x3, %r11
               	movzbq	(%r11), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xd8(%rbp)
               	jmp	0x400745 <.text+0x525>
               	movq	-0xd8(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x400767 <.text+0x547>
               	movl	$0x20, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xf96e(%rip), %r8       # 0x4100dc
               	movzbq	(%r8), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xf0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4007d4 <.text+0x5b4>
               	addq	$0x1, %r8
               	movzbq	(%r8), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xf0(%rbp)
               	jmp	0x4007d4 <.text+0x5b4>
               	movq	-0xf0(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x4007f6 <.text+0x5d6>
               	movl	$0x21, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xf8e1(%rip), %r11      # 0x4100de
               	movzbq	(%r11), %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x108(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40086d <.text+0x64d>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x108(%rbp)
               	jmp	0x40086d <.text+0x64d>
               	movq	-0x108(%rbp), %rax
               	movq	%rax, -0x100(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4008c1 <.text+0x6a1>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x100(%rbp)
               	jmp	0x4008c1 <.text+0x6a1>
               	movq	-0x100(%rbp), %rax
               	movq	%rax, -0xf8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40090b <.text+0x6eb>
               	addq	$0x3, %r11
               	movzbq	(%r11), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xf8(%rbp)
               	jmp	0x40090b <.text+0x6eb>
               	movq	-0xf8(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x40092d <.text+0x70d>
               	movl	$0x22, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xf7ae(%rip), %r8       # 0x4100e2
               	movzbq	(%r8), %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x118(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4009a4 <.text+0x784>
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x118(%rbp)
               	jmp	0x4009a4 <.text+0x784>
               	movq	-0x118(%rbp), %rax
               	movq	%rax, -0x110(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4009ee <.text+0x7ce>
               	addq	$0x2, %r8
               	movzbq	(%r8), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x110(%rbp)
               	jmp	0x4009ee <.text+0x7ce>
               	movq	-0x110(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400a10 <.text+0x7f0>
               	movl	$0x23, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xf6ce(%rip), %r11      # 0x4100e5
               	movzbq	(%r11), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x130(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400a87 <.text+0x867>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x130(%rbp)
               	jmp	0x400a87 <.text+0x867>
               	movq	-0x130(%rbp), %rax
               	movq	%rax, -0x128(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400adb <.text+0x8bb>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x128(%rbp)
               	jmp	0x400adb <.text+0x8bb>
               	movq	-0x128(%rbp), %rax
               	movq	%rax, -0x120(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400b25 <.text+0x905>
               	addq	$0x3, %r11
               	movzbq	(%r11), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x120(%rbp)
               	jmp	0x400b25 <.text+0x905>
               	movq	-0x120(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x400b47 <.text+0x927>
               	movl	$0x24, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xf59b(%rip), %r8       # 0x4100e9
               	movzbq	(%r8), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x148(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400bbe <.text+0x99e>
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x148(%rbp)
               	jmp	0x400bbe <.text+0x99e>
               	movq	-0x148(%rbp), %rax
               	movq	%rax, -0x140(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400c12 <.text+0x9f2>
               	movq	%r8, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x140(%rbp)
               	jmp	0x400c12 <.text+0x9f2>
               	movq	-0x140(%rbp), %rax
               	movq	%rax, -0x138(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400c5c <.text+0xa3c>
               	addq	$0x3, %r8
               	movzbq	(%r8), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x138(%rbp)
               	jmp	0x400c5c <.text+0xa3c>
               	movq	-0x138(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400c7e <.text+0xa5e>
               	movl	$0x25, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
