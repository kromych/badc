
long_long_distinct.x64:	file format elf64-x86-64

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
               	callq	0x400847 <dlsym>
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
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400445 <.text+0x185>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40046e <.text+0x1ae>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400497 <.text+0x1d7>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4004c0 <.text+0x200>
               	movl	$0x4, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4004e9 <.text+0x229>
               	movl	$0x5, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movabsq	$0x123456789abcdef, %r10 # imm = 0x123456789ABCDEF
               	movq	%r11, %r9
               	cmpq	%r10, %r11
               	je	0x400522 <.text+0x262>
               	movl	$0x6, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r9
               	cmpq	$-0x1, %r9
               	je	0x400552 <.text+0x292>
               	movl	$0x7, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %r11d
               	movl	$0xc8, %r9d
               	movq	%r11, %r8
               	addq	%r9, %r8
               	cmpq	$0x12c, %r8             # imm = 0x12C
               	je	0x40058a <.text+0x2ca>
               	movl	$0x8, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r9
               	movl	$0xa, %r8d
               	movq	%r8, (%r9)
               	leaq	-0x40(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	movl	$0x14, %r11d
               	movq	%r11, (%r8)
               	leaq	-0x40(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x10, %r11
               	movl	$0x1e, %r9d
               	movq	%r9, (%r11)
               	leaq	-0x40(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r11
               	cmpq	$0x14, %r11
               	je	0x4005fc <.text+0x33c>
               	movl	$0x9, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%r8, %r9
               	addq	$0x10, %r9
               	movq	(%r9), %r8
               	cmpq	$0x1e, %r8
               	je	0x40062f <.text+0x36f>
               	movl	$0xa, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %r9
               	movl	$0x64, %r8d
               	movq	%r8, (%r9)
               	leaq	-0x60(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	movl	$0xc8, %r11d
               	movq	%r11, (%r8)
               	leaq	-0x60(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x10, %r11
               	movl	$0x12c, %r9d            # imm = 0x12C
               	movq	%r9, (%r11)
               	leaq	-0x60(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r11
               	cmpq	$0xc8, %r11
               	je	0x4006a1 <.text+0x3e1>
               	movl	$0xb, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%r8, %r9
               	addq	$0x10, %r9
               	movq	(%r9), %r8
               	cmpq	$0x12c, %r8             # imm = 0x12C
               	je	0x4006d4 <.text+0x414>
               	movl	$0xc, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfa75(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x40084d <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
