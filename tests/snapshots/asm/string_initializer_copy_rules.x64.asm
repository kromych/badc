
string_initializer_copy_rules.x64:	file format elf64-x86-64

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
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x5(%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsbq	0x6(%rax), %rcx
               	cmpl	$0x62, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x7(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x6(%rax), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x7(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x1(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x2(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x5(%rax)
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x2(%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x2(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x3(%rax)
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x7(%rax), %rax
               	cmpl	$0x66, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x8(%rax), %rax
               	cmpl	$0x67, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x9(%rax)
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x66, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x20(%rax), %rax
               	cmpl	$0x67, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x24(%rax)
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x68, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x69, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x5(%rax)
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x6(%rax), %rax
               	cmpl	$0x79, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x7(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x69, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x14(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x18(%rax)
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	xorl	%eax, %eax
               	retq
