
tail_call_outside_return_block.x64:	file format elf64-x86-64

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

<make>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rcx, %r9
               	movslq	%r8d, %r8
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	cmpq	$0x3e8, %r8             # imm = 0x3E8
               	jle	<addr>
               	movl	%edi, %edi
               	movl	%esi, %esi
               	decq	%r8
               	movq	%r9, %rcx
               	popq	%rbp
               	jmp	<addr>
               	movl	%edi, %eax
               	cmpq	$0x40001, %rax          # imm = 0x40001
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	%esi, %eax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0x7, %r9
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x3, %r8
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%r8d, %r8
               	movl	%edi, %eax
               	movq	%rax, %rdi
               	orq	$0x40000, %rdi          # imm = 0x40000
               	movl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x18(%rax), %rcx
               	movq	(%rcx), %rcx
               	andq	$0x4, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	popq	%rbp
               	retq
               	leaq	0x10(%rax), %rcx
               	movq	(%rcx), %rcx
               	andq	$0x2, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	leaq	0x8(%rax), %rcx
               	movq	(%rcx), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	movq	(%rax), %rcx
               	andq	$0x40, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	xorq	%rdx, %rdx
               	movl	$0x7, %ecx
               	movl	$0x3, %r8d
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
