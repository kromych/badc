
pointer_to_array_arithmetic.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	addq	$0x10, %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	cmpq	$0x8, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	addq	$0x10, %rdx
               	movq	%rdx, %rsi
               	subq	%rax, %rsi
               	cmpq	$0x10, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rdx), %rsi
               	cmpq	$0x4, %rsi
               	setne	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movslq	0x4(%rdx), %rdx
               	cmpq	$0x5, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	jmp	<addr>
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	subq	%rax, %rcx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movslq	0x4(%rax), %rdx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x1, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	cmpq	$0x3, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x20, %rcx
               	addq	$-0x8, %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
