
static_local_array_init_bounds.x64:	file format elf64-x86-64

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
               	cmpl	$0x11, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x33, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x44, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x62, %ecx
               	jne	<addr>
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x62, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpb	$0x0, 0x2(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0x3(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x78, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x79, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x78, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x79, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
