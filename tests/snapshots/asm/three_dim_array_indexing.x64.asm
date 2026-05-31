
three_dim_array_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
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
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
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
               	leaq	<rip>, %r11
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
               	movslq	%r9d, %r9
               	movl	$0x3, %r8d
               	movslq	%r8d, %r8
               	addq	$0x3, %r8
               	movslq	%r8d, %r8
               	addq	$0x4, %r8
               	movslq	%r8d, %r8
               	cmpq	%r8, %r9
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	addq	$0x8, %r9
               	movzbq	(%r9), %r8
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r9, %rdi
               	addq	$0x2, %rdi
               	movzbq	(%rdi), %r11
               	addq	%r11, %r8
               	movslq	%r8d, %r8
               	addq	$0x3, %r9
               	movzbq	(%r9), %r11
               	addq	%r11, %r8
               	movslq	%r8d, %r8
               	movl	$0x13, %r11d
               	movslq	%r11d, %r11
               	addq	$0xb, %r11
               	movslq	%r11d, %r11
               	addq	$0xc, %r11
               	movslq	%r11d, %r11
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0x2, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r8
               	addq	$0x10, %r8
               	movzbq	(%r8), %r11
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movzbq	(%r9), %rdi
               	addq	%rdi, %r11
               	movslq	%r11d, %r11
               	movq	%r8, %rdi
               	addq	$0x2, %rdi
               	movzbq	(%rdi), %r9
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	addq	$0x3, %r8
               	movzbq	(%r8), %r9
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	movl	$0x23, %r9d
               	movslq	%r9d, %r9
               	addq	$0x13, %r9
               	movslq	%r9d, %r9
               	addq	$0x14, %r9
               	movslq	%r9d, %r9
               	cmpq	%r9, %r11
               	je	<addr>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %r9
               	xorq	$0x1, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x4, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	addq	$0xb, %r9
               	movzbq	(%r9), %r11
               	xorq	$0xc, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x5, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x17, %r11
               	movzbq	(%r11), %r9
               	xorq	$0x18, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x6, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	movq	%r9, %r11
               	addq	$0xc, %r11
               	movzbq	(%r11), %r8
               	movzbq	(%r9), %r11
               	subq	%r11, %r8
               	movslq	%r8d, %r8
               	cmpq	$0xc, %r8
               	je	<addr>
               	movl	$0x7, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r8
               	movq	%r8, %r11
               	addq	$0x4, %r11
               	movzbq	(%r11), %r9
               	movzbq	(%r8), %r11
               	subq	%r11, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x4, %r9
               	je	<addr>
               	movl	$0x8, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
