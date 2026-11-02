
packed_nested_static_member.x64:	file format elf64-x86-64

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

<read_ro>:
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax # <addr>
               	addq	$0x9, %rax
               	shlq	$0x3, %rdi
               	addq	%rdi, %rax
               	movswq	0x4(%rax), %rax
               	addq	$0xb, %rax
               	retq

<write_rw>:
               	movl	$0x28, <rip> # <addr>
               	movw	$0x29, <rip> # <addr>
               	movl	$0x2a, <rip> # <addr>
               	retq

<grid_sum>:
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x19, %rdi, %rcx
               	addq	%rcx, %rax
               	leaq	0xa(%rdi), %rcx
               	movl	%ecx, 0x1(%rax)
               	movw	$0x14, <rip> # <addr>
               	movl	0x1(%rax), %eax
               	addq	$0x14, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x12, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x28, %edi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x28, %eax
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x29, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x1f, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
