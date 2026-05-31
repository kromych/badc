
three_dim_array_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40045a <.text+0x19a>
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
               	callq	0x400887 <dlsym>
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
               	movq	%rdi, %r11
               	movzbq	(%r11), %r9
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %rdi
               	movq	%r9, %r8
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r11, %rdi
               	addq	$0x2, %rdi
               	movzbq	(%rdi), %r9
               	movq	%r8, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	movq	%r11, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r11
               	movq	%rdi, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	0xfcdb(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	callq	0x40040d <.text+0x14d>
               	movl	$0x3, %ebx
               	movslq	%ebx, %rbx
               	movq	%rbx, %r8
               	addq	$0x3, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rbx
               	addq	$0x4, %rbx
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %rax
               	je	0x4004c5 <.text+0x205>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc84(%rip), %r8       # 0x410150
               	movq	%r8, %r12
               	addq	$0x8, %r12
               	movq	%r12, %rdi
               	callq	0x40040d <.text+0x14d>
               	movl	$0x13, %r12d
               	movslq	%r12d, %r12
               	movq	%r12, %r8
               	addq	$0xb, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %r12
               	addq	$0xc, %r12
               	movslq	%r12d, %r12
               	cmpq	%r12, %rax
               	je	0x400528 <.text+0x268>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc21(%rip), %r8       # 0x410150
               	movq	%r8, %rbx
               	addq	$0x10, %rbx
               	movq	%rbx, %rdi
               	callq	0x40040d <.text+0x14d>
               	movl	$0x23, %ebx
               	movslq	%ebx, %rbx
               	movq	%rbx, %r8
               	addq	$0x13, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rbx
               	addq	$0x14, %rbx
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %rax
               	je	0x400589 <.text+0x2c9>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbc0(%rip), %r8       # 0x410150
               	movzbq	(%r8), %rbx
               	movq	%rbx, %r8
               	xorq	$0x1, %r8
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r8, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4005d0 <.text+0x310>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb79(%rip), %r8       # 0x410150
               	movq	%r8, %rbx
               	addq	$0xb, %rbx
               	movzbq	(%rbx), %r8
               	movq	%r8, %rbx
               	xorq	$0xc, %rbx
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	cmpq	$0x0, %r8
               	je	0x400623 <.text+0x363>
               	movl	$0x5, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb26(%rip), %rbx      # 0x410150
               	movq	%rbx, %r8
               	addq	$0x17, %r8
               	movzbq	(%r8), %rbx
               	movq	%rbx, %r8
               	xorq	$0x18, %r8
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r8, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400674 <.text+0x3b4>
               	movl	$0x6, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfad5(%rip), %r8       # 0x410150
               	movq	%r8, %rbx
               	addq	$0xc, %rbx
               	movzbq	(%rbx), %rax
               	movzbq	(%r8), %rbx
               	movq	%rax, %r8
               	subq	%rbx, %r8
               	movslq	%r8d, %r8
               	cmpq	$0xc, %r8
               	je	0x4006c1 <.text+0x401>
               	movl	$0x7, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfa88(%rip), %rbx      # 0x410150
               	movq	%rbx, %r8
               	addq	$0x4, %r8
               	movzbq	(%r8), %rax
               	movzbq	(%rbx), %r8
               	movq	%rax, %rbx
               	subq	%r8, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x4, %rbx
               	je	0x40070d <.text+0x44d>
               	movl	$0x8, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfa54(%rip), %r12      # 0x410168
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40088d <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
