
zero_fill_narrow_member_guard.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movl	$0x2, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdi
               	movl	$0x7, %edx
               	movl	%edx, (%rdi)
               	leaq	<rip>, %rdx
               	xorq	%r8, %r8
               	movl	%r8d, (%rdx)
               	movl	(%rcx), %r9d
               	jmp	<addr>
               	movslq	(%rdx), %r8
               	incq	%r8
               	movl	%r8d, (%rdx)
               	movslq	(%rdi), %r8
               	cmpq	$0x2, %rsi
               	jb	<addr>
               	movl	(%rcx), %eax
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	(%rcx), %eax
               	movl	%r9d, %esi
               	cmpq	%rsi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0x1, %eax
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	%eax, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	%r8d, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	(%rdx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	movl	%eax, (%rcx)
               	movl	$0x9, %eax
               	movl	%eax, (%rdi)
               	xorq	%r8, %r8
               	movl	%r8d, (%rdx)
               	movl	$0x2, %eax
               	movl	(%rcx), %r9d
               	jmp	<addr>
               	movslq	(%rdx), %r8
               	incq	%r8
               	movl	%r8d, (%rdx)
               	movslq	(%rdi), %r8
               	cmpq	$0x2, %rsi
               	jb	<addr>
               	movl	(%rcx), %eax
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	(%rcx), %eax
               	movl	%r9d, %esi
               	cmpq	%rsi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0x1, %eax
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	%eax, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	%r8d, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	(%rdx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
