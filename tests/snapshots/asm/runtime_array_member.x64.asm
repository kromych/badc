
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
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
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
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
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
               	movslq	-0x60(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movslq	-0x60(%rbp), %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	leaq	-0x78(%rbp), %rsi
               	movl	%ecx, 0x4(%rsi)
               	movslq	-0x60(%rbp), %rcx
               	leaq	-0x78(%rbp), %rsi
               	movl	%ecx, 0x10(%rsi)
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0xb, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	movslq	0x8(%rax), %rdx
               	testq	%rdx, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x60(%rbp), %rcx
               	movl	$0x1, %eax
               	movslq	-0x60(%rbp), %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rdx
               	movslq	-0x60(%rbp), %rsi
               	addq	$0x4, %rsi
               	movslq	%esi, %rsi
               	cmpq	$0xa, %rcx
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
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movl	%ecx, 0x18(%rax)
               	movslq	-0x60(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movslq	-0x60(%rbp), %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	leaq	-0x80(%rbp), %rsi
               	movl	%ecx, 0x18(%rsi)
               	cmpq	$0xa, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xb, %rdx
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
               	movl	$0x1, %eax
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
               	movslq	-0x60(%rbp), %rax
               	incq	%rax
               	movslq	%eax, %rdx
               	leaq	-0x78(%rbp), %rcx
               	movl	%eax, 0x10(%rcx)
               	movslq	-0x60(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movslq	-0x60(%rbp), %rcx
               	addq	$0x2, %rcx
               	movslq	%ecx, %rsi
               	leaq	-0x78(%rbp), %rdi
               	movl	%ecx, 0x4(%rdi)
               	cmpq	$0xa, %rax
               	movl	$0x1, %ecx
               	jne	<addr>
               	cmpq	$0xc, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xb, %rdx
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
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
