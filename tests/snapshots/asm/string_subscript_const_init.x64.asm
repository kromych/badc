
string_subscript_const_init.x64:	file format elf64-x86-64

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

<f>:
               	leaq	<rip>, %rax
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7a, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>

<main>:
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x79, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x73, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x6a, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7a, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
