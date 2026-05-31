
comparison_imm_lhs_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40040d <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe06(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40034b <.text+0x8b>
               	leaq	0xfde2(%rip), %rdi      # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdbf(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfdad(%rip), %rsi      # 0x41011e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd9c(%rip), %r9       # 0x410125
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400797 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003d9 <.text+0x119>
               	leaq	0xfd3f(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003d9 <.text+0x119>
               	leaq	0xfd20(%rip), %r12      # 0x410100
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x5, %r11d
               	xorq	%r9, %r9
               	movl	%r9d, -0x18(%rbp)
               	movslq	%r11d, %r8
               	cmpq	$0x0, %r8
               	jle	0x400458 <.text+0x198>
               	movslq	-0x18(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	0x400458 <.text+0x198>
               	movslq	%r11d, %r9
               	cmpq	$0x0, %r9
               	jl	0x400482 <.text+0x1c2>
               	movslq	-0x18(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	0x400482 <.text+0x1c2>
               	movslq	%r11d, %r8
               	cmpq	$0xa, %r8
               	jge	0x4004ac <.text+0x1ec>
               	movslq	-0x18(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	0x4004ac <.text+0x1ec>
               	movslq	%r11d, %r9
               	cmpq	$0xa, %r9
               	jg	0x4004d6 <.text+0x216>
               	movslq	-0x18(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	0x4004d6 <.text+0x216>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	jbe	0x400506 <.text+0x246>
               	movslq	-0x18(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	0x400506 <.text+0x246>
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	jb	0x400536 <.text+0x276>
               	movslq	-0x18(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	0x400536 <.text+0x276>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0xa, %r8
               	jae	0x400566 <.text+0x2a6>
               	movslq	-0x18(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	0x400566 <.text+0x2a6>
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0xa, %r9
               	ja	0x400596 <.text+0x2d6>
               	movslq	-0x18(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	0x400596 <.text+0x2d6>
               	movslq	%r11d, %r8
               	cmpq	$0xa, %r8
               	jle	0x4005c4 <.text+0x304>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%r11d, %r9
               	cmpq	$0x0, %r9
               	jge	0x4005f2 <.text+0x332>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb57(%rip), %rbx      # 0x410150
               	movslq	-0x18(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40079d <printf>
               	movslq	%eax, %rax
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x8, %rax
               	jne	0x40062a <.text+0x36a>
               	xorq	%rax, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	0x400638 <.text+0x378>
               	movl	$0x3, %eax
               	movq	%rax, -0x30(%rbp)
               	jmp	0x400638 <.text+0x378>
               	movq	-0x30(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
