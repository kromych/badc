
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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x28(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xe0(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0xe4(%rax), %ecx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	0x10(%rax), %ecx
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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x64, %ecx
               	jne	<addr>
               	movl	0x18(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	jne	<addr>
               	movl	0x20(%rax), %ecx
               	cmpl	$0x28, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	movsbq	0x2(%rax), %rcx
               	cmpl	$0x63, %ecx
               	jne	<addr>
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x65, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x1(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
