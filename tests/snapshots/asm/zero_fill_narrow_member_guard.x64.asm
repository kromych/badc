
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
               	leaq	<rip>, %rsi
               	movl	$0x7, %eax
               	movl	%eax, (%rsi)
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movl	%eax, (%rdx)
               	xorq	%rdi, %rdi
               	movl	$0x2, %eax
               	movl	(%rcx), %r9d
               	jmp	<addr>
               	movslq	(%rdx), %rdi
               	incq	%rdi
               	movl	%edi, (%rdx)
               	movslq	(%rsi), %rdi
               	movl	%eax, %eax
               	cmpq	$0x2, %rax
               	jb	<addr>
               	movl	(%rcx), %eax
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	movl	$0x1, %eax
               	testq	%r8, %r8
               	jne	<addr>
               	movl	(%rcx), %eax
               	movl	%r9d, %r8d
               	cmpq	%r8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %r8
               	jmp	<addr>
               	movl	$0x1, %eax
               	xorq	%r8, %r8
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %r8
               	jmp	<addr>
               	movl	%eax, %r8d
               	testq	%r8, %r8
               	jne	<addr>
               	movslq	%edi, %rax
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
               	movl	%eax, (%rsi)
               	xorq	%rax, %rax
               	movl	%eax, (%rdx)
               	xorq	%rdi, %rdi
               	movl	$0x2, %eax
               	movl	(%rcx), %r9d
               	jmp	<addr>
               	movslq	(%rdx), %rdi
               	incq	%rdi
               	movl	%edi, (%rdx)
               	movslq	(%rsi), %rdi
               	movl	%eax, %eax
               	cmpq	$0x2, %rax
               	jb	<addr>
               	movl	(%rcx), %eax
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	movl	$0x1, %eax
               	testq	%r8, %r8
               	jne	<addr>
               	movl	(%rcx), %eax
               	movl	%r9d, %r8d
               	cmpq	%r8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %r8
               	jmp	<addr>
               	movl	$0x1, %eax
               	xorq	%r8, %r8
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %r8
               	jmp	<addr>
               	movl	%eax, %r8d
               	testq	%r8, %r8
               	jne	<addr>
               	movslq	%edi, %rax
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
