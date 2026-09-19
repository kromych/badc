
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
               	jne	<addr>
               	movslq	0x28(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0xe0(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movslq	0xe4(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x0, 0x18(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0xdc(%rax)
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
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x20(%rax), %rax
               	cmpl	$0x28, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x65, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x1(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
