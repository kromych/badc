
file_scope_asm_decls.x64:	file format elf64-x86-64

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

<export_me>:
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%rsp, %rax
               	movq	%rsp, %rcx
               	movq	%rbp, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rcx, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rsi, %rsi
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	cmpq	%rcx, %rax
               	jbe	<addr>
               	subq	%rcx, %rax
               	cmpq	$0x10000, %rax          # imm = 0x10000
               	jbe	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	jmp	<addr>
