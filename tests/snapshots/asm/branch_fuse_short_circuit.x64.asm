
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
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	leaq	<rip>, %rax
               	movl	(%rax), %r8d
               	cmpq	$-0x1, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rcx, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdi, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	%r8d, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	cmpq	$-0x1, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdx, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	xorq	%rdx, %rdx
               	xorq	%rsi, %rsi
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	movl	$0x2, %eax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	%rdx, %rdx
               	xorq	%rax, %rax
               	movl	$0x3, %eax
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpq	$-0x1, %rsi
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x64, %rsi
               	jbe	<addr>
               	movl	$0x2, %eax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	cmpq	$-0x1, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rcx, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdi, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x64, %rsi
               	jbe	<addr>
               	movl	$0x2, %eax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x64, %rsi
               	jbe	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
