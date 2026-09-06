
branch_fuse_short_circuit.x64:	file format elf64-x86-64

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
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edi
               	cmpq	$-0x1, %rcx
               	jne	<addr>
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rsi, %rsi
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	%edi, %edx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %ecx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	cmpq	$-0x1, %rcx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x64, %rcx
               	jbe	<addr>
               	movl	$0x2, %ecx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	movl	$0x3, %ecx
               	movq	%rcx, %rdx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rsi
               	movl	(%rsi), %esi
               	cmpq	$-0x1, %rdx
               	jne	<addr>
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	xorq	%rsi, %rsi
               	cmpq	$0x64, %rdx
               	jbe	<addr>
               	movl	$0x2, %edx
               	cmpq	$0x2, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$-0x1, %rdx
               	jne	<addr>
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rsi, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x64, %rdx
               	jbe	<addr>
               	movl	$0x2, %ecx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpq	$0x64, %rcx
               	jbe	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
