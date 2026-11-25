
inlined_struct_return_reads_its_object.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<pair>:
               	movq	(%rdi), %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$0x1, %rdi
               	movq	(%rsi), %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$0x1, %rsi
               	xorq	%rsi, %rdi
               	movq	%rdi, %rax
               	retq
               	incq	%rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	incq	%rax
               	movq	%rax, (%rdi)
               	jmp	<addr>

<walk>:
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	subq	%rcx, %rdx
               	addq	%rdx, %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rdi, %rcx
               	movq	(%rcx), %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	%rcx, %rdx
               	orq	$0x1, %rdx
               	jmp	<addr>
               	incq	%rdx
               	movq	%rdx, (%rcx)
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rsi, %rax
               	retq

<main>:
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x8(%rdi), %rsi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	movq	%rdi, %rcx
               	orq	$0x1, %rcx
               	leaq	0x8(%rdi), %rdx
               	xorq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	(%rsp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	0x8(%rsp), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	(%rsp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	0x8(%rsp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
