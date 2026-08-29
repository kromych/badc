
const_array_copy_member_fold.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rcx
               	movl	$0x1, %eax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movl	$0x1, %eax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	leaq	<rip>, %rax
               	movl	$0x8, %edx
               	movb	%dl, 0x7(%rax)
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movzbq	(%rax), %rdx
               	movzbq	0x1(%rax), %rsi
               	movzbq	0x2(%rax), %rdi
               	movzbq	0x3(%rax), %r8
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	xorq	$0x4, %rax
               	movl	%eax, %edx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rdx
               	andq	$0xff, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdi, %rdx
               	andq	$0xff, %rdx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	$0x1, %eax
               	movq	%rax, %rdx
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rdx
               	movzbq	0x2(%rax), %rsi
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	xorq	$0x3c, %rax
               	movl	%eax, %edx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rdx
               	movzbq	0x2(%rax), %rsi
               	movzbq	0x3(%rax), %rdi
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	xorq	$0x0, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
