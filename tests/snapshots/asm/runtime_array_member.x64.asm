
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
               	leave
               	retq
               	cmpl	$0x6e, %edi
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	leave
               	retq
               	leaq	-0x78(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%ecx, 0x10(%rax)
               	movslq	-0x60(%rbp), %rsi
               	movl	%esi, (%rax)
               	movslq	-0x60(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, 0x4(%rax)
               	movslq	-0x60(%rbp), %rdi
               	movl	%edi, 0x10(%rax)
               	cmpl	$0xa, %esi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xb, %edx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	leave
               	retq
               	movq	%rcx, %rax
               	cmpl	$0xa, %edi
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	leave
               	retq
               	movslq	-0x60(%rbp), %rdi
               	movl	$0x1, %eax
               	movslq	-0x60(%rbp), %rdx
               	addq	$0x2, %rdx
               	movslq	-0x60(%rbp), %rsi
               	addq	$0x4, %rsi
               	cmpl	$0xa, %edi
               	jne	<addr>
               	movq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xc, %edx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	leave
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
               	leave
               	retq
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movl	%ecx, 0x18(%rax)
               	movslq	-0x60(%rbp), %rsi
               	movl	%esi, (%rax)
               	movslq	-0x60(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, 0x18(%rax)
               	cmpl	$0xa, %esi
               	movl	$0x1, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	cmpl	$0xb, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %r13
               	leave
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
               	leave
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
               	leave
               	retq
               	cmpl	$0x10, %r9d
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %r13
               	leave
               	retq
               	leaq	-0x78(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%ecx, 0x10(%rax)
               	movslq	-0x60(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, 0x10(%rax)
               	movslq	-0x60(%rbp), %rdi
               	movl	%edi, (%rax)
               	movslq	-0x60(%rbp), %rsi
               	addq	$0x2, %rsi
               	movl	%esi, 0x4(%rax)
               	cmpl	$0xa, %edi
               	movl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0xc, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %r13
               	leave
               	retq
               	cmpl	$0xb, %edx
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rsi
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
