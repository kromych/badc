
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
               	movq	%rax, %r8
               	xorq	$0x6c, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xb8(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x40043e <.text+0x21e>
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	0x40043e <.text+0x21e>
               	movq	-0xb8(%rbp), %rax
               	movq	%rax, -0xb0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400494 <.text+0x274>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x64, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xb0(%rbp)
               	jmp	0x400494 <.text+0x274>
               	movq	-0xb0(%rbp), %r8
               	movq	%r8, -0xa8(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x4004e0 <.text+0x2c0>
               	movq	%r11, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa8(%rbp)
               	jmp	0x4004e0 <.text+0x2c0>
               	movq	-0xa8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400502 <.text+0x2e2>
               	movl	$0x1e, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xfbcb(%rip), %r11      # 0x4100d4
               	movzbq	(%r11), %rax
               	movq	%rax, %r8
               	xorq	$0x6c, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xd0(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x40057e <.text+0x35e>
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd0(%rbp)
               	jmp	0x40057e <.text+0x35e>
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0xc8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4005d4 <.text+0x3b4>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x75, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xc8(%rbp)
               	jmp	0x4005d4 <.text+0x3b4>
               	movq	-0xc8(%rbp), %r8
               	movq	%r8, -0xc0(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x400620 <.text+0x400>
               	movq	%r11, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xc0(%rbp)
               	jmp	0x400620 <.text+0x400>
               	movq	-0xc0(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400642 <.text+0x422>
               	movl	$0x1f, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xfa8f(%rip), %r11      # 0x4100d8
               	movzbq	(%r11), %rax
               	movq	%rax, %r8
               	xorq	$0x6c, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xe8(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x4006be <.text+0x49e>
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe8(%rbp)
               	jmp	0x4006be <.text+0x49e>
               	movq	-0xe8(%rbp), %rax
               	movq	%rax, -0xe0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400714 <.text+0x4f4>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x78, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xe0(%rbp)
               	jmp	0x400714 <.text+0x4f4>
               	movq	-0xe0(%rbp), %r8
               	movq	%r8, -0xd8(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x400760 <.text+0x540>
               	movq	%r11, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xd8(%rbp)
               	jmp	0x400760 <.text+0x540>
               	movq	-0xd8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400782 <.text+0x562>
               	movl	$0x20, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xf953(%rip), %r11      # 0x4100dc
               	movzbq	(%r11), %rax
               	movq	%rax, %r8
               	xorq	$0x64, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xf0(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x4007f3 <.text+0x5d3>
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xf0(%rbp)
               	jmp	0x4007f3 <.text+0x5d3>
               	movq	-0xf0(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400815 <.text+0x5f5>
               	movl	$0x21, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xf8c2(%rip), %r11      # 0x4100de
               	movzbq	(%r11), %rax
               	movq	%rax, %r8
               	xorq	$0x68, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x108(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x400891 <.text+0x671>
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x108(%rbp)
               	jmp	0x400891 <.text+0x671>
               	movq	-0x108(%rbp), %rax
               	movq	%rax, -0x100(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4008e7 <.text+0x6c7>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x64, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x100(%rbp)
               	jmp	0x4008e7 <.text+0x6c7>
               	movq	-0x100(%rbp), %r8
               	movq	%r8, -0xf8(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x400933 <.text+0x713>
               	movq	%r11, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xf8(%rbp)
               	jmp	0x400933 <.text+0x713>
               	movq	-0xf8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400955 <.text+0x735>
               	movl	$0x22, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xf786(%rip), %r11      # 0x4100e2
               	movzbq	(%r11), %rax
               	movq	%rax, %r8
               	xorq	$0x68, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x118(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x4009d1 <.text+0x7b1>
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x118(%rbp)
               	jmp	0x4009d1 <.text+0x7b1>
               	movq	-0x118(%rbp), %rax
               	movq	%rax, -0x110(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400a1e <.text+0x7fe>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %r11
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x110(%rbp)
               	jmp	0x400a1e <.text+0x7fe>
               	movq	-0x110(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400a40 <.text+0x820>
               	movl	$0x23, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xf69e(%rip), %r11      # 0x4100e5
               	movzbq	(%r11), %rax
               	movq	%rax, %r8
               	xorq	$0x6c, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x130(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x400abc <.text+0x89c>
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x130(%rbp)
               	jmp	0x400abc <.text+0x89c>
               	movq	-0x130(%rbp), %rax
               	movq	%rax, -0x128(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400b12 <.text+0x8f2>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x64, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x128(%rbp)
               	jmp	0x400b12 <.text+0x8f2>
               	movq	-0x128(%rbp), %r8
               	movq	%r8, -0x120(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x400b5e <.text+0x93e>
               	movq	%r11, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x120(%rbp)
               	jmp	0x400b5e <.text+0x93e>
               	movq	-0x120(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400b80 <.text+0x960>
               	movl	$0x24, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	0xf562(%rip), %r11      # 0x4100e9
               	movzbq	(%r11), %rax
               	movq	%rax, %r8
               	xorq	$0x6c, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x148(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x400bfc <.text+0x9dc>
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x148(%rbp)
               	jmp	0x400bfc <.text+0x9dc>
               	movq	-0x148(%rbp), %rax
               	movq	%rax, -0x140(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400c52 <.text+0xa32>
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x64, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x140(%rbp)
               	jmp	0x400c52 <.text+0xa32>
               	movq	-0x140(%rbp), %r8
               	movq	%r8, -0x138(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x400c9e <.text+0xa7e>
               	movq	%r11, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x138(%rbp)
               	jmp	0x400c9e <.text+0xa7e>
               	movq	-0x138(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400cc0 <.text+0xaa0>
               	movl	$0x25, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
