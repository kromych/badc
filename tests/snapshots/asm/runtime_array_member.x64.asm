
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
               	subq	$0xc0, %rsp
               	movq	%r13, (%rsp)
               	movl	$0xa, %eax
               	movl	%eax, -0x60(%rbp)
               	movslq	-0x60(%rbp), %rcx
               	movslq	-0x60(%rbp), %rax
               	incq	%rax
               	movslq	-0x60(%rbp), %rdx
               	addq	$0x2, %rdx
               	movslq	-0x60(%rbp), %rsi
               	addq	$0x3, %rsi
               	movslq	-0x60(%rbp), %rdi
               	addq	$0x64, %rdi
               	cmpl	$0xa, %ecx
               	movl	$0x1, %ecx
               	jne	<addr>
               	cmpl	$0xb, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0xc, %edx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xd, %esi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpl	$0x6e, %edi
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%ecx, 0x10(%rax)
               	movslq	-0x60(%rbp), %rdx
               	movl	%edx, (%rax)
               	movslq	-0x60(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, 0x4(%rax)
               	movslq	-0x60(%rbp), %rsi
               	movl	%esi, 0x10(%rax)
               	cmpl	$0xa, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpl	$0xb, %ecx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	0x8(%rax), %rdx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpl	$0xa, %esi
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x60(%rbp), %rax
               	movl	$0x1, %ecx
               	movslq	-0x60(%rbp), %rdx
               	addq	$0x2, %rdx
               	movslq	-0x60(%rbp), %rsi
               	addq	$0x4, %rsi
               	cmpl	$0xa, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xc, %edx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpl	$0xe, %esi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movl	%edx, 0x18(%rax)
               	movslq	-0x60(%rbp), %rsi
               	movl	%esi, (%rax)
               	movslq	-0x60(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, 0x18(%rax)
               	cmpl	$0xa, %esi
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movslq	0xc(%rax), %rsi
               	movl	$0x1, %ecx
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	0x10(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x14(%rax), %rax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpl	$0xb, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x60(%rbp), %rax
               	movslq	-0x60(%rbp), %rcx
               	incq	%rcx
               	movslq	-0x60(%rbp), %rdx
               	addq	$0x2, %rdx
               	movslq	-0x60(%rbp), %rsi
               	addq	$0x3, %rsi
               	movslq	-0x60(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	-0x60(%rbp), %r8
               	addq	$0x5, %r8
               	movslq	-0x60(%rbp), %r9
               	addq	$0x6, %r9
               	cmpl	$0xa, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0xb, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xc, %edx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpl	$0xd, %esi
               	movl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0xe, %edi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xf, %r8d
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpl	$0x10, %r9d
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%ecx, 0x10(%rax)
               	movslq	-0x60(%rbp), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, 0x10(%rax)
               	movslq	-0x60(%rbp), %rcx
               	movl	%ecx, (%rax)
               	movslq	-0x60(%rbp), %rsi
               	addq	$0x2, %rsi
               	movl	%esi, 0x4(%rax)
               	cmpl	$0xa, %ecx
               	movl	$0x1, %ecx
               	jne	<addr>
               	cmpl	$0xc, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpl	$0xb, %edx
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rsi
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
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
