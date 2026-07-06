
wide_string_literal_size.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	retq
               	jmp	<addr>
               	movl	$0x6, %eax
               	retq
               	jmp	<addr>
               	movl	$0x7, %eax
               	retq
               	jmp	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x61, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %esi
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpq	$0x62, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
