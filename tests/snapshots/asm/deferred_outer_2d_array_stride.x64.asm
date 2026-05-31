
deferred_outer_2d_array_stride.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
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
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
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
               	callq	0x400877 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40039c <.text+0x11c>
               	leaq	0xfd74(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40039c <.text+0x11c>
               	leaq	0xfd55(%rip), %r12      # 0x4100f8
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x30, %r11d
               	cmpq	$0x30, %r11
               	je	0x4003fc <.text+0x17c>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x10, %r9d
               	cmpq	$0x10, %r9
               	je	0x400421 <.text+0x1a1>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x10, %eax
               	cmpq	$0x10, %rax
               	je	0x400441 <.text+0x1c1>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd10(%rip), %r9       # 0x410158
               	movq	%r9, %rax
               	addq	$0x10, %rax
               	movq	%rax, %r8
               	subq	%r9, %r8
               	cmpq	$0x10, %r8
               	je	0x400477 <.text+0x1f7>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcda(%rip), %rax      # 0x410158
               	movq	%rax, %r8
               	addq	$0x20, %r8
               	movq	%rax, %r9
               	addq	$0x10, %r9
               	movq	%r8, %rax
               	subq	%r9, %rax
               	cmpq	$0x10, %rax
               	je	0x4004b3 <.text+0x233>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc9e(%rip), %r9       # 0x410158
               	movq	(%r9), %rax
               	movzbq	(%rax), %r9
               	movq	%r9, %rax
               	xorq	$0x41, %rax
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%rax, %r9
               	cmpq	$0x0, %r9
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400536 <.text+0x2b6>
               	leaq	0xfc5d(%rip), %r9       # 0x410158
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	xorq	$0x42, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x8(%rbp)
               	jmp	0x400536 <.text+0x2b6>
               	movq	-0x8(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x400555 <.text+0x2d5>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbfc(%rip), %r9       # 0x410158
               	movq	%r9, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	xorq	$0x43, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x10(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x4005cb <.text+0x34b>
               	leaq	0xfbb2(%rip), %rax      # 0x410158
               	movq	%rax, %r9
               	addq	$0x18, %r9
               	movq	(%r9), %rax
               	cmpq	$0x0, %rax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x10(%rbp)
               	jmp	0x4005cb <.text+0x34b>
               	movq	-0x10(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x4005ea <.text+0x36a>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb67(%rip), %r9       # 0x410158
               	movq	%r9, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %r9
               	cmpq	$0x0, %r9
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x18(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400660 <.text+0x3e0>
               	leaq	0xfb33(%rip), %r9       # 0x410158
               	movq	%r9, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	xorq	$0x44, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x18(%rbp)
               	jmp	0x400660 <.text+0x3e0>
               	movq	-0x18(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x40067f <.text+0x3ff>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x30, %r9d
               	cmpq	$0x30, %r9
               	je	0x4006a4 <.text+0x424>
               	movl	$0x9, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	cmpq	$0xc, %rax
               	je	0x4006c4 <.text+0x444>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfabd(%rip), %r9       # 0x410188
               	movq	%r9, %rax
               	addq	$0x2c, %rax
               	movslq	(%rax), %r9
               	cmpq	$0xc, %r9
               	je	0x4006f7 <.text+0x477>
               	movl	$0xb, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfa8a(%rip), %rax      # 0x410188
               	movq	%rax, %r9
               	addq	$0x10, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x5, %rax
               	je	0x400726 <.text+0x4a6>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
