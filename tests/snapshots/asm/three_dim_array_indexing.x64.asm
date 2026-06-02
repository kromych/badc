
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %r11
               	movzbq	(%r11), %r9
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %r11
               	movzbq	(%r11), %r9
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movq	%r11, %r8
               	addq	$0x3, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	cmpq	$0xa, %r9
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movzbq	(%r9), %r8
               	movq	%r9, %rdi
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r9, %rdi
               	addq	$0x2, %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %r8
               	movslq	%r8d, %r8
               	cmpq	$0x2a, %r8
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movq	%r11, %r8
               	addq	$0x10, %r8
               	movzbq	(%r8), %r9
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movq	%r8, %rdi
               	addq	$0x2, %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	addq	$0x3, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x4a, %r9
               	je	<addr>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	movzbq	(%r11), %r9
               	xorq	$0x1, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0xb, %r9
               	movzbq	(%r9), %r9
               	xorq	$0xc, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x5, %r8d
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x17, %r9
               	movzbq	(%r9), %r9
               	xorq	$0x18, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x6, %r8d
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0xc, %r9
               	movzbq	(%r9), %r9
               	movzbq	(%r11), %r8
               	subq	%r8, %r9
               	movslq	%r9d, %r9
               	cmpq	$0xc, %r9
               	je	<addr>
               	movl	$0x7, %r8d
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movzbq	(%r9), %r9
               	movzbq	(%r11), %r11
               	subq	%r11, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x4, %r9
               	je	<addr>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
