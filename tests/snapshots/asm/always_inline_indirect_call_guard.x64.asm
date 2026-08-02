
always_inline_indirect_call_guard.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<read_at>:
               	movl	%edi, %eax
               	leaq	(%rax,%rax,2), %rax
               	movq	%rax, (%rsi)
               	xorq	%rax, %rax
               	retq

<write_at>:
               	movq	(%rsi), %rax
               	movl	%edi, %ecx
               	addq	%rcx, %rax
               	movq	%rax, (%rsi)
               	movl	$0x1, %eax
               	retq

<by_computed_goto>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdx, 0x20(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movl	%edi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	movq	%rdx, 0x30(%rbp)
               	leaq	<rip>, %rax
               	movsbq	0x18(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x10(%rax)
               	movl	$0x1, %ecx
               	movb	%cl, 0x18(%rax)
               	movq	%rcx, -0x10(%rbp)
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x10(%rbp)
               	movslq	0x10(%rbp), %rcx
               	movl	$0x3, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movl	0x20(%rbp), %ecx
               	movq	0x30(%rbp), %rbx
               	leaq	-<rip>, %rax       # <addr>
               	jmp	<addr>
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movl	0x20(%rbp), %ecx
               	movq	0x30(%rbp), %rsi
               	leaq	-<rip>, %rax       # <addr>
               	jmp	<addr>
               	shlq	%rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movl	0x20(%rbp), %eax
               	incq	%rax
               	movl	%eax, %ecx
               	movq	0x30(%rbp), %rbx
               	leaq	-<rip>, %rax       # <addr>
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	xorq	%rdx, %rdx
               	movl	%ecx, %edi
               	movq	%rbx, %rsi
               	callq	*%rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rbx)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movl	%ecx, %edi
               	callq	*%rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rcx, %rcx
               	incq	%rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movl	%ecx, %edi
               	movq	%rbx, %rsi
               	callq	*%rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rbx)
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r12
               	leaq	-<rip>, %rbx      # <addr>
               	xorq	%rax, %rax
               	movl	$0x5, %edi
               	movq	%rbx, %rax
               	movq	%r12, %rsi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, (%r12)
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xf, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r12
               	xorq	%rax, %rax
               	movl	$0x5, %edi
               	movq	%rbx, %rax
               	movq	%r12, %rsi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, (%r12)
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xf, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	leaq	-<rip>, %rax      # <addr>
               	xorq	%rcx, %rcx
               	movl	$0x5, %edi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rcx, %rcx
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r12
               	xorq	%rax, %rax
               	movl	$0x6, %edi
               	movq	%rbx, %rax
               	movq	%r12, %rsi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, (%r12)
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x12, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	xorq	%rdi, %rdi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x2, %edi
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r12
               	xorq	%rax, %rax
               	xorq	%rdi, %rdi
               	movq	%rbx, %rax
               	movq	%r12, %rsi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, (%r12)
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	(%rax), %r12
               	xorq	%rdi, %rdi
               	movq	%rdi, -0x8(%rbp)
               	xorq	%rsi, %rsi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %r12
               	movl	$0x1, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	leaq	-<rip>, %rax      # <addr>
               	xorq	%rcx, %rcx
               	movl	$0x1, %edi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rcx, %rcx
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %r12
               	movl	$0x1, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x1, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%r12, %rax
               	movl	$0x2, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$-0x1, %rcx
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	leaq	(%rax,%rcx), %r12
               	movl	$0x2, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%r12, %rax
               	movl	$0x3, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$-0x1, %rcx
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	leaq	(%rax,%rcx), %r12
               	movl	$0x3, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x3, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	(%r12,%rax), %r13
               	movl	$0x4, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r12
               	xorq	%rax, %rax
               	movl	$0x5, %edi
               	movq	%rbx, %rax
               	movq	%r12, %rsi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, (%r12)
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	(%r13,%rax), %rbx
               	movl	$0x4, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x4, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	movl	$0x5, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$-0x1, %rcx
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	leaq	(%rax,%rcx), %rbx
               	movl	$0x5, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x5, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	movl	$0x6, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$-0x1, %rcx
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	leaq	(%rax,%rcx), %rbx
               	movl	$0x6, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x6, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	movl	$0x7, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$-0x1, %rcx
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	leaq	(%rax,%rcx), %rbx
               	movl	$0x7, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x7, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	movl	$0x8, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$-0x1, %rcx
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	leaq	(%rax,%rcx), %rbx
               	movl	$0x8, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x8, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x9, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	leaq	-<rip>, %rax      # <addr>
               	xorq	%rcx, %rcx
               	movl	$0xb, %edi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rcx, %rcx
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x9, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x9, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	movl	$0xa, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$-0x1, %rcx
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	leaq	(%rax,%rcx), %rbx
               	movl	$0xa, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0xa, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	movl	$0xb, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$-0x1, %rcx
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	leaq	(%rax,%rcx), %rbx
               	movl	$0xb, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0xb, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	cmpq	$0x131, %rax            # imm = 0x131
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
