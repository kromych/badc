
runtime_array_member.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %eax
               	movl	%eax, -0x60(%rbp)
               	movslq	-0x60(%rbp), %rax
               	movslq	-0x60(%rbp), %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	movslq	-0x60(%rbp), %rcx
               	addq	$0x2, %rcx
               	movslq	%ecx, %rsi
               	movslq	-0x60(%rbp), %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rdi
               	movslq	-0x60(%rbp), %rcx
               	addq	$0x64, %rcx
               	movslq	%ecx, %r8
               	cmpq	$0xa, %rax
               	movl	$0x1, %ecx
               	jne	<addr>
               	cmpq	$0xb, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0xc, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0xd, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x6e, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%ecx, 0x10(%rax)
               	movslq	-0x60(%rbp), %rcx
               	movl	%ecx, (%rax)
               	movslq	-0x60(%rbp), %rdx
               	incq	%rdx
               	movslq	%edx, %rsi
               	movl	%edx, 0x4(%rax)
               	movslq	-0x60(%rbp), %rdx
               	movl	%edx, 0x10(%rax)
               	cmpq	$0xa, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0xb, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movslq	0x8(%rax), %rsi
               	testq	%rsi, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xa, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x60(%rbp), %rax
               	movl	$0x1, %ecx
               	movslq	-0x60(%rbp), %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rdx
               	movslq	-0x60(%rbp), %rsi
               	addq	$0x4, %rsi
               	movslq	%esi, %rsi
               	cmpq	$0xa, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0xc, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xe, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movl	%edx, 0x18(%rax)
               	movslq	-0x60(%rbp), %rdx
               	movl	%edx, (%rax)
               	movslq	-0x60(%rbp), %rsi
               	incq	%rsi
               	movslq	%esi, %rdi
               	movl	%esi, 0x18(%rax)
               	cmpq	$0xa, %rdx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movslq	0xc(%rax), %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x10(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x14(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xb, %rdi
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x60(%rbp), %rax
               	movslq	-0x60(%rbp), %rcx
               	incq	%rcx
               	movslq	%ecx, %rcx
               	movslq	-0x60(%rbp), %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rdx
               	movslq	-0x60(%rbp), %rsi
               	addq	$0x3, %rsi
               	movslq	%esi, %rsi
               	movslq	-0x60(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	%edi, %rdi
               	movslq	-0x60(%rbp), %r8
               	addq	$0x5, %r8
               	movslq	%r8d, %r8
               	movslq	-0x60(%rbp), %r9
               	addq	$0x6, %r9
               	movslq	%r9d, %r9
               	cmpq	$0xa, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	cmpq	$0xb, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0xc, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xd, %rsi
               	movl	$0x1, %edx
               	jne	<addr>
               	cmpq	$0xe, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0xf, %r8
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x10, %r9
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%ecx, 0x10(%rax)
               	movslq	-0x60(%rbp), %rcx
               	incq	%rcx
               	movslq	%ecx, %rdi
               	movl	%ecx, 0x10(%rax)
               	movslq	-0x60(%rbp), %rcx
               	movl	%ecx, (%rax)
               	movslq	-0x60(%rbp), %rsi
               	addq	$0x2, %rsi
               	movslq	%esi, %r8
               	movl	%esi, 0x4(%rax)
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	cmpq	$0xc, %r8
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xb, %rdi
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
