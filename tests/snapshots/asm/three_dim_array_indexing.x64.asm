
three_dim_array_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400437 <.text+0x177>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400345 <.text+0x85>
               	leaq	0xfde5(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
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
               	leaq	0xfdc5(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdb6(%rip), %rdi      # 0x41011e
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfda8(%rip), %rdi      # 0x410125
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400837 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003c7 <.text+0x107>
               	leaq	0xfd4e(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x4003c7 <.text+0x107>
               	leaq	0xfd32(%rip), %r12      # 0x410100
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
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
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movq	%r11, %rdi
               	addq	$0x2, %rdi
               	movzbq	(%rdi), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x3, %r11
               	movzbq	(%r11), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	0xfcfe(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	callq	0x4003f6 <.text+0x136>
               	movl	$0x3, %ebx
               	movslq	%ebx, %rbx
               	addq	$0x3, %rbx
               	movslq	%ebx, %rbx
               	addq	$0x4, %rbx
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %rax
               	je	0x40049c <.text+0x1dc>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcad(%rip), %rax      # 0x410150
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, %rdi
               	callq	0x4003f6 <.text+0x136>
               	movl	$0x13, %r12d
               	movslq	%r12d, %r12
               	addq	$0xb, %r12
               	movslq	%r12d, %r12
               	addq	$0xc, %r12
               	movslq	%r12d, %r12
               	cmpq	%r12, %rax
               	je	0x4004f9 <.text+0x239>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc50(%rip), %rax      # 0x410150
               	movq	%rax, %rbx
               	addq	$0x10, %rbx
               	movq	%rbx, %rdi
               	callq	0x4003f6 <.text+0x136>
               	movl	$0x23, %ebx
               	movslq	%ebx, %rbx
               	addq	$0x13, %rbx
               	movslq	%ebx, %rbx
               	addq	$0x14, %rbx
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %rax
               	je	0x400554 <.text+0x294>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbf5(%rip), %rax      # 0x410150
               	movzbq	(%rax), %rbx
               	xorq	$0x1, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400599 <.text+0x2d9>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbb0(%rip), %rbx      # 0x410150
               	addq	$0xb, %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0xc, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4005e5 <.text+0x325>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb64(%rip), %rax      # 0x410150
               	addq	$0x17, %rax
               	movzbq	(%rax), %rbx
               	xorq	$0x18, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400631 <.text+0x371>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb18(%rip), %rbx      # 0x410150
               	movq	%rbx, %rax
               	addq	$0xc, %rax
               	movzbq	(%rax), %r8
               	movzbq	(%rbx), %rax
               	subq	%rax, %r8
               	movslq	%r8d, %r8
               	cmpq	$0xc, %r8
               	je	0x40067a <.text+0x3ba>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfacf(%rip), %r8       # 0x410150
               	movq	%r8, %rax
               	addq	$0x4, %rax
               	movzbq	(%rax), %rbx
               	movzbq	(%r8), %rax
               	subq	%rax, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x4, %rbx
               	je	0x4006c3 <.text+0x403>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfa9e(%rip), %r12      # 0x410168
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40083d <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
