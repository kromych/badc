
case_range.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<classify>:
               	cmpl	$0x30, %edi
               	jge	<addr>
               	cmpl	$0x61, %edi
               	jge	<addr>
               	cmpl	$0x41, %edi
               	jge	<addr>
               	cmpl	$0x2d, %edi
               	jl	<addr>
               	cmpl	$0x2d, %edi
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x2b, %edi
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x5a, %edi
               	jg	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x7a, %edi
               	jle	<addr>
               	jmp	<addr>
               	cmpl	$0x39, %edi
               	jg	<addr>
               	movl	$0x1, %eax
               	retq

<count>:
               	xorq	%rax, %rax
               	cmpl	$0x1, %edi
               	jge	<addr>
               	cmpl	$0x4, %edi
               	je	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rax
               	retq
               	incq	%rax
               	jmp	<addr>
               	cmpl	$0x3, %edi
               	jg	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x30, %edi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	$0x35, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x39, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x61, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	$0x6d, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7a, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x41, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5a, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2b, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2d, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x24, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movq	%rax, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2f, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3a, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xb, %eax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xb, %eax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
