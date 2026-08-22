
deferred_array_designator.x64:	file format elf64-x86-64

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
               	cmpl	$0x1, %ecx
               	movl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x28(%rax), %rdx
               	cmpl	$0x3, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0xe0(%rax), %rdx
               	cmpl	$0x5, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0xe4(%rax), %rdx
               	cmpl	$0x6, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x10(%rax), %rdx
               	cmpl	$0x7, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	0x18(%rax), %rsi
               	testl	%esi, %esi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	0xdc(%rax), %rax
               	testl	%eax, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x64, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpl	$0x1e, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x20(%rax), %rax
               	cmpl	$0x28, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	0x2(%rcx), %rcx
               	cmpl	$0x63, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x65, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
