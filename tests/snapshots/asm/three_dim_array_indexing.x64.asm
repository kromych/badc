
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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	movq	(%rax), %rax
               	movq	%rax, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rdi), %r9
               	movq	%rdi, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movq	%rdi, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x3, %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rdi, %r9
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
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	cmpq	$0xa, %r9
               	je	<addr>
               	movl	$0x1, %r11d
               	movq	%r11, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	addq	$0x8, %r9
               	movzbq	(%r9), %r11
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	movq	%r9, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x2a, %r11
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x10, %r11
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
               	movslq	%r9d, %r9
               	cmpq	$0x4a, %r9
               	je	<addr>
               	movl	$0x3, %r11d
               	movq	%r11, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	movzbq	(%r9), %r9
               	xorq	$0x1, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	addq	$0xb, %r9
               	movzbq	(%r9), %r9
               	xorq	$0xc, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x5, %r11d
               	movq	%r11, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	addq	$0x17, %r9
               	movzbq	(%r9), %r9
               	xorq	$0x18, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x6, %r11d
               	movq	%r11, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	movq	%r9, %r11
               	addq	$0xc, %r11
               	movzbq	(%r11), %r11
               	movzbq	(%r9), %r9
               	subq	%r9, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xc, %r11
               	je	<addr>
               	movl	$0x7, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
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
