
inlined_struct_return_reads_its_object.x64:	file format elf64-x86-64

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

<pair>:
               	movq	(%rdi), %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$0x1, %rdi
               	movq	(%rsi), %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$0x1, %rsi
               	movq	%rdi, %rax
               	xorq	%rsi, %rax
               	retq
               	incq	%rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	incq	%rax
               	movq	%rax, (%rdi)
               	jmp	<addr>

<walk>:
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	subq	%rcx, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rdi, %rcx
               	movq	(%rcx), %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movq	%rcx, %rsi
               	orq	$0x1, %rsi
               	jmp	<addr>
               	incq	%rsi
               	movq	%rsi, (%rcx)
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x8(%rdi), %rsi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	%rdi, %rcx
               	orq	$0x1, %rcx
               	leaq	0x8(%rdi), %rdx
               	xorq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
