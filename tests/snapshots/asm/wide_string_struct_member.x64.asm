
wide_string_struct_member.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x5, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpq	$0x68, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpq	$0x69, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0xc(%rax), %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rcx, %rcx
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
