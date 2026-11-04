
wide_string_pointer_array.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x4c, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x1c(%rax), %eax
               	cmpl	$0x42, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x1c(%rax), %eax
               	cmpl	$0x46, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x20(%rax), %eax
               	cmpl	$0x6c, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x30(%rax), %eax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x43, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x44, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpl	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x63, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x78, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x79, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x68, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x69, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
